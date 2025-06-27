-- =================================================================
-- Airbnb Clone Database Seeding Script
-- =================================================================
-- This script populates the database with realistic sample data.
-- It should be run AFTER the schema.sql script has been executed.
-- We are using hardcoded UUIDs for consistency and to ensure
-- relationships between tables are correctly established.
-- =================================================================

-- To generate new UUIDs, you can use an online generator or
-- the uuid-ossp extension in PostgreSQL with the uuid_generate_v4() function.

-- =================================================================
-- Step 1: Clear Existing Data (Optional but Recommended)
-- =================================================================
-- This ensures that if you run the script multiple times, you won't
-- create duplicate data. The order is reversed from creation.

DELETE FROM Message;
DELETE FROM Review;
DELETE FROM Payment;
DELETE FROM Booking;
DELETE FROM Property;
DELETE FROM "User";

-- =================================================================
-- Step 2: Insert Sample Users
-- =================================================================
-- Creating a few users with different roles (host, guest, admin).

INSERT INTO "User" (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'John', 'Doe', 'john.doe@example.com', 'hash_pw_123', '123-456-7890', 'host'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Jane', 'Smith', 'jane.smith@example.com', 'hash_pw_456', '234-567-8901', 'guest'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a13', 'Admin', 'User', 'admin@airbnb.clone', 'hash_pw_789', '345-678-9012', 'admin'),
('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Sam', 'Jones', 'sam.jones@example.com', 'hash_pw_abc', '456-789-0123', 'host');

-- =================================================================
-- Step 3: Insert Sample Properties
-- =================================================================
-- Properties are linked to the hosts created above.

INSERT INTO Property (property_id, host_id, name, description, location, price_per_night) VALUES
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Cozy Beachfront Cottage', 'A beautiful cottage right on the beach, perfect for a romantic getaway.', 'Malibu, California', 300.00),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b22', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Modern Downtown Loft', 'Stylish loft in the heart of the city, with stunning skyline views.', 'New York, New York', 250.00),
('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a14', 'Rustic Mountain Cabin', 'Escape to the mountains in this charming and secluded cabin.', 'Aspen, Colorado', 450.00);

-- =================================================================
-- Step 4: Insert Sample Bookings
-- =================================================================
-- A booking made by a guest for one of the properties.

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c31', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2025-08-01', '2025-08-05', 1200.00, 'confirmed'),
('c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c32', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b23', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', '2025-09-10', '2025-09-15', 2250.00, 'pending');

-- =================================================================
-- Step 5: Insert Sample Payments
-- =================================================================
-- A payment linked to the confirmed booking.

INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('d0eebc99-9c0b-4ef8-bb6d-6bb9bd380d41', 'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380c31', 1200.00, 'credit_card');

-- =================================================================
-- Step 6: Insert Sample Reviews
-- =================================================================
-- A review from the guest for the completed booking.

INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('e0eebc99-9c0b-4ef8-bb6d-6bb9bd380e51', 'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380b21', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 5, 'Absolutely amazing stay! The view was incredible and the cottage was perfect. Highly recommend!');

-- =================================================================
-- Step 7: Insert Sample Messages
-- =================================================================
-- A message thread between the guest and the host.

INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f61', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Hi John, we are so excited for our stay! Just wanted to confirm the check-in time.'),
('f0eebc99-9c0b-4ef8-bb6d-6bb9bd380f62', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a12', 'Hi Jane! Glad to hear it. Check-in is anytime after 3 PM. Let me know if you need anything!');

-- =================================================================
-- Script End
-- =================================================================