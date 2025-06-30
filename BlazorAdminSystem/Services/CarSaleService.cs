using Microsoft.EntityFrameworkCore;
using CarSaleSystem.Data;
using CarSaleSystem.Models;
using Radzen;

namespace CarSaleSystem.Services
{
    public class CarSaleService
    {
        private readonly CarSaleContext _context;
        private readonly NotificationService _notificationService;

        public CarSaleService(CarSaleContext context, NotificationService notificationService)
        {
            _context = context;
            _notificationService = notificationService;
        }

        // Brand Services
        public async Task<IQueryable<Brand>> GetBrandsAsync()
        {
            return _context.Brands.Where(b => b.Status == "1");
        }

        public async Task<Brand> CreateBrandAsync(Brand brand)
        {
            _context.Brands.Add(brand);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "品牌创建成功");
            return brand;
        }

        public async Task<Brand> UpdateBrandAsync(Brand brand)
        {
            _context.Entry(brand).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "品牌更新成功");
            return brand;
        }

        public async Task DeleteBrandAsync(int id)
        {
            var brand = await _context.Brands.FindAsync(id);
            if (brand != null)
            {
                brand.Status = "0";
                await _context.SaveChangesAsync();
                _notificationService.Notify(NotificationSeverity.Success, "成功", "品牌删除成功");
            }
        }

        // Series Services
        public async Task<IQueryable<Series>> GetSeriesAsync()
        {
            return _context.Series.Include(s => s.Brand).Where(s => s.Status == "1");
        }

        public async Task<Series> CreateSeriesAsync(Series series)
        {
            _context.Series.Add(series);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "车系创建成功");
            return series;
        }

        public async Task<Series> UpdateSeriesAsync(Series series)
        {
            _context.Entry(series).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "车系更新成功");
            return series;
        }

        public async Task DeleteSeriesAsync(int id)
        {
            var series = await _context.Series.FindAsync(id);
            if (series != null)
            {
                series.Status = "0";
                await _context.SaveChangesAsync();
                _notificationService.Notify(NotificationSeverity.Success, "成功", "车系删除成功");
            }
        }

        // Car Services
        public async Task<IQueryable<Car>> GetCarsAsync()
        {
            return _context.Cars.Include(c => c.Series).ThenInclude(s => s.Brand).Where(c => c.Status != "0");
        }

        public async Task<Car> CreateCarAsync(Car car)
        {
            _context.Cars.Add(car);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "车辆创建成功");
            return car;
        }

        public async Task<Car> UpdateCarAsync(Car car)
        {
            _context.Entry(car).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "车辆更新成功");
            return car;
        }

        public async Task DeleteCarAsync(long id)
        {
            var car = await _context.Cars.FindAsync(id);
            if (car != null)
            {
                car.Status = "0";
                await _context.SaveChangesAsync();
                _notificationService.Notify(NotificationSeverity.Success, "成功", "车辆删除成功");
            }
        }

        // Customer Services
        public async Task<IQueryable<Customer>> GetCustomersAsync()
        {
            return _context.Customers.AsQueryable();
        }

        public async Task<Customer> CreateCustomerAsync(Customer customer)
        {
            _context.Customers.Add(customer);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "客户创建成功");
            return customer;
        }

        public async Task<Customer> UpdateCustomerAsync(Customer customer)
        {
            _context.Entry(customer).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "客户更新成功");
            return customer;
        }

        public async Task DeleteCustomerAsync(long id)
        {
            var customer = await _context.Customers.FindAsync(id);
            if (customer != null)
            {
                _context.Customers.Remove(customer);
                await _context.SaveChangesAsync();
                _notificationService.Notify(NotificationSeverity.Success, "成功", "客户删除成功");
            }
        }

        // Employee Services
        public async Task<IQueryable<Employee>> GetEmployeesAsync()
        {
            return _context.Employees.Where(e => e.Status == "1");
        }

        public async Task<Employee> CreateEmployeeAsync(Employee employee)
        {
            _context.Employees.Add(employee);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "员工创建成功");
            return employee;
        }

        public async Task<Employee> UpdateEmployeeAsync(Employee employee)
        {
            _context.Entry(employee).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "员工更新成功");
            return employee;
        }

        public async Task DeleteEmployeeAsync(int id)
        {
            var employee = await _context.Employees.FindAsync(id);
            if (employee != null)
            {
                employee.Status = "0";
                await _context.SaveChangesAsync();
                _notificationService.Notify(NotificationSeverity.Success, "成功", "员工删除成功");
            }
        }

        // Order Services
        public async Task<IQueryable<Order>> GetOrdersAsync()
        {
            return _context.Orders
                .Include(o => o.Customer)
                .Include(o => o.Employee)
                .Include(o => o.OrderDetails)
                .ThenInclude(od => od.Car);
        }

        public async Task<Order> CreateOrderAsync(Order order)
        {
            _context.Orders.Add(order);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "订单创建成功");
            return order;
        }

        public async Task<Order> UpdateOrderAsync(Order order)
        {
            order.UpdateTime = DateTime.Now;
            _context.Entry(order).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "订单更新成功");
            return order;
        }

        // CarShop Services
        public async Task<IQueryable<CarShop>> GetCarShopsAsync()
        {
            return _context.CarShops.AsQueryable();
        }

        public async Task<CarShop> CreateCarShopAsync(CarShop carShop)
        {
            _context.CarShops.Add(carShop);
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "门店创建成功");
            return carShop;
        }

        public async Task<CarShop> UpdateCarShopAsync(CarShop carShop)
        {
            carShop.UpdatedTime = DateTime.Now;
            _context.Entry(carShop).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            _notificationService.Notify(NotificationSeverity.Success, "成功", "门店更新成功");
            return carShop;
        }

        public async Task DeleteCarShopAsync(int id)
        {
            var carShop = await _context.CarShops.FindAsync(id);
            if (carShop != null)
            {
                _context.CarShops.Remove(carShop);
                await _context.SaveChangesAsync();
                _notificationService.Notify(NotificationSeverity.Success, "成功", "门店删除成功");
            }
        }
    }
}