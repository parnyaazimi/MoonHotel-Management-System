using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MoonHotel.Models
{
    public class Order
    {
        public uint OrderID { get; set; }
        public DateTime? OrderDate { get; set; }
        public TimeSpan? OrderTime { get; set; }
        public uint CustomerID { get; set; }
        public uint StatusID { get; set; }
    }

    public class OrderItem
    {
        public uint OrderID { get; set; }
        public uint ItemID { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
    }

    public class OrderItemFood
    {
        public uint OrderID { get; set; }
        public uint ItemID { get; set; }
        public uint FoodID { get; set; }
    }

    public class OrderItemProduct
    {
        public uint OrderID { get; set; }
        public uint ItemID { get; set; }
        public uint ProductID { get; set; }
    }

    public class OrderItemBook
    {
        public uint OrderID { get; set; }
        public uint ItemID { get; set; }
        public uint BookID { get; set; }
    }

    public class Invoice
    {
        public uint InvoiceId { get; set; }
        public DateTime? InvoiceDate { get; set; }
        public decimal? TaxAmount { get; set; }
        public decimal? TotalAmount { get; set; }
        public decimal? Discount { get; set; }
        public uint StatusID { get; set; }
        public uint ReservationID { get; set; }
    }

    public class Payment
    {
        public uint PaymentID { get; set; }
        public uint InvoiceID { get; set; }
        public DateTime? PaymentDate { get; set; }
        public decimal? Amount { get; set; }
        public uint StatusID { get; set; }
        public uint MethodID { get; set; }
        public string PaymentType { get; set; } = string.Empty;
        public DateTime? DueDate { get; set; }
        public int? InstallmentNumber { get; set; }
        public int? TotalInstallments { get; set; }
    }

    public class Author
    {
        public uint AuthorID { get; set; }
        public string AuthorName { get; set; } = string.Empty;
    }

    public class BookLocation
    {
        public uint LocationID { get; set; }
        public uint HotelID { get; set; }
        public int? Floor { get; set; }
        public string? Section { get; set; }
        public string? ShelfNumber { get; set; }
    }

    public class Book
    {
        public uint BookID { get; set; }
        public string Title { get; set; } = string.Empty;
        public uint AuthorID { get; set; }
        public uint BookCategoryID { get; set; }
        public uint BookStatusID { get; set; }
        public uint LocationID { get; set; }
    }

    public class FoodMenu
    {
        public uint FoodID { get; set; }
        public string FoodName { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public uint CategoryID { get; set; }
        public uint SectionID { get; set; }
        public uint FoodStatusID { get; set; }
    }

    public class Product
    {
        public uint ProductID { get; set; }
        public string ProductName { get; set; } = string.Empty;
        public decimal Price { get; set; }
        public uint ProductCategoryID { get; set; }
        public uint ProductStatusID { get; set; }
        public string? Description { get; set; }
    }
}

