# 🚘 Uber-Inspired Oracle Database Project

## 📚 Project Overview

This project models the database of a ride-hailing platform like Uber using Oracle Database. It captures customer and driver data, trip bookings, real-time statuses, payments, vehicle assignments, and surge pricing — all while enforcing role-based access control for different types of system users.

---

## 🗃️ Database Schema

Tables in the project:

- `CUSTOMER`: Stores customer details and ratings.
- `DRIVER`: Contains driver information and licensing data.
- `DRIVER_STATUS`: Tracks driver's availability and location.
- `PAYMENT`: Records payment information per trip.
- `RIDE_TYPE`: Stores categories of ride services (e.g., Pool, Premium).
- `STATUS`: Represents real-time trip status states.
- `STATUS_MASTER`: Defines status types and classifications.
- `SURGE_PRICING`: Implements surge pricing based on day/time and demand.
- `TRIP`: Main transaction table recording ride activity.
- `TRIP_STATUS`: Logs the progression of trip statuses over time.
- `VEHICLE`: Maps vehicles to drivers and ride types.

---

## 👥 User Roles & Access Control

| Role               | Description                                                                 |
|--------------------|-----------------------------------------------------------------------------|
| `ADMIN`            | **Bootstrap-only** role — used exclusively to create `APPLICATION_ADMIN`. No operational privileges granted. |
| `APPLICATION_ADMIN`| Full administrative privileges — only create other users, create tables |
| `CUSTOMER`         | Can book rides, view trip/payment history, update profile, and give ratings/feedback |
| `DRIVER`           | Views trips, updates trip statuses and their availability/location          |
| `FLEET_MANAGER`    | Manages vehicle records and driver-vehicle associations                     |

---

## 🔍 Project Views

The following views are implemented to provide **role-based and filtered access** to sensitive data. These are defined in `3_views.sql` and execute without errors.

| View Name                   | Description                                                               |
|-----------------------------|---------------------------------------------------------------------------|
| `VW_CUSTOMER_PROFILE`       | Shows personal profile data for the currently logged-in customer          |
| `VW_CUSTOMER_TRIPS`         | Displays all past trips for the logged-in customer                        |
| `VW_DRIVER_TRIPS`           | Lists all trips a driver was assigned to (based on matching driver ID)    |
| `VW_SUPPORT_CASES`          | Shows trips that were cancelled, viewable by admin/application admin      |
| `VW_REQUESTED_TRIPS`        | Displays requested trips for further analysis (by status)                 |
| `LOW_RATED_TRIPS`           | Lists trips with a rating lower than 3, for review by fleet management/support teams |
| `VW_DRIVER_WEEKLY_EARNINGS` | Shows weekly trip counts and earnings for each driver                     |
| `VW_DRIVERS_WITHOUT_LICENSE`| Displays drivers who registered but did not provide a license number     |


---

## Steps to Run

1. **Run `Creating_Users_Grants.sql`**  
   This will create new users and provide access to the application admin.

2. **Run DDL queries with `Create_Tables.sql`**  
   Execute this script to create the necessary tables in the database.

3. **Run table-specific grants to database users by executing `Assigning_Grants_To_User_Roles.sql`**  
   This will assign the appropriate permissions to the database users.

4. **Add sample data into the database using the DML query file `Uber_Sample_Data.sql`**  
   This will populate the database with sample data for testing purposes.

5. **To run the views, execute `Uber-Views.sql`**  
   This script will create the views and also include grants for specific database users to access those views.
