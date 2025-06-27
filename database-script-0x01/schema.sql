-- =================================================================
-- Airbnb Clone Database Schema
-- =================================================================
-- This script creates the tables, constraints, and indexes
-- for the Airbnb Clone project.
-- =================================================================

-- Drop existing tables and types to ensure a clean setup
DROP TABLE IF EXISTS Message, Review, Payment, Booking, Property, "User" CASCADE;
DROP TYPE IF EXISTS user_role, booking_status, payment_method;

-- =================================================================
-- Step 1: Create ENUM Types
-- =================================================================
-- ENUM types provide a set of predefined constants, which improves
-- data integrity and readability.

CREATE TYPE user_role AS ENUM ('guest', 'host', 'admin');
CREATE TYPE booking_status AS ENUM ('pending', 'confirmed', 'canceled');
CREATE TYPE payment_method AS ENUM ('credit_card', 'paypal', 'stripe');

-- =================================================================
-- Step 2: Create Tables
-- =================================================================

-- User Table
-- Stores information about all users (guests, hosts, and admins).
CREATE TABLE "User" (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    role user_role NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Property Table
-- Stores details about the properties listed by hosts.
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    location VARCHAR(255) NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL CHECK (price_per_night >= 0),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_host FOREIGN KEY(host_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

-- Booking Table
-- Manages all booking records made by users for properties.
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property FOREIGN KEY(property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_user FOREIGN KEY(user_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

-- Payment Table
-- Records payment details for each confirmed booking.
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID UNIQUE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    payment_method payment_method NOT NULL,
    CONSTRAINT fk_booking FOREIGN KEY(booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE
);

-- Review Table
-- Stores user reviews and ratings for properties after a booking.
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_property_review FOREIGN KEY(property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_review FOREIGN KEY(user_id) REFERENCES "User"(user_id) ON DELETE SET NULL
);

-- Message Table
-- Facilitates communication between users (e.g., guest to host).
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sender FOREIGN KEY(sender_id) REFERENCES "User"(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_recipient FOREIGN KEY(recipient_id) REFERENCES "User"(user_id) ON DELETE CASCADE
);

-- =================================================================
-- Step 3: Create Indexes for Performance
-- =================================================================
-- Indexes are crucial for speeding up query performance, especially
-- on columns that are frequently used in WHERE clauses or JOINs.

CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_review_property_id ON Review(property_id);
CREATE INDEX idx_review_user_id ON Review(user_id);
CREATE INDEX idx_message_sender_id ON Message(sender_id);
CREATE INDEX idx_message_recipient_id ON Message(recipient_id);

-- =================================================================
-- Script End
-- =================================================================