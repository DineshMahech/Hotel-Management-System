# 🏨 Hotel Management System

## 📌 Project Overview

The Hotel Management System is a database management project developed using MySQL. It helps organize hotel information, including guest details, room availability, bookings, hotel services, payments, and staff records.

The project demonstrates the practical implementation of SQL queries and relational database concepts.

## 🛠️ Technologies Used

* MySQL
* SQL
* DBMS (Database Management System)
* MySQL Workbench

## 🎯 Project Objectives

* To design and manage a hotel database.
* To store and retrieve guest and room information.
* To manage room bookings and hotel services.
* To maintain payment and staff records.
* To practice SQL queries and relational database operations.

## ✨ Key Features

### 1. Guest Management

* Store guest names, phone numbers, email addresses, and addresses.
* Retrieve guest records from the database.

### 2. Room Management

* Maintain room types and prices.
* Check room availability.
* Retrieve available room details.

### 3. Booking Management

* Store booking details, including check-in and check-out dates.
* Retrieve booking information using SQL JOIN queries.
* Check room availability based on booking dates.

### 4. Hotel Services

* Maintain hotel service names and costs.
* Record services associated with individual bookings.
* Calculate service costs based on quantity.

### 5. Payment Management

* Store room costs, service costs, total amounts, payment dates, and payment methods.
* Retrieve payment details for individual bookings.
* Calculate total payments using aggregate functions.

### 6. Staff Management

* Maintain staff names, roles, and phone numbers.
* Associate staff members with rooms where applicable.

## 🗄️ Database Structure

The project contains the following seven tables:

| Table Name      | Description                                     |
| --------------- | ----------------------------------------------- |
| Guest           | Stores guest information                        |
| Room            | Stores room details, prices, and availability   |
| Booking         | Stores guest booking information                |
| Service         | Stores hotel services and their costs           |
| Booking_Service | Connects bookings with hotel services           |
| Payment         | Stores payment information                      |
| Staff           | Stores hotel staff details and room assignments |

## 💻 SQL Concepts Used

* CREATE DATABASE
* CREATE TABLE
* INSERT INTO
* SELECT
* WHERE
* JOIN
* GROUP BY
* ORDER BY
* Aggregate functions such as SUM()
* Primary keys and foreign keys
* Filtering and room availability queries

## 🚀 How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Clone or download this repository.
3. Open MySQL Workbench and connect to your MySQL Server.
4. Open the `Hotel_Management_System.sql` file.
5. Execute the SQL script to create the database, tables, insert sample records, and run the queries.
6. View the results in MySQL Workbench.

**Note:** Running the complete script again on a server where the same tables already exist may produce errors because the script does not first remove the existing database or tables.

## 📂 Project Files

* `Hotel_Management_System.sql` — Contains the database creation statements, table definitions, sample records, and SQL queries.

## 🎓 Learning Outcomes

* Understanding relational database design.
* Practicing SQL queries and table relationships.
* Using primary keys and foreign keys.
* Retrieving related data using JOIN operations.
* Performing data analysis using aggregate functions.

## 👨‍💻 Author

**Dinesh**

## 📄 Project Type

Academic DBMS / MySQL Project
