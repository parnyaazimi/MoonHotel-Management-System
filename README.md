# MoonHotel Management System

A desktop hotel management application developed with **C#, WPF, and MySQL**. MoonHotel provides a graphical interface for managing hotel reservations, customers, employees, orders, services, inventory, and reports.

## Overview

MoonHotel is a hotel management system designed to organize common hotel operations through a Windows desktop application connected to a MySQL database.

The project combines a WPF user interface with database operations and SQL scripts for managing hotel-related data and demonstrating database concepts.

## Features

### 🏨 Hotel Reservations

- Room reservation workflow
- Room and room-type management
- Reservation and room status management

### 👥 Customer & Employee Management

- New customer registration
- Existing customer access
- Employee registration and login interface
- Employee panel and role management
- Customer contact information management

### 🛎️ Orders & Hotel Services

- Food ordering
- Hotel facility orders
- Shop product orders
- Book orders
- Service and price management

### 📦 Inventory Management

- Room management
- Food menu management
- Shop product management
- Book inventory management
- Facility management

### 📊 Reports & Database Operations

- Hotel revenue report
- Customer ranking
- Reservation reports
- Services and prices
- Hotel ratings and reviews
- Food sales report
- Book inventory report
- Staff and roles report
- Order history
- Unpaid invoices

### 🗄️ Database Components

The SQL files include database tables and sample data, queries, indexes, stored procedures, functions, cursor-based operations, triggers, and transaction-related scripts.

## Technologies Used

- **C#**
- **.NET 8**
- **Windows Presentation Foundation (WPF)**
- **MySQL**
- **MySql.Data**
- **SQL**

## Project Structure

```text
MoonHotel-Management-System/
├── Backend/
│   └── MoonHotel/
│       ├── Backend/
│       │   └── DatabaseManager.cs
│       ├── Models/
│       ├── View/
│       ├── App.xaml
│       ├── MainWindow.xaml
│       ├── MoonHotel.csproj
│       └── MoonHotel.sln
├── function_Index/
│   └── sql.sql
├── SP_cursor/
│   └── sql.sql
├── Tables_Queries/
│   └── Tables&Queries.sql
├── transaction/
│   └── sql.sql
├── Triggers/
│   └── Triggers.sql
└── README.md
```

## Getting Started

### Prerequisites

Before running the application, make sure you have:

- Windows
- Visual Studio with the .NET desktop development workload
- .NET 8 SDK
- A running MySQL server
- A MySQL database configured for the application

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/YOUR_USERNAME/MoonHotel-Management-System.git
   ```

2. Open `Backend/MoonHotel/MoonHotel.sln` in Visual Studio.
3. Create and configure the MySQL database using the provided SQL scripts. Review the scripts and execute the required schema and setup statements in the appropriate order.
4. Configure the application's database connection settings in `DatabaseManager.cs` to match your local MySQL environment.
5. Restore the NuGet packages and build the solution.
6. Run the application from Visual Studio.

> **Note:** The database must be configured before the application can use database-dependent features. The SQL files may need to be reviewed to determine the required execution order.

## Database

The database design covers hotel information and ratings, rooms, reservations, customers, staff, services, orders, invoices, payments, reviews, books, food menus, facilities, and shop products.

The accompanying SQL scripts demonstrate several database concepts, including:

- Relational tables and queries
- Indexes
- Stored procedures
- SQL functions
- Cursors
- Triggers
- Transactions and invoice-related operations

## 🎓 Academic Information

- **Course:** Database Design Laboratory
- **Academic Level:** Bachelor's Degree - Fourth Semester
- **Project Type:** University Course Project
- **Instructor:** Reza Torkashvand
- **Completion Date:** June 2026

## 🤝 Teamwork & Acknowledgements

This project was developed collaboratively as part of a university course, in cooperation with two of my classmates. I was responsible for a substantial portion of the project's implementation, while the project was completed through our collaborative efforts.

I appreciate my teammates' contributions and collaboration throughout the development process.

## Security Note

Database credentials should never be committed to a public repository. Configure your own local connection settings, and use a configuration file excluded from version control or an appropriate secrets-management approach.

## Project Purpose

This project brings together desktop application development, database connectivity, SQL programming, and the design of a multi-feature hotel management system.
