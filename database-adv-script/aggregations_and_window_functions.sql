-- =================================================================
-- Task 2: Aggregations and Window Functions
-- =================================================================
-- This script demonstrates the use of aggregation functions with GROUP BY
-- and advanced window functions for data analysis.
-- =================================================================


-- =================================================================
-- Query 1: Aggregation with COUNT and GROUP BY
-- =================================================================
-- Objective: Find the total number of bookings made by each user.
--
-- Logic:
-- 1. `COUNT(b.booking_id)` counts the number of bookings for each group.
-- 2. `GROUP BY u.user_id` groups all booking rows by user, so the COUNT
--    function calculates the total for each distinct user.
-- 3. We use a LEFT JOIN to ensure all users are included, even those with 0 bookings.

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
-- Query 2: Window Functions (RANK)
-- =================================================================
-- Objective: Rank properties based on the total number of bookings they have received.
--
-- Logic:
-- 1. A Common Table Expression (CTE) named `PropertyBookingCounts` is created first.
--    This CTE calculates the total number of bookings for each property.
-- 2. The main query then selects from this CTE.
-- 3. The `RANK() OVER (ORDER BY total_bookings DESC)` window function assigns a rank
--    to each property. The ranking is based on the `total_bookings` column in descending
--    order. Properties with the same number of bookings will receive the same rank.

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
-- Script End
-- =================================================================