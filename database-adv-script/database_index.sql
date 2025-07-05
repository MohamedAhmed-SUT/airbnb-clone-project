-- =================================================================
-- Task 3: Index Implementation for Performance Optimization
-- =================================================================
-- This script creates indexes on high-usage columns to improve
-- the performance of common queries in the Airbnb Clone database.
-- =================================================================

-- Indexes are crucial for speeding up query performance, especially
-- on columns that are frequently used in WHERE clauses or for JOINs.

-- Index on the User table's email column for fast lookups during login.
CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email);

-- Index on the Property table's host_id for quickly finding all properties of a host.
CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);

-- Index on the Property table's location for speeding up location-based searches.
CREATE INDEX IF NOT EXISTS idx_property_location ON Property(location);

-- Index on the Booking table's user_id to quickly retrieve a user's booking history.
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);

-- Index on the Booking table's property_id to quickly find all bookings for a property.
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);

-- Index on the Review table's property_id for fast retrieval of all reviews for a property.
CREATE INDEX IF NOT EXISTS idx_review_property_id ON Review(property_id);

-- Index on the Review table's user_id to find all reviews written by a specific user.
CREATE INDEX IF NOT EXISTS idx_review_user_id ON Review(user_id);

-- =================================================================
-- Script End
-- =================================================================