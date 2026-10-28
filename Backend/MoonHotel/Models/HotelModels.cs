using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoonHotel.Models
{
    public class Hotel
    {
        public uint HotelID { get; set; }
        public string? HotelName { get; set; }
        public string? City { get; set; }
        public string? Street { get; set; }
        public string? PostalCode { get; set; }
        public string? Phone { get; set; }
        public string? Email { get; set; }
        public uint RatingID { get; set; }
    }

    public class Staff
    {
        public uint StaffID { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? UserName { get; set; }
        public string Password { get; set; } = string.Empty;
        public int? Salary { get; set; }
        public DateTime? HireDate { get; set; }
        public uint HotelID { get; set; }
        public uint RoleID { get; set; }
    }

    public class Customer
    {
        public uint CustomerID { get; set; }
        public string NationalID { get; set; } = string.Empty;
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public DateTime? BirthDate { get; set; }
        public string? City { get; set; }
        public string? Street { get; set; }
        public string? PostalCode { get; set; }
    }

    public class CustomerPhone
    {
        public uint CustomerID { get; set; }
        public string PhoneNumber { get; set; } = string.Empty;
    }

    public class Room
    {
        public uint RoomID { get; set; }
        public uint? RoomNumber { get; set; }
        public int? Capacity { get; set; }
        public decimal? PricePerNight { get; set; }
        public uint RoomStatusID { get; set; }
        public uint RoomTypeID { get; set; }
        public uint HotelID { get; set; }
        public string? Description { get; set; }
    }

    public class Reservation
    {
        public uint ReservationID { get; set; }
        public DateTime? CheckInDate { get; set; }
        public DateTime? CheckOutDate { get; set; }
        public int? NumberOfGuests { get; set; }
        public uint CustomerID { get; set; }
        public uint RoomID { get; set; }
        public uint StatusID { get; set; }
    }

    public class Service
    {
        public uint ServiceID { get; set; }
        public string? ServiceName { get; set; }
        public decimal? Price { get; set; }
        public string? Description { get; set; }
        public uint HotelID { get; set; }
        public uint ServiceStatusID { get; set; }
    }

    public class ReservationService
    {
        public uint ReservationID { get; set; }
        public uint ServiceID { get; set; }
        public decimal? PriceAtTime { get; set; }
        public uint Quantity { get; set; }
    }

    public class Review
    {
        public uint ReviewID { get; set; }
        public string? Comment { get; set; }
        public DateTime? ReviewDate { get; set; }
        public uint CustomerID { get; set; }
        public uint HotelID { get; set; }
        public uint RatingID { get; set; }
    }

    public class Facility
    {
        public uint FacilityID { get; set; }
        public uint HotelID { get; set; }
        public uint StatusID { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public TimeSpan? OpenTime { get; set; }
        public TimeSpan? CloseTime { get; set; }
    }
}
