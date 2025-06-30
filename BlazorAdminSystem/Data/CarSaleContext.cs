using Microsoft.EntityFrameworkCore;
using CarSaleSystem.Models;

namespace CarSaleSystem.Data
{
    public class CarSaleContext : DbContext
    {
        public CarSaleContext(DbContextOptions<CarSaleContext> options) : base(options) { }

        public DbSet<Brand> Brands { get; set; }
        public DbSet<Series> Series { get; set; }
        public DbSet<Car> Cars { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Employee> Employees { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetails> OrderDetails { get; set; }
        public DbSet<CarShop> CarShops { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // 配置表名映射到数据库中的实际表名
            modelBuilder.Entity<Brand>().ToTable("brand");
            modelBuilder.Entity<Series>().ToTable("series");
            modelBuilder.Entity<Car>().ToTable("car");
            modelBuilder.Entity<Customer>().ToTable("customer");
            modelBuilder.Entity<Employee>().ToTable("employee");
            modelBuilder.Entity<Order>().ToTable("order");
            modelBuilder.Entity<OrderDetails>().ToTable("order_details");
            modelBuilder.Entity<CarShop>().ToTable("carshop");

            // 配置主键
            modelBuilder.Entity<Brand>()
                .HasKey(b => b.BrandId);
            modelBuilder.Entity<Brand>()
                .Property(b => b.BrandId)
                .HasColumnName("brand_id");
            modelBuilder.Entity<Brand>()
                .Property(b => b.BrandName)
                .HasColumnName("brand_name");

            modelBuilder.Entity<Series>()
                .HasKey(s => s.SeriesId);
            modelBuilder.Entity<Series>()
                .Property(s => s.SeriesId)
                .HasColumnName("series_id");
            modelBuilder.Entity<Series>()
                .Property(s => s.BrandId)
                .HasColumnName("brand_id");
            modelBuilder.Entity<Series>()
                .Property(s => s.SeriesName)
                .HasColumnName("series_name");

            modelBuilder.Entity<Car>()
                .Property(c => c.SeriesId)
                .HasColumnName("series_id");
            modelBuilder.Entity<Car>()
                .Property(c => c.Type)
                .HasColumnName("type");
            modelBuilder.Entity<Car>()
                .Property(c => c.Color)
                .HasColumnName("color");
            modelBuilder.Entity<Car>()
                .Property(c => c.Price)
                .HasColumnName("price");
            modelBuilder.Entity<Car>()
                .Property(c => c.SalePrice)
                .HasColumnName("sale_price");
            modelBuilder.Entity<Car>()
                .Property(c => c.Repertory)
                .HasColumnName("repertory");
            modelBuilder.Entity<Car>()
                .Property(c => c.CreateTime)
                .HasColumnName("create_time");
            modelBuilder.Entity<Car>()
                .Property(c => c.Status)
                .HasColumnName("status");

            modelBuilder.Entity<Customer>()
                .Property(c => c.Name)
                .HasColumnName("name");
            modelBuilder.Entity<Customer>()
                .Property(c => c.Phone)
                .HasColumnName("phone");
            modelBuilder.Entity<Customer>()
                .Property(c => c.IdCard)
                .HasColumnName("id_card");
            modelBuilder.Entity<Customer>()
                .Property(c => c.CreateTime)
                .HasColumnName("create_time");

            modelBuilder.Entity<Employee>()
                .Property(e => e.Role)
                .HasColumnName("role");
            modelBuilder.Entity<Employee>()
                .Property(e => e.Name)
                .HasColumnName("name");
            modelBuilder.Entity<Employee>()
                .Property(e => e.Password)
                .HasColumnName("password");
            modelBuilder.Entity<Employee>()
                .Property(e => e.IdCard)
                .HasColumnName("id_card");
            modelBuilder.Entity<Employee>()
                .Property(e => e.Phone)
                .HasColumnName("phone");
            modelBuilder.Entity<Employee>()
                .Property(e => e.Gender)
                .HasColumnName("gender");
            modelBuilder.Entity<Employee>()
                .Property(e => e.Salary)
                .HasColumnName("salary");
            modelBuilder.Entity<Employee>()
                .Property(e => e.EntryTime)
                .HasColumnName("entry_time");
            modelBuilder.Entity<Employee>()
                .Property(e => e.Status)
                .HasColumnName("status");

            modelBuilder.Entity<Order>()
                .Property(o => o.CustomerId)
                .HasColumnName("customer_id");
            modelBuilder.Entity<Order>()
                .Property(o => o.EmployeeId)
                .HasColumnName("employee_id");
            modelBuilder.Entity<Order>()
                .Property(o => o.TotalPrice)
                .HasColumnName("total_price");
            modelBuilder.Entity<Order>()
                .Property(o => o.Status)
                .HasColumnName("status");
            modelBuilder.Entity<Order>()
                .Property(o => o.CreateTime)
                .HasColumnName("create_time");
            modelBuilder.Entity<Order>()
                .Property(o => o.PayTime)
                .HasColumnName("pay_time");
            modelBuilder.Entity<Order>()
                .Property(o => o.UpdateTime)
                .HasColumnName("update_time");

            modelBuilder.Entity<OrderDetails>()
                .Property(od => od.OrderId)
                .HasColumnName("order_id");
            modelBuilder.Entity<OrderDetails>()
                .Property(od => od.CarId)
                .HasColumnName("car_id");
            modelBuilder.Entity<OrderDetails>()
                .Property(od => od.CarNumber)
                .HasColumnName("car_number");

            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.Name)
                .HasColumnName("name");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.Address)
                .HasColumnName("address");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.Phone)
                .HasColumnName("phone");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.BusinessHours)
                .HasColumnName("business_hours");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.Latitude)
                .HasColumnName("latitude");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.Longitude)
                .HasColumnName("longitude");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.CreatedTime)
                .HasColumnName("created_time");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.UpdatedTime)
                .HasColumnName("updated_time");
            modelBuilder.Entity<CarShop>()
                .Property(cs => cs.Brand)
                .HasColumnName("brand");

            // 配置索引
            modelBuilder.Entity<Brand>()
                .HasIndex(b => b.BrandName)
                .IsUnique();

            modelBuilder.Entity<Customer>()
                .HasIndex(c => c.Phone)
                .IsUnique();

            modelBuilder.Entity<Customer>()
                .HasIndex(c => c.IdCard)
                .IsUnique();

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.Phone)
                .IsUnique();

            modelBuilder.Entity<Employee>()
                .HasIndex(e => e.IdCard)
                .IsUnique();

            // 配置外键关系
            modelBuilder.Entity<Series>()
                .HasOne(s => s.Brand)
                .WithMany(b => b.Series)
                .HasForeignKey(s => s.BrandId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Car>()
                .HasOne(c => c.Series)
                .WithMany(s => s.Cars)
                .HasForeignKey(c => c.SeriesId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Order>()
                .HasOne(o => o.Customer)
                .WithMany(c => c.Orders)
                .HasForeignKey(o => o.CustomerId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Order>()
                .HasOne(o => o.Employee)
                .WithMany(e => e.Orders)
                .HasForeignKey(o => o.EmployeeId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<OrderDetails>()
                .HasOne(od => od.Order)
                .WithMany(o => o.OrderDetails)
                .HasForeignKey(od => od.OrderId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<OrderDetails>()
                .HasOne(od => od.Car)
                .WithMany(c => c.OrderDetails)
                .HasForeignKey(od => od.CarId)
                .OnDelete(DeleteBehavior.Restrict);

            base.OnModelCreating(modelBuilder);
        }
    }
}