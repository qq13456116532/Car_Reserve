using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarSaleSystem.Models
{
    public class Brand
    {
        [Key]
        public int BrandId { get; set; }
        
        [Required, MaxLength(16)]
        public string BrandName { get; set; }
        
        [MaxLength(1)]
        public string Status { get; set; } = "1";
        
        public List<Series> Series { get; set; } = new();
    }

    public class Series
    {
        [Key]
        public int SeriesId { get; set; }
        
        [Required]
        public int BrandId { get; set; }
        
        [Required, MaxLength(16)]
        public string SeriesName { get; set; }
        
        [MaxLength(1)]
        public string Status { get; set; } = "1";
        
        [ForeignKey("BrandId")]
        public Brand Brand { get; set; }
        
        public List<Car> Cars { get; set; } = new();
    }

    public class Car
    {
        [Key]
        public long Id { get; set; }
        
        [Required]
        public int SeriesId { get; set; }
        
        [Required, MaxLength(32)]
        public string Type { get; set; }
        
        [Required, MaxLength(16)]
        public string Color { get; set; }
        
        [Column(TypeName = "decimal(12,2)")]
        public decimal Price { get; set; }
        
        [Column(TypeName = "decimal(12,2)")]
        public decimal SalePrice { get; set; }
        
        public int Repertory { get; set; }
        
        public DateTime CreateTime { get; set; } = DateTime.Now;
        
        [MaxLength(1)]
        public string Status { get; set; } = "1";
        
        [ForeignKey("SeriesId")]
        public Series Series { get; set; }
        
        public List<OrderDetails> OrderDetails { get; set; } = new();
    }

    public class Customer
    {
        [Key]
        public long Id { get; set; }
        
        [MaxLength(10)]
        public string Name { get; set; }
        
        [MaxLength(11)]
        public string Phone { get; set; }
        
        [MaxLength(20)]
        public string IdCard { get; set; }
        
        public DateTime CreateTime { get; set; } = DateTime.Now;
        
        public List<Order> Orders { get; set; } = new();
    }

    public class Employee
    {
        [Key]
        public int Id { get; set; }
        
        [MaxLength(1)]
        public string Role { get; set; } // 0:经理, 1:销售
        
        [MaxLength(10)]
        public string Name { get; set; }
        
        [MaxLength(20)]
        public string Password { get; set; }
        
        [MaxLength(20)]
        public string IdCard { get; set; }
        
        [MaxLength(11)]
        public string Phone { get; set; }
        
        [MaxLength(1)]
        public string Gender { get; set; }
        
        [Column(TypeName = "decimal(12,2)")]
        public decimal? Salary { get; set; }
        
        public DateTime? EntryTime { get; set; }
        
        [MaxLength(1)]
        public string Status { get; set; } = "1";
        
        public List<Order> Orders { get; set; } = new();
    }

    public class Order
    {
        [Key]
        public long Id { get; set; }
        
        [Required]
        public long CustomerId { get; set; }
        
        [Required]
        public int EmployeeId { get; set; }
        
        [Column(TypeName = "decimal(20,2)")]
        public decimal TotalPrice { get; set; }
        
        [MaxLength(1)]
        public string Status { get; set; } // 0:未支付, 1:已支付, 2:已取消
        
        public DateTime CreateTime { get; set; } = DateTime.Now;
        
        public DateTime? PayTime { get; set; }
        
        public DateTime UpdateTime { get; set; } = DateTime.Now;
        
        [ForeignKey("CustomerId")]
        public Customer Customer { get; set; }
        
        [ForeignKey("EmployeeId")]
        public Employee Employee { get; set; }
        
        public List<OrderDetails> OrderDetails { get; set; } = new();
    }

    public class OrderDetails
    {
        [Key, MaxLength(16)]
        public string Id { get; set; }
        
        [Required]
        public long OrderId { get; set; }
        
        [Required]
        public long CarId { get; set; }
        
        public int CarNumber { get; set; }
        
        [ForeignKey("OrderId")]
        public Order Order { get; set; }
        
        [ForeignKey("CarId")]
        public Car Car { get; set; }
    }

    public class CarShop
    {
        [Key]
        public int Id { get; set; }
        
        [Required, MaxLength(50)]
        public string Name { get; set; }
        
        [Required, MaxLength(100)]
        public string Address { get; set; }
        
        [Required, MaxLength(20)]
        public string Phone { get; set; }
        
        [Required, MaxLength(50)]
        public string BusinessHours { get; set; }
        
        [Column(TypeName = "decimal(10,6)")]
        public decimal Latitude { get; set; }
        
        [Column(TypeName = "decimal(10,6)")]
        public decimal Longitude { get; set; }
        
        public DateTime CreatedTime { get; set; } = DateTime.Now;
        
        public DateTime UpdatedTime { get; set; } = DateTime.Now;
        
        [MaxLength(255)]
        public string Brand { get; set; }
    }
}