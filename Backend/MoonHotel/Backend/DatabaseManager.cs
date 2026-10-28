using MoonHotel.Models;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;


namespace MoonHotel.Backend
{
    public class DatabaseManager
    {
        private string connectionString ="server=localhost;database=moonhotel;user=root;password=Pari12345678";

        public MySqlConnection GetConnection()
        {
            MySqlConnection conn = new MySqlConnection(connectionString);
            return conn;
        }


        public bool CustomerExistsByNationalID(string nationalId)
        {
            using (var conn = GetConnection())
            {
                conn.Open();

                string query = "SELECT COUNT(*) " +
                               "FROM Customer " +
                               "WHERE NationalID = @NationalID";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@NationalID", nationalId);
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    return count > 0;
                }
            }
        }


        public uint AddCustomer(Customer customer, List<string> phoneNumbers)
        {
            using (var conn = GetConnection())
            {
                conn.Open();
                MySqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    string customerQuery = @"INSERT INTO Customer (NationalID, FirstName, LastName, BirthDate, City, Street, PostalCode) 
                            VALUES 
                            (@NationalID, @FirstName, @LastName, @BirthDate, @City, @Street, @PostalCode)";

                    uint newId;

                    using (MySqlCommand cmd = new MySqlCommand(customerQuery, conn, transaction))
                    {
                        cmd.Parameters.AddWithValue("@NationalID", customer.NationalID);
                        cmd.Parameters.AddWithValue("@FirstName", customer.FirstName);
                        cmd.Parameters.AddWithValue("@LastName", customer.LastName);
                        cmd.Parameters.AddWithValue("@BirthDate", (object?)customer.BirthDate ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@City", (object?)customer.City ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@Street", (object?)customer.Street ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@PostalCode", (object?)customer.PostalCode ?? DBNull.Value);

                        cmd.ExecuteNonQuery();

                        newId = (uint)cmd.LastInsertedId;
                    }

                    foreach (string phone in phoneNumbers)
                    {
                        string phoneQuery = "INSERT INTO CustomerPhone (CustomerID, PhoneNumber) VALUES (@CustomerID, @PhoneNumber)";
                        using (MySqlCommand cmdPhone = new MySqlCommand(phoneQuery, conn, transaction))
                        {
                            cmdPhone.Parameters.AddWithValue("@CustomerID", newId); 
                            cmdPhone.Parameters.AddWithValue("@PhoneNumber", phone);
                            cmdPhone.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    return newId; 
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw new Exception("Error in customer registration: " + ex.Message);
                }
            }
        }

        public List<Hotel> GetHotels()
        {
            List<Hotel> hotels = new List<Hotel>();

            using (var conn = GetConnection())
            {
                conn.Open();

                string query = "SELECT HotelID, HotelName FROM Hotel";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        hotels.Add(new Hotel
                        {
                            HotelID = reader.GetUInt32("HotelID"),
                            HotelName = reader.GetString("HotelName")
                        });
                    }
                }
            }

            return hotels;
        }

        public bool CreateReservationWithAvailability(uint hotelId, string roomNumber, Reservation res)
        {
            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();

                using (var transaction = conn.BeginTransaction())
                {
                    try
                    {
                        string getRoomQuery = @"SELECT RoomID 
                                        FROM Room
                                        WHERE RoomNumber = @RoomNumber
                                        AND HotelID = @HotelID";

                        uint roomId;

                        using (MySqlCommand cmd = new MySqlCommand(getRoomQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@RoomNumber", roomNumber);
                            cmd.Parameters.AddWithValue("@HotelID", hotelId);

                            object result = cmd.ExecuteScalar();

                            if (result == null)
                                throw new Exception("Room number not found in this hotel!");

                            roomId = Convert.ToUInt32(result);
                        }

                        string checkQuery = @"SELECT COUNT(*) FROM Reservation
                                      WHERE RoomID = @RoomID
                                      AND StatusID = 1
                                      AND (
                                          (@CheckIn BETWEEN CheckInDate AND CheckOutDate)
                                          OR
                                          (@CheckOut BETWEEN CheckInDate AND CheckOutDate)
                                          OR
                                          (CheckInDate BETWEEN @CheckIn AND @CheckOut)
                                      )";

                        using (MySqlCommand cmd = new MySqlCommand(checkQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@RoomID", roomId);
                            cmd.Parameters.AddWithValue("@CheckIn", res.CheckInDate);
                            cmd.Parameters.AddWithValue("@CheckOut", res.CheckOutDate);

                            int count = Convert.ToInt32(cmd.ExecuteScalar());

                            if (count > 0)
                                throw new Exception("❌ This room is already reserved for selected dates!");
                        }

                        string insertQuery = @"INSERT INTO Reservation 
                                       (CheckInDate, CheckOutDate, NumberOfGuests, CustomerID, RoomID, StatusID)
                                       VALUES
                                       (@CheckIn, @CheckOut, @Guests, @CustomerID, @RoomID, @StatusID)";

                        using (MySqlCommand cmd = new MySqlCommand(insertQuery, conn, transaction))
                        {
                            cmd.Parameters.AddWithValue("@CheckIn", res.CheckInDate);
                            cmd.Parameters.AddWithValue("@CheckOut", res.CheckOutDate);
                            cmd.Parameters.AddWithValue("@Guests", res.NumberOfGuests);
                            cmd.Parameters.AddWithValue("@CustomerID", res.CustomerID);
                            cmd.Parameters.AddWithValue("@RoomID", roomId);
                            cmd.Parameters.AddWithValue("@StatusID", 1);

                            cmd.ExecuteNonQuery();
                        }

                        transaction.Commit();
                        return true;
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            }
        }


        public uint? GetCustomerId(string nationalId, string firstName, string lastName)
        {
            using (var conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT CustomerID
                         FROM Customer
                         WHERE NationalID = @NationalID
                         AND FirstName = @FirstName
                         AND LastName = @LastName";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@NationalID", nationalId);
                    cmd.Parameters.AddWithValue("@FirstName", firstName);
                    cmd.Parameters.AddWithValue("@LastName", lastName);

                    object result = cmd.ExecuteScalar();

                    if (result != null)
                        return Convert.ToUInt32(result);

                    return null;
                }
            }
        }

        public List<Rating> GetAllRatings()
        {
            List<Rating> ratings = new List<Rating>();

            using (var conn = GetConnection())
            {
                conn.Open();

                string query = "SELECT RatingID, RatingNum, Description " +
                               "FROM Rating";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        ratings.Add(new Rating
                        {
                            RatingID = reader.GetUInt32("RatingID"),
                            RatingNum = reader.GetInt32("RatingNum"),
                            Description = reader["Description"]?.ToString()
                        });
                    }
                }
            }

            return ratings;
        }


        public void AddReview(Review review)
        {
            using (var conn = GetConnection())
            {
                conn.Open();

                string query = @"INSERT INTO Review
                        (Comment, ReviewDate, CustomerID, HotelID, RatingID)
                        VALUES
                        (@Comment, @ReviewDate, @CustomerID, @HotelID, @RatingID)";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Comment", review.Comment);
                    cmd.Parameters.AddWithValue("@ReviewDate", review.ReviewDate);
                    cmd.Parameters.AddWithValue("@CustomerID", review.CustomerID);
                    cmd.Parameters.AddWithValue("@HotelID", review.HotelID);
                    cmd.Parameters.AddWithValue("@RatingID", review.RatingID);

                    cmd.ExecuteNonQuery();
                }
            }
        }


        public List<Role> GetAllRoles()
        {
            List<Role> roles = new List<Role>();

            using (var conn = GetConnection())
            {
                conn.Open();

                string query = "SELECT RoleID, RoleName " +
                               "FROM Role";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        roles.Add(new Role
                        {
                            RoleID = reader.GetUInt32("RoleID"),
                            RoleName = reader["RoleName"]?.ToString()
                        });
                    }
                }
            }

            return roles;
        }

        public void AddStaff(Staff staff)
        {
            using (var conn = GetConnection())
            {
                conn.Open();

                string query = @"INSERT INTO Staff(FirstName, LastName, UserName, Password,Salary, HireDate, HotelID, RoleID)
                        VALUES(@FirstName, @LastName, @UserName, @Password,@Salary, @HireDate, @HotelID, @RoleID)";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FirstName", staff.FirstName);
                    cmd.Parameters.AddWithValue("@LastName", staff.LastName);
                    cmd.Parameters.AddWithValue("@UserName", staff.UserName);
                    cmd.Parameters.AddWithValue("@Password", staff.Password);
                    cmd.Parameters.AddWithValue("@Salary", staff.Salary);
                    cmd.Parameters.AddWithValue("@HireDate", staff.HireDate);
                    cmd.Parameters.AddWithValue("@HotelID", staff.HotelID);
                    cmd.Parameters.AddWithValue("@RoleID", staff.RoleID);

                    cmd.ExecuteNonQuery();
                }
            }
        }

        public Staff? AuthenticateEmployee(string username, string password)
        {
            using (var conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT * 
                                FROM Staff
                                WHERE UserName = @UserName AND Password = @Password";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserName", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Staff
                            {
                                StaffID = reader.GetUInt32("StaffID"),
                                FirstName = reader["FirstName"]?.ToString(),
                                LastName = reader["LastName"]?.ToString(),
                                UserName = reader["UserName"]?.ToString(),
                                Password = reader["Password"]?.ToString() ?? "",
                                Salary = reader["Salary"] as int?,
                                HireDate = reader["HireDate"] as DateTime?,
                                HotelID = reader.GetUInt32("HotelID"),
                                RoleID = reader.GetUInt32("RoleID")
                            };
                        }
                    }
                }
            }

            return null;
        }


        public List<FoodMenu> GetFoods()
        {
            var list = new List<FoodMenu>();

            using var conn = GetConnection();
            conn.Open();

            string q = "SELECT FoodID, FoodName, Price " +
                       "FROM FoodMenu " +
                       "WHERE FoodStatusID=1";

            using var cmd = new MySqlCommand(q, conn);
            using var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                list.Add(new FoodMenu
                {
                    FoodID = reader.GetUInt32("FoodID"),
                    FoodName = reader.GetString("FoodName"),
                    Price = reader.GetDecimal("Price")
                });
            }

            return list;
        }

        public List<FoodCategory> GetFoodCategories()
        {
            var list = new List<FoodCategory>();

            using var conn = GetConnection();
            conn.Open();

            var cmd = new MySqlCommand("SELECT * FROM FoodCategory", conn);
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                list.Add(new FoodCategory
                {
                    CategoryID = reader.GetUInt32("CategoryID"),
                    CategoryName = reader.GetString("CategoryName")
                });
            }

            return list;
        }

        public List<FoodSection> GetFoodSections()
        {
            var list = new List<FoodSection>();

            using var conn = GetConnection();
            conn.Open();

            var cmd = new MySqlCommand("SELECT * FROM FoodSection", conn);
            var reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                list.Add(new FoodSection
                {
                    SectionID = reader.GetUInt32("SectionID"),
                    SectionName = reader.GetString("SectionName")
                });
            }

            return list;
        }

        public uint? GetActiveReservationId(uint customerId)
        {
            using var conn = GetConnection();
            conn.Open();
            // فرض می‌کنیم رزروهایی که هنوز Checkout نشدن (Status مثلاً 1) مد نظر هستن
            // اگر در دیتابیست فیلد وضعیت رزرو داری، در WHERE اضافه کن
            string sql = "SELECT ReservationID " +
                         "FROM Reservation WHERE CustomerID = @cid ORDER BY ReservationID DESC LIMIT 1";

            using var cmd = new MySqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("@cid", customerId);

            var result = cmd.ExecuteScalar();
            return result != null ? (uint?)Convert.ToUInt32(result) : null;
        }

        public decimal CreateFoodOrder(uint customerId, uint foodId, int quantity)
        {
            using var conn = GetConnection();
            conn.Open();
            using var transaction = conn.BeginTransaction();

            try
            {
                uint? resId = GetActiveReservationId(customerId);

                if (resId == null)
                    throw new Exception("This customer currently has no active reservations for food orders!");

                decimal price = 0;
                var cmdPrice = new MySqlCommand("SELECT Price FROM FoodMenu WHERE FoodID=@id", conn, transaction);
                cmdPrice.Parameters.AddWithValue("@id", foodId);
                price = Convert.ToDecimal(cmdPrice.ExecuteScalar());

                decimal total = price * quantity;
                decimal tax = total * 0.1m;
                decimal finalTotal = total + tax;

                var cmdOrder = new MySqlCommand(
                    "INSERT INTO `Order` (OrderDate, OrderTime, CustomerID, StatusID) VALUES (@d, @t, @c, 1); SELECT LAST_INSERT_ID();",
                    conn, transaction);
                cmdOrder.Parameters.AddWithValue("@d", DateTime.Now.Date);
                cmdOrder.Parameters.AddWithValue("@t", DateTime.Now.TimeOfDay);
                cmdOrder.Parameters.AddWithValue("@c", customerId);
                uint orderId = Convert.ToUInt32(cmdOrder.ExecuteScalar());


                string invoiceSql = @"INSERT INTO Invoice (InvoiceDate, TaxAmount, TotalAmount, Discount, StatusID, ReservationID)
                                    VALUES (@date, @tax, @total, 0, 1, @resId)
                                                ON DUPLICATE KEY UPDATE 
                                    TotalAmount = TotalAmount + VALUES(TotalAmount),
                                    TaxAmount = TaxAmount + VALUES(TaxAmount);";

                var cmdInv = new MySqlCommand(invoiceSql, conn, transaction);
                cmdInv.Parameters.AddWithValue("@date", DateTime.Now);
                cmdInv.Parameters.AddWithValue("@tax", tax);
                cmdInv.Parameters.AddWithValue("@total", finalTotal);
                cmdInv.Parameters.AddWithValue("@resId", resId);
                cmdInv.ExecuteNonQuery();

                transaction.Commit();
                return finalTotal;
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }
        }





        //Queries
        public List<HotelRevenueReport> GetHotelRevenueReport()
        {
            var list = new List<HotelRevenueReport>();
            using (var conn = GetConnection())
            {
                conn.Open();
                string sql = @"SELECT h.HotelName, SUM(p.Amount) as TotalRevenue 
                       FROM Hotel h 
                       JOIN Room r ON h.HotelID = r.HotelID 
                       JOIN Reservation res ON r.RoomID = res.RoomID 
                       JOIN Invoice i ON res.ReservationID = i.ReservationID 
                       JOIN Payment p ON i.InvoiceID = p.InvoiceID 
                       WHERE p.StatusID = (SELECT StatusID FROM PaymentStatus WHERE StatusName = 'Paid') 
                       GROUP BY h.HotelID"
                ;

                MySqlCommand cmd = new MySqlCommand(sql, conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read()) list.Add(new HotelRevenueReport 
                    { 
                        HotelName = reader["HotelName"].ToString(), 
                        TotalRevenue = Convert.ToDecimal(reader["TotalRevenue"]) 
                    });
                }
            }
            return list;
        }


        public List<CustomerRanking> GetCustomerRanking()
        {
            var list = new List<CustomerRanking>();
            using (var conn = GetConnection())
            {
                conn.Open();
                string sql = @"SELECT CONCAT(c.FirstName, ' ', c.LastName) as FullName, SUM(p.Amount) as TotalSpent 
                       FROM Customer c 
                       JOIN Reservation r ON c.CustomerID = r.CustomerID 
                       JOIN Invoice i ON r.ReservationID = i.ReservationID 
                       JOIN Payment p ON i.InvoiceID = p.InvoiceID 
                       GROUP BY c.CustomerID ORDER BY TotalSpent DESC";
                var cmd = new MySqlCommand(sql, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read()) list.Add(new CustomerRanking 
                    { 
                        FullName = reader["FullName"].ToString(), 
                        TotalSpent = Convert.ToDecimal(reader["TotalSpent"]) 
                    });
                }
            }
            return list;
        }

        public List<ReservationDetailReport> GetReservationReport()
        {
            var list = new List<ReservationDetailReport>();
            using (var conn = GetConnection())
            {
                conn.Open();
                string sql = @"SELECT res.ReservationID, CONCAT(c.FirstName, ' ', c.LastName) as CustomerName, h.HotelName, r.RoomNumber, res.CheckInDate, rs.StatusName 
                       FROM Reservation res 
                       JOIN Customer c ON res.CustomerID = c.CustomerID 
                       JOIN Room r ON res.RoomID = r.RoomID 
                       JOIN Hotel h ON r.HotelID = h.HotelID 
                       JOIN ReservationStatus rs ON res.StatusID = rs.StatusID";
                var cmd = new MySqlCommand(sql, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read()) list.Add(new ReservationDetailReport
                    {
                        ReservationID = Convert.ToUInt32(reader["ReservationID"]),
                        CustomerName = reader["CustomerName"].ToString(),
                        HotelName = reader["HotelName"].ToString(),
                        RoomNumber = Convert.ToUInt32(reader["RoomNumber"]),
                        CheckInDate = Convert.ToDateTime(reader["CheckInDate"]),
                        Status = reader["StatusName"].ToString()
                    });
                }
            }
            return list;
        }


        public List<ReservationServiceReport> GetReservationServices()
        {
            List<ReservationServiceReport> list = new List<ReservationServiceReport>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT rs.ReservationID,
                         s.ServiceName,
                         rs.PriceAtTime
                         FROM ReservationService rs
                         JOIN Service s ON rs.ServiceID = s.ServiceID";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new ReservationServiceReport
                        {
                            ReservationID = Convert.ToUInt32(reader["ReservationID"]),
                            ServiceName = reader["ServiceName"].ToString(),
                            Price = Convert.ToDecimal(reader["PriceAtTime"])
                        });
                    }
                }
            }

            return list;
        }

        public List<HotelRatingReport> GetHotelRatings()
        {
            List<HotelRatingReport> list = new List<HotelRatingReport>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT h.HotelName,
                         AVG(r.RatingNum) AS AvgRating,
                         COUNT(rv.ReviewID) AS ReviewCount
                         FROM Hotel h
                         JOIN Review rv ON h.HotelID = rv.HotelID
                         JOIN Rating r ON rv.RatingID = r.RatingID
                         GROUP BY h.HotelID";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new HotelRatingReport
                        {
                            HotelName = reader["HotelName"].ToString(),
                            AvgRating = Convert.ToDouble(reader["AvgRating"]),
                            ReviewCount = Convert.ToInt64(reader["ReviewCount"])
                        });
                    }
                }
            }

            return list;
        }


        public List<TopFoodReport> GetTopFoods()
        {
            var list = new List<TopFoodReport>();
            using (var conn = GetConnection())
            {
                conn.Open();
                string sql = @"SELECT f.FoodName, COUNT(oif.ItemID) as TotalSold 
                       FROM FoodMenu f 
                       JOIN OrderItemFood oif ON f.FoodID = oif.FoodID 
                       GROUP BY f.FoodID ORDER BY TotalSold DESC";

                var cmd = new MySqlCommand(sql, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read()) list.Add(new TopFoodReport 
                    { 
                        FoodName = reader["FoodName"].ToString(), 
                        TotalSold = Convert.ToInt64(reader["TotalSold"]) 
                    });
                }
            }
            return list;
        }

        public List<BookReport> GetBooksReport()
        {
            List<BookReport> list = new List<BookReport>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT b.Title,
                         a.AuthorName,
                         bc.BookCategoryName,
                         bl.Section
                         FROM Book b
                         JOIN Author a ON b.AuthorID = a.AuthorID
                         JOIN BookCategory bc ON b.BookCategoryID = bc.BookCategoryID
                         JOIN BookLocation bl ON b.LocationID = bl.LocationID";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new BookReport
                        {
                            Title = reader["Title"].ToString(),
                            Author = reader["AuthorName"].ToString(),
                            Category = reader["BookCategoryName"].ToString(),
                            Location = reader["Section"].ToString()
                        });
                    }
                }
            }

            return list;
        }


        public List<StaffReport> GetStaffReport()
        {
            List<StaffReport> list = new List<StaffReport>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT CONCAT(s.FirstName,' ',s.LastName) AS FullName,
                         r.RoleName,
                         h.HotelName,
                         s.Salary
                         FROM Staff s
                         JOIN Role r ON s.RoleID = r.RoleID
                         JOIN Hotel h ON s.HotelID = h.HotelID";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new StaffReport
                        {
                            FullName = reader["FullName"].ToString(),
                            Role = reader["RoleName"].ToString(),
                            HotelName = reader["HotelName"].ToString(),
                            Salary = Convert.ToDecimal(reader["Salary"])
                        });
                    }
                }
            }

            return list;
        }


        public List<OrderReport> GetOrdersReport()
        {
            List<OrderReport> list = new List<OrderReport>();

            using (MySqlConnection conn = GetConnection())
            {
                conn.Open();

                string query = @"SELECT o.OrderID,
                         CONCAT(c.FirstName,' ',c.LastName) AS CustomerName,
                         os.StatusName,
                         o.OrderDate
                         FROM `Order` o
                         JOIN Customer c ON o.CustomerID = c.CustomerID
                         JOIN OrderStatus os ON o.StatusID = os.StatusID";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new OrderReport
                        {
                            OrderID = Convert.ToUInt32(reader["OrderID"]),
                            CustomerName = reader["CustomerName"].ToString(),
                            Status = reader["StatusName"].ToString(),
                            OrderDate = Convert.ToDateTime(reader["OrderDate"])
                        });
                    }
                }
            }

            return list;
        }


        public List<UnpaidInvoiceReport> GetUnpaidInvoices()
        {
            var list = new List<UnpaidInvoiceReport>();
            using (var conn = GetConnection())
            {
                conn.Open();
                string sql = @"SELECT i.InvoiceID, CONCAT(c.FirstName, ' ', c.LastName) as CustomerName, i.TotalAmount, i.InvoiceDate 
                       FROM Invoice i 
                       JOIN Reservation r ON i.ReservationID = r.ReservationID 
                       JOIN Customer c ON r.CustomerID = c.CustomerID 
                       WHERE i.StatusID = (SELECT StatusID FROM InvoiceStatus WHERE StatusName = 'Not paid')";
                var cmd = new MySqlCommand(sql, conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read()) list.Add(new UnpaidInvoiceReport
                    {
                        InvoiceID = Convert.ToUInt32(reader["InvoiceID"]),
                        CustomerName = reader["CustomerName"].ToString(),
                        TotalAmount = Convert.ToDecimal(reader["TotalAmount"]),
                        InvoiceDate = Convert.ToDateTime(reader["InvoiceDate"])
                    });
                }
            }
            return list;
        }


    }
}

