using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoonHotel.Models
{


    public class HotelRevenueReport 
    { 
        public string? HotelName { get; set; } 
        public decimal TotalRevenue { get; set; } 
    }


    public class CustomerRanking 
    { 
        public string? FullName { get; set; } 
        public decimal TotalSpent { get; set; } 
    }


    public class ReservationDetailReport
    {
        public uint ReservationID { get; set; }
        public string? CustomerName { get; set; }
        public string? HotelName { get; set; }
        public uint RoomNumber { get; set; }
        public DateTime? CheckInDate { get; set; }
        public string? Status { get; set; }
    }

    public class ReservationServiceReport 
    { 
        public uint ReservationID { get; set; } 
        public string? ServiceName { get; set; } 
        public decimal Price { get; set; } 
    }


    public class HotelRatingReport 
    { 
        public string? HotelName { get; set; } 
        public double AvgRating { get; set; } 
        public long ReviewCount { get; set; } 
    }


    public class TopFoodReport 
    { 
        public string? FoodName { get; set; } 
        public long TotalSold { get; set; } 
    }


    public class BookReport 
    { public string? Title { get; set; } 
        public string? Author { get; set; } 
        public string? Category { get; set; } 
        public string? Location { get; set; } 
    }


    public class StaffReport 
    { 
        public string? FullName { get; set; } 
        public string? Role { get; set; } 
        public string? HotelName { get; set; } 
        public decimal Salary { get; set; } 
    }


    public class OrderReport 
    { 
        public uint OrderID { get; set; } 
        public string? CustomerName { get; set; } 
        public string? Status { get; set; } 
        public DateTime? OrderDate { get; set; } 
    }


    public class UnpaidInvoiceReport 
    { 
        public uint InvoiceID { get; set; } 
        public string? CustomerName { get; set; } 
        public decimal TotalAmount { get; set; } 
        public DateTime? InvoiceDate { get; set; } 
    }
}

