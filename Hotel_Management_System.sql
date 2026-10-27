CREATE DATABASE HotelManagementSystem;
USE HotelManagementSystem;

CREATE TABLE Guest (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    address TEXT
);

CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type VARCHAR(50),
    price DECIMAL(10,2),
    is_available BOOLEAN DEFAULT TRUE
);

CREATE TABLE Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    booking_date DATE,
    FOREIGN KEY (guest_id) REFERENCES Guest(guest_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Service (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100),
    cost DECIMAL(10,2)
);

CREATE TABLE Booking_Service (
    booking_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    PRIMARY KEY (booking_id, service_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    booking_id INT,
    room_cost DECIMAL(10,2),
    service_cost DECIMAL(10,2),
    total_amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    phone VARCHAR(15),
    assigned_room_id INT,
    FOREIGN KEY (assigned_room_id) REFERENCES Room(room_id)
);

-- How many tables are created in database HotelManagementSystem
--  List All Tables in the Database
SHOW TABLES;

-- Insert Guests
INSERT INTO Guest (name, phone, email, address) VALUES
('DINESH', '1234567890', 'dinesh@example.com', '123 Street A'),
('MOHIT', '0987654321', 'mohit@example.com', '456 Street B');
INSERT INTO Guest (name, phone, email, address) VALUES
('ARTIST', '9543217054', 'artist@example.com', '789 Street C');

-- Insert Rooms
INSERT INTO Room (room_type, price, is_available) VALUES
('Single', 800.00, TRUE),
('Double', 1250.00, TRUE),
('Suite', 1600.00, TRUE);
INSERT INTO Room (room_type, price, is_available) VALUES
('Standard', 1300.00, TRUE), 
('Economy', 1700.00, TRUE), 
('Deluxe', 1800.00, FALSE), 
('Luxury', 2000.00, FALSE);

SELECT * FROM Room;

-- Insert Services
INSERT INTO Service (service_name, cost) VALUES
('Room Cleaning', 250.00),
('Laundry', 250.00),
('Breakfast', 350.00);
INSERT INTO service (service_name, cost) VALUES
('Spa', 800.00), 
('Gym Access', 250.00), 
('Wi-Fi', 200.00), 
('Swimming Pool Access', 450.00), 
('Airport Pickup', 900.00); 

SELECT * FROM service;

-- Insert Bookings
INSERT INTO Booking (guest_id, room_id, check_in, check_out, booking_date) VALUES
(1, 1, '2025-05-01', '2025-05-05', '2025-04-28'),
(2, 2, '2025-05-02', '2025-05-06', '2025-04-29');
INSERT INTO Booking (guest_id, room_id, check_in, check_out, booking_date) VALUES
(3, 5, '2025-05-02', '2025-05-08', '2025-04-30');

SELECT * FROM Booking WHERE booking_id = 3;

-- Insert Booking_Service 
-- Booking 1 used Laundry and Breakfast
INSERT INTO Booking_Service (booking_id, service_id, quantity) VALUES
(1, 2, 1),  -- Laundry
(1, 3, 2);  -- Breakfast (2 times)

-- Booking 2 used Spa
INSERT INTO Booking_Service (booking_id, service_id, quantity) VALUES
(2, 4, 1);  -- Spa

-- Booking 3 used swimming pool access and breakfast
INSERT INTO Booking_Service (booking_id, service_id, quantity) VALUES
(3, 3, 1),  -- breakfast
(3, 7, 1);  -- swimming pool access

SELECT * FROM booking_service;

-- Insert Payments
INSERT INTO Payment (booking_id, room_cost, service_cost, total_amount, payment_date, payment_method) VALUES
(1, 800.00, 950.00, 1750.00, '2025-05-05', 'Credit Card'),
(2, 1250.00, 800.00, 2050.00, '2025-05-06', 'Cash');
INSERT INTO Payment (booking_id, room_cost, service_cost, total_amount, payment_date, payment_method) VALUES
(3, 1700.00, 800.00, 2500.00, '2025-05-08', 'Debit Card');

SELECT * FROM payment;

-- Insert Staff
INSERT INTO Staff (name, role, phone, assigned_room_id) VALUES
('Jatin', 'Housekeeper', '1112223333', 1),
('Harsh', 'Receptionist', '4445556666', NULL);
INSERT INTO Staff (name, role, phone, assigned_room_id) VALUES
('Banwari', 'personal Bodygaurd', '7645382910', 2);

--   List All Staff Assigned to Rooms
SELECT name, role, assigned_room_id FROM Staff WHERE assigned_room_id IS NOT NULL;

-- Get all guests
SELECT * FROM guest;

-- List all available rooms
SELECT * FROM Room WHERE is_available = TRUE;

--  checking room availability
-- Basic Availability Check
SELECT * FROM Room WHERE is_available = TRUE;

--  Availability Based on Booking Dates
SELECT * FROM Room
WHERE room_id NOT IN (
    SELECT room_id FROM Booking
    WHERE ('2025-05-01' < check_out AND '2025-05-05' > check_in)
);

-- To know the room type of the Guest
SELECT 
    b.booking_id,
    g.name AS guest_name,
    r.room_type,
    b.check_in,
    b.check_out
FROM Booking b
JOIN Room r ON b.room_id = r.room_id
JOIN Guest g ON b.guest_id = g.guest_id;

-- Show all bookings with guest info
SELECT b.booking_id, g.name, r.room_type, b.check_in, b.check_out
FROM Booking b
JOIN Guest g ON b.guest_id = g.guest_id
JOIN Room r ON b.room_id = r.room_id;

-- Get services used in a specific booking (filter by Guest)
SELECT s.service_name, s.cost
FROM Booking_Service bs
JOIN Service s ON bs.service_id = s.service_id
WHERE bs.booking_id = 1;

--  Retrieve Services Used by a Booking (filter by Guest)
SELECT 
    bs.booking_id,
    s.service_name,
    s.cost
FROM Booking_Service bs
JOIN Service s ON bs.service_id = s.service_id
WHERE bs.booking_id = 1;

-- Retrieve Services Used by all the Guests and its charges
SELECT 
    g.name AS guest_name,
    s.service_name,
    bs.quantity,
    s.cost,
    (s.cost * bs.quantity) AS total_service_cost
FROM Booking_Service bs
JOIN Booking b ON bs.booking_id = b.booking_id
JOIN Guest g ON b.guest_id = g.guest_id
JOIN Service s ON bs.service_id = s.service_id
ORDER BY g.name;

-- Total Payment for a Specific Booking (filter by Guest)
SELECT 
    booking_id,
    SUM(total_amount) AS total_payment_received
FROM Payment
WHERE booking_id = 1
GROUP BY booking_id;

-- Total Payment from All Bookings
SELECT 
    booking_id,
    SUM(total_amount) AS total_payment_received
FROM Payment
GROUP BY booking_id;

--  Total payment with Guest Name and Room Info
SELECT 
    g.name AS guest_name,
    r.room_type,
    p.booking_id,
    SUM(p.total_amount) AS total_payment_received
FROM Payment p
JOIN Booking b ON p.booking_id = b.booking_id
JOIN Guest g ON b.guest_id = g.guest_id
JOIN Room r ON b.room_id = r.room_id
GROUP BY p.booking_id;

-- Total payment breakdown by Room Cost vs Service Cost
SELECT 
    g.name AS guest_name,
    r.room_type,
    p.booking_id,
    p.room_cost,
    p.service_cost,
    p.total_amount,
    p.payment_date,
    p.payment_method
FROM Payment p
JOIN Booking b ON p.booking_id = b.booking_id
JOIN Guest g ON b.guest_id = g.guest_id
JOIN Room r ON b.room_id = r.room_id
ORDER BY p.payment_date;

-- Total payment by Guest
SELECT 
    g.name AS guest_name,
    SUM(p.room_cost) AS total_room_cost,
    SUM(p.service_cost) AS total_service_cost,
    SUM(p.total_amount) AS total_paid
FROM Payment p
JOIN Booking b ON p.booking_id = b.booking_id
JOIN Guest g ON b.guest_id = g.guest_id
GROUP BY g.name;


