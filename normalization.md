# Database Normalization Report for Airbnb Clone Project

## Introduction

This document outlines the normalization process and confirms that the database schema for the Airbnb Clone project adheres to the principles of Third Normal Form (3NF). The goal of normalization is to reduce data redundancy, prevent data anomalies (insertion, update, and deletion anomalies), and ensure data integrity.

Our database design was structured from the outset to be compliant with these principles.

---

## First Normal Form (1NF)

**Rule:** A table is in 1NF if all its columns contain atomic (indivisible) values, and each record is unique. There should be no repeating groups of columns.

**Application:**
All tables in our schema satisfy 1NF.
- Each cell holds a single piece of information (e.g., the `User` table has separate `first_name` and `last_name` columns, not a single `full_name` column).
- Each table has a unique Primary Key (e.g., `user_id`, `property_id`) which ensures that every row is unique.

---

## Second Normal Form (2NF)

**Rule:** A table is in 2NF if it is in 1NF and all of its non-key attributes are fully functionally dependent on the entire primary key. This rule is primarily concerned with tables that have a composite primary key (a key made of two or more columns).

**Application:**
All tables in our schema satisfy 2NF.
- The primary key for every table (`User`, `Property`, `Booking`, etc.) is a single column (e.g., `user_id`).
- Since there are no composite primary keys, there cannot be any partial dependencies. Therefore, the schema inherently meets the 2NF requirement.

---

## Third Normal Form (3NF)

**Rule:** A table is in 3NF if it is in 2NF and has no transitive dependencies. A transitive dependency exists when a non-key attribute is dependent on another non-key attribute, which in turn is dependent on the primary key.

**Application:**
All tables in our schema satisfy 3NF.
- In each table, all non-key attributes depend directly and only on the primary key, not on any other non-key attribute.
- For example, in the `Property` table, attributes like `name`, `description`, and `price_per_night` are all direct characteristics of a `property_id`. The `location` does not depend on the `name`; they both depend on the `property_id`.
- By separating entities like `User`, `Property`, and `Booking` into their own tables, we have eliminated potential transitive dependencies. For instance, we don't store host details (like `host_email`) in the `Property` table; instead, we use a foreign key `host_id` that links to the `User` table.

## Conclusion

The database schema for the Airbnb Clone project is fully normalized to 3NF. This design ensures an efficient, reliable, and scalable database structure, which is critical for a production-level application.