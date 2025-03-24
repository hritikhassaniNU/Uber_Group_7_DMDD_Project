# 🚘 Uber-Inspired Oracle Database Project

## 📚 Project Overview

This project models the database of a ride-hailing platform like Uber using Oracle Database. It captures customer and driver data, trip bookings, real-time statuses, payments, vehicle assignments, and surge pricing — all while enforcing role-based access control for different types of system users.

---

## 🗃️ Database Schema

Final tables in the project:

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

| View Name                  | Description                                                               |
|---------------------------|----------------------------------------------------------------------------|
| `customer_profile_view`   | Shows personal profile data for the currently logged-in customer           |
| `customer_trip_history`   | Displays all past trips for the logged-in customer                         |
| `driver_trip_history`     | Lists all trips a driver was assigned to (based on matching driver ID)     |
| `cancelled_trip_history`  | Shows trips that were cancelled, viewable by admin/application admin       |

---
