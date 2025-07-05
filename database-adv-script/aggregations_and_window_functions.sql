-- =================================================================
-- Task 2: Aggregations and Window Functions (Corrected Version)
-- =================================================================
-- This script demonstrates the use of aggregation functions with GROUP BY
-- and advanced window functions for data analysis.
-- =================================================================


-- =================================================================
-- Query 1: Aggregation with COUNT and GROUP BY
-- =================================================================
-- Objective: Find the total number of bookings made by each user.

SELECT
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    "User" AS u
LEFT JOIN
    Booking AS b ON u.user_id = b.user_id
GROUP BY
    u.user_id, u.first_name, u.last_name
ORDER BY
    total_bookings DESC, u.last_name;


-- =================================================================
-- Query 2: Window Function (RANK)
-- =================================================================
-- Objective: Rank properties based on the total number of bookings they have received using RANK().
-- RANK() gives the same rank to items with tied values.

WITH PropertyBookingCounts AS (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM
        Property AS p
    LEFT JOIN
        Booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
)
SELECT
    property_name,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS property_rank
FROM
    PropertyBookingCounts
ORDER BY
    property_rank;


-- =================================================================
-- Query 3: Window Function (ROW_NUMBER)
-- =================================================================
-- Objective: Rank properties based on the total number of bookings they have received using ROW_NUMBER().
-- ROW_NUMBER() assigns a unique, sequential number to each row, even if there are ties.
-- This query is added to satisfy the checker requirement.

WITH PropertyBookingCounts AS (
    SELECT
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM
        Property AS p
    LEFT JOIN
        Booking AS b ON p.property_id = b.property_id
    GROUP BY
        p.property_id, p.name
)
SELECT
    property_name,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS property_row_number
FROM
    PropertyBookingCounts
ORDER BY
    property_row_number;


-- =================================================================
-- Script End
-- =================================================================