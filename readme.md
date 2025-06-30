# 汽车销售管理系统

## 项目概览
本仓库提供一个面向汽车销售门店的管理平台，涵盖车辆、客户、订单等业务模块。后端使用 **Spring Boot** 提供 REST API，数据存储使用 **MySQL**；后台管理界面可选择新版的 **BlazorAdminSystem** 或旧版的 Vue 方案，面向顾客的页面位于 `front` 目录。

## 环境要求
- **MySQL 5.7+**
- **JDK 8+** 与 **Maven 3.5+**
- **.NET 9 SDK**（运行 BlazorAdminSystem）
- **Node.js 14+**（如需启动旧的 Vue 管理端）

安装完成后可分别运行 `mysql --version`、`mvn -v`、`dotnet --version`、`node -v` 进行验证。

## 项目结构
```
.
├─ BlazorAdminSystem/         # 基于 .NET 的后台管理界面
├─ carsale-master2/           # Spring Boot 后端
├─ front/                     # 客户可访问的静态网页
├─ vue-element-admin-template/# 旧版 Vue 管理端
├─ carsale.sql                # 数据库初始化脚本
├─ images/                    # 截图目录
└─ ...
```

## 使用指南
### 1. 配置数据库
1. 在 MySQL 中创建名为 `carsale` 的数据库；
2. 执行根目录下的 `carsale.sql` 导入表结构与初始数据；
3. 修改以下文件中的连接信息以匹配本地环境：
   - `carsale-master2/src/main/resources/application.yml`
   - `BlazorAdminSystem/appsettings.json`

### 2. 启动 Spring Boot 后端
```bash
cd carsale-master2
mvn spring-boot:run
```
启动成功后默认监听 `http://localhost:8080`。

### 3. 体验前台页面
客户访问的简单示例位于 `front` 目录，可直接打开 `index.html` 或 `login.html` 体验注册、购车等流程。

### 4. 运行 BlazorAdminSystem
1. 打开 `BlazorAdminSystem.sln`（或执行 `dotnet run --project BlazorAdminSystem`）；
2. 系统基于 Radzen.Blazor 构建，默认地址为 `https://localhost:xxxxx`；
3. 管理端包含如下模块：
   - 品牌、车系与车辆管理
   - 客户与员工管理
   - 订单及订单明细
   - 门店信息维护

### 5. 旧版 Vue 管理端（可选）
如需了解早期实现，可在 `vue-element-admin-template` 目录执行：
```bash
npm install
npm run dev
```
默认运行在 `http://localhost:9527`。

## 功能截图
以下图片为占位示例，实际效果请替换为真实截图：

![登录](./images/1.png)
![首页](./images/2.png)
![车辆管理](./images/3.png)

## 更多资料
仓库中还提供 `12毕业论文.doc` 等文档，可作为系统设计与实现的参考。
