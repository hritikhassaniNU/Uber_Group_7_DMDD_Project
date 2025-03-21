# Uber_Group_7_DMDD_Project

## TODO

- [x] Setting up **env**
- [x] Different Roles Creation
  - [x] Granting access to Roles
  - [x] Unlimited disk space
- [x] Create Table
- [x] Insert Data
- [ ] Create views
- [ ] Changes in Create Table (Add Sequence or Auto Increment for primary Key)
- [ ] Recheck
  - [ ] Views 
  - [ ] Check for index (optional)
- [ ] Create procedure (register procedure, check for flights procedures, book flight procedure, etc)
- [ ] Create Triggers
- [ ] Create Reports

## Usage

> [!IMPORTANT]
> Create DB Admin using Oracle Cloud console

> [!CAUTION]
> Run cleanup script present in `cleanup/kill_all_sessions.sql`

### Create users

1. Create `APP ADMIN` user

   > **Using account**: `DB ADMIN`

   ```sh
    env setup/create users/[1] create_app_admin_user.sql
   ```

2. Create all other users (Developer, HR, etc)
   > **Using account**: `APP ADMIN`

   ```sh
    env setup/create users/[2] create_all_users.sql
   ```

### Create Stored Procedures [APP ADMIN]

1. Create Store Procedure for `APP ADMIN`

   > **Using account**: `APP ADMIN`

   ```sh
    stored procedures/[3] grant_access_to_user.sql
   ```

### Grant Access to Developer

1. granting access to developer

    > **Using account**: `APP ADMIN`

   ```sh
    env setup/grant access/[4] grant_access_developer.sql
   ```

### Create Stored Procedures [DEVELOPER]

1. Create Store Procedure for `DEVELOPER`

   > **Using account**: `DEVELOPER`

   ```sh
    stored procedures/[3] grant_access_to_user.sql
   ```

### Create tables

1. Create tables using developer

   > **Using account**: `DEVELOPER`

  ```sh
    table setup/[5] Airline_Independent_Tables.sql
    table setup/[6] Airline_Dependent_Tables.sql
  ```

### Run Triggers

1. Run Trigger using developer
   > **Using account**: `DEVELOPER`

  ```sh
    trigger setup/[1] check_crew_assignment.sql
    trigger setup/[2] check_flight_schedule_insert.sql
    trigger setup/[3] check_flight_schedule_update.sql
    trigger setup/[4] check_inventory.sql
  ```


### Grant Access to tables for different users

1. Grant access to tables to different users

   > **Using account**: `DEVELOPER`

   ```sh
    env setup/grant access/[7] grant_access_to_all_users.sql
   ```

### Insert Data into table

1. Insert data

   > **Using account**: `DEVELOPER`

   ```sh
      [1] insert_data/aircraft_insert_data.sql
      [2] insert_data/route_insert_data.sql
      [3] insert_data/maintenance_schedule_insert_data.sql
      [4] insert_data/inventory_insert_data.sql
      [5] insert_data/employee_insert_data.sql
      [6.0] insert_data/wallet_insert_data.sql
      [6.1] insert_data/passenger_insert_data.sql
      [7] insert_data/inventory_order_insert_data.sql
      [8] insert_data/flight_schedule_insert_data.sql
      [9] insert_data/seat_insert_data.sql
      [10] insert_data/crew_assignment_insert_data.sql
      [11] insert_data/maintenance_record_insert_data.sql
      [12] insert_data/ground_ops_schedule.sql
      [13] insert_data/reservation_insert_data.sql
      [14] insert_data/payment_insert_data.sql
      [15] insert_data/reservation_payment_insert_data.sql
      [17] insert_data/baggage_insert_data.sql
      [18] insert_data/refund_insert_data.sql
   ```

### Grant access to Procedures

   > **Using account**: `DEVELOPER`
   ```sh
      setup/grant access/[ ] grant_procedure_access_to_user.sql
   ```

### Run Triggers - After Update

1. Run Trigger using developer
   > **Using account**: `DEVELOPER`

  ```sh
    trigger setup/[5] before_after_update_inventory_and_order.sql
  ```



### Create View

1. Create views: quarterly most travelled route
   > **Using account**: `FLIGHT_OPERATION_MANAGER`
   ```sh
      views setup/[1] quarterly_most_travelled_route.sql
   ```

2. Create views: most wallet points redeemed
   > **Using account**: `DEVELOPER`
   ```sh
      views setup/[2] most_wallet_points_redeemed.sql
   ```

3. Create views: incoming cashflow.sql
   > **Using account**: `DEVELOPER`
   ```sh
      views setup/[3] incoming_cashflow.sql
   ```

4. Create views: scheduled maintenance record
   > **Using account**: `MAINTENANCE MANAGER`
   ```sh
      views setup/[4] scheduled_maintenance_record.sql
   ```
5. Create views: flight and crew schedule
   > **Using account**: `FLIGHT OPERATIONS MANAGER`
   ```sh
      views setup/[5] flight_and_crew_schedule.sql
   ```
6. Create views: revenue by route
   > **Using account**: `FLIGHT OPERATIONS MANAGER`
   ```sh
      views setup/[6] revenue_by_route.sql
   ```
7. Create views: current inventory status
   > **Using account**: `FLIGHT OPERATIONS MANAGER`
   ```sh
      views setup/[7] current_inventory_status.sql
   ```

### Flows

[Flows](/flows.md)
