-- =================================================================
-- Task 5: Table Partitioning for Performance Optimization
-- =================================================================
-- This script demonstrates how to implement range partitioning on the
-- Booking table based on the start_date column.
-- =================================================================


-- =================================================================
-- Step 1: Create the Partitioned Parent Table
-- =================================================================
-- We first create a new parent table, `Booking_Partitioned`, which defines
-- the overall structure and the partitioning key (`start_date`).
-- Data is not stored in this parent table directly.

CREATE TABLE Booking_Partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status booking_status NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);


-- =================================================================
-- Step 2: Create Partitions for Different Date Ranges
-- =================================================================
-- Now, we create the actual tables (partitions) where the data will be stored.
-- Each partition holds data for a specific range of `start_date` values.
-- The database will automatically route rows to the correct partition.

-- Partition for bookings in 2024
CREATE TABLE bookings_y2024 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for bookings in 2025
CREATE TABLE bookings_y2025 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Partition for bookings in 2026
CREATE TABLE bookings_y2026 PARTITION OF Booking_Partitioned
    FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- A default partition can be created to catch any data that doesn't
-- fit into the defined ranges, although it's often better to have
-- well-defined ranges for all expected data.


-- =================================================================
-- Example Query Benefiting from Partitioning
-- =================================================================
-- When this query is run, the database planner knows it only needs
-- to scan the `bookings_y2025` partition, ignoring all others. This is
-- called "partition pruning" and is the source of the performance gain.

-- SELECT * FROM Booking_Partitioned WHERE start_date >= '2025-06-01' AND start_date < '2025-07-01';

-- =================================================================
3.1. Performance Before Partitioning (Simulated)
On a single, massive, non-partitioned table, the query planner would use an index on start_date. While much better than a full table scan, it still has to scan a large portion of a very large index to find all the matching rows.
Sample EXPLAIN ANALYZE Output (Non-Partitioned):
Generated code
QUERY PLAN
---------------------------------------------------------------------------------------------------------
 Index Scan using idx_booking_start_date on Booking  (cost=0.56..1500.50 rows=50000 width=72) (actual time=1.20..250.75 ms rows=50000 loops=1)
   Index Cond: ((start_date >= '2025-07-01'::date) AND (start_date < '2025-08-01'::date))
 Execution Time: 255.80 ms
Use code with caution.
Key Takeaway: The query is fast but still takes ~256 ms because it has to search within a huge index.
3.2. Performance After Partitioning
With partitioning, the database query planner is smart enough to know that dates in July 2025 can only exist in the bookings_y2025 partition. This is called Partition Pruning. It completely ignores all other partitions (bookings_y2024, bookings_y2026, etc.), dramatically reducing the amount of data to search.
Sample EXPLAIN ANALYZE Output (Partitioned):
Generated code
QUERY PLAN
--------------------------------------------------------------------------------------------------------------
 Append  (cost=0.42..95.50 rows=50000 width=72) (actual time=0.05..20.30 ms rows=50000 loops=1)
   ->  Index Scan using idx_bookings_y2025_start_date on bookings_y2025  (cost=0.42..95.50 rows=50000 width=72) (actual time=0.05..15.15 ms rows=50000 loops=1)
         Index Cond: ((start_date >= '2025-07-01'::date) AND (start_date < '2025-08-01'::date))
 Execution Time: 25.45 ms
Use code with caution.
Key Takeaway: The planner now only scans the much smaller bookings_y2025 partition. The execution time has dropped to ~25 ms, a 10x improvement.
4. Conclusion
Table partitioning is a powerful advanced technique for managing very large datasets. By splitting the Booking table by date range, we enable partition pruning, which significantly speeds up time-based queries. This strategy is essential for maintaining high performance and scalability in applications with large, time-series data.
Generated code
### **Step 4: Update the Main `README.md`**

Append this new section to your main `database-adv-script/README.md` file.

```markdown

---

### Task 5: Partitioning Large Tables

This task explores an advanced optimization technique for very large datasets.

- **`partitioning.sql`**: Contains the DDL script to create a new, partitioned version of the `Booking` table. It demonstrates how to implement range partitioning based on the `start_date`.
- **`partition_performance.md`**: A report explaining the concept of partitioning and its benefits. It includes a simulated analysis showing how "partition pruning" dramatically improves the performance of date-range queries compared to a non-partitioned table.
-- =================================================================