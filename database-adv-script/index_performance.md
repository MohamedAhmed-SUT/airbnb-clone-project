# Index Performance Optimization Report

## 1. Introduction

This report details the process of identifying and implementing database indexes to optimize query performance for the Airbnb Clone application. The primary goal is to reduce query execution time for common read operations by creating indexes on high-usage columns.

---

## 2. Identification of High-Usage Columns

Based on the application's core features (user login, property search, viewing bookings), the following columns were identified as candidates for indexing due to their frequent use in `WHERE` clauses and `JOIN` operations:

- **`User.email`**: Used constantly for user authentication and login.
- **`Property.host_id`**: Used to join with the `User` table to find properties listed by a specific host.
- **`Property.location`**: Used heavily in search and filtering queries.
- **`Booking.user_id`**: Used to fetch the booking history for a specific user.
- **`Booking.property_id`**: Used to check availability and retrieve all bookings for a property.
- **`Review.property_id`**: Used to display all reviews on a property's detail page.

---

## 3. Index Implementation

The following `CREATE INDEX` commands were executed to create the necessary indexes. The full script is available in `database_index.sql`.

```sql
CREATE INDEX idx_user_email ON "User"(email);
CREATE INDEX idx_property_host_id ON Property(host_id);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
-- ... and so on for other indexes.