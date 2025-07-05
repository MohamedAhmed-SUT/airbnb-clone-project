-- =================================================================
-- Task 1: Practicing SQL Subqueries
-- =================================================================
-- This script contains two queries demonstrating the use of
-- non-correlated and correlated subqueries.
-- =================================================================


-- =================================================================
-- Query 1: Non-Correlated Subquery
-- =================================================================
-- Objective: Find all properties where the average rating is greater than 4.0.
--
-- Logic:
-- 1. The inner query runs first. It calculates the average rating for each property
--    and returns a list of only those property_ids where the average is > 4.0.
-- 2. The outer query then takes this list of IDs and retrieves all details
--    for the properties in that list.

SELECT
    p.property_id,
    p.name,
    p.location
FROM
    Property AS p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            Review AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );


-- =================================================================
-- Query 2: Correlated Subquery
-- =================================================================
-- Objective: Find users who have made more than 3 bookings.
--
-- Logic:
-- 1. The outer query iterates through each row of the "User" table (aliased as 'u').
-- 2. For each user 'u', the inner query is executed. It counts the number of bookings
--    in the Booking table where the user_id matches the current user's ID (`b.user_id = u.user_id`).
-- 3. The outer query's WHERE clause then checks if this count is greater than 3.
--    If it is, the user's details are included in the final result.
--
-- Note: While this demonstrates a correlated subquery, a JOIN with GROUP BY
-- is often more performant for this specific problem.

SELECT
    u.user_id,
    u.first_name,
    u.last_name
FROM
    "User" AS u
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            Booking AS b
        WHERE
            b.user_id = u.user_id
    ) > 3;

-- =================================================================
-- Script End
-- =================================================================