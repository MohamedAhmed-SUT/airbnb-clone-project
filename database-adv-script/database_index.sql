-- =================================================================
-- Task 3: Index Implementation for Performance Optimization (Corrected)
-- =================================================================
-- This script demonstrates the process of analyzing query performance,
-- creating an index, and then re-analyzing to show improvement.
-- =================================================================


-- =================================================================
-- Step 1: Analyze Query Performance BEFORE Indexing
-- =================================================================
-- We use EXPLAIN ANALYZE to see the execution plan for a common query:
-- finding a user by their email. Without an index, this will
-- result in a slow "Sequential Scan".

EXPLAIN ANALYZE
SELECT * FROM "User" WHERE email = 'jane.smith@example.com';


-- =================================================================
-- Step 2: Create the Index
-- =================================================================
-- Based on the analysis, we create an index on the `email` column
-- to speed up these lookups.

CREATE INDEX IF NOT EXISTS idx_user_email ON "User"(email);


-- =================================================================
-- Step 3: Analyze Query Performance AFTER Indexing
-- =================================================================
-- We run the exact same query again. Now, the database query planner
-- should choose to use the new index, resulting in a much faster
-- "Index Scan".

EXPLAIN ANALYZE
SELECT * FROM "User" WHERE email = 'jane.smith@example.com';


-- =================================================================
-- Additional Recommended Indexes
-- =================================================================
-- Below are other indexes that were identified as beneficial for the
-- overall application performance.

CREATE INDEX IF NOT EXISTS idx_property_host_id ON Property(host_id);
CREATE INDEX IF NOT EXISTS idx_property_location ON Property(location);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON Booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON Booking(property_id);
CREATE INDEX IF NOT EXISTS idx_review_property_id ON Review(property_id);
CREATE INDEX IF NOT EXISTS idx_review_user_id ON Review(user_id);


-- =================================================================
-- Script End
-- =================================================================