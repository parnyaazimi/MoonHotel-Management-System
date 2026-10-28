using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoonHotel.Models
{

    public class Rating
    {
        public uint RatingID { get; set; }
        public int RatingNum { get; set; }
        public string? Description { get; set; }
    }

    public class Role
    {
        public uint RoleID { get; set; }
        public string? RoleName { get; set; }
    }

    public class ReservationStatus
    {
        public uint StatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }

    public class RoomStatus
    {
        public uint RoomStatusID { get; set; }
        public string? StatusName { get; set; }
    }

    public class RoomType
    {
        public uint RoomTypeID { get; set; }
        public string TypeName { get; set; } = string.Empty;
        public string? Description { get; set; }
    }

    public class ServiceStatus
    {
        public uint ServiceStatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }

    public class OrderStatus
    {
        public uint StatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }

    public class InvoiceStatus
    {
        public uint StatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }

    public class PaymentStatus
    {
        public uint StatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }

    public class PaymentMethod
    {
        public uint MethodID { get; set; }
        public string MethodName { get; set; } = string.Empty;
    }

    public class BookStatus
    {
        public uint BookStatusID { get; set; }
        public string BookStatusName { get; set; } = string.Empty;
    }

    public class BookCategory
    {
        public uint BookCategoryID { get; set; }
        public string BookCategoryName { get; set; } = string.Empty;
    }

    public class FacilityStatus
    {
        public uint StatusID { get; set; }
        public string? StatusName { get; set; }
    }

    public class FoodCategory
    {
        public uint CategoryID { get; set; }
        public string CategoryName { get; set; } = string.Empty;
    }

    public class FoodSection
    {
        public uint SectionID { get; set; }
        public string SectionName { get; set; } = string.Empty;
    }

    public class FoodStatus
    {
        public uint FoodStatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }

    public class ProductCategory
    {
        public uint ProductCategoryID { get; set; }
        public string CategoryName { get; set; } = string.Empty;
    }

    public class ProductStatus
    {
        public uint ProductStatusID { get; set; }
        public string StatusName { get; set; } = string.Empty;
    }
}

