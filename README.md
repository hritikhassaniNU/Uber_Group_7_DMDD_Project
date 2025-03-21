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
- [ ] Create procedure (register user, book ride, cancel ride, assign driver, etc)
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


2.### Create all other users (RIDER, DRIVER, OPERATOR, ANALYST)

> **Using account**: `APP ADMIN`

```sh
env setup/create users/[2] create_all_users.sql
```

---

### Create Stored Procedures [APP ADMIN]

1. Create Store Procedure for `APP ADMIN`

> **Using account**: `APP ADMIN`

```sh
stored procedures/[3] grant_access_to_user.sql
```

---

### Grant Access to Developer

1. Granting access to developer

> **Using account**: `APP ADMIN`

```sh
env setup/grant access/[4] grant_access_developer.sql
```

---

### Create Stored Procedures [DEVELOPER]

1. Create Store Procedure for `DEVELOPER`

> **Using account**: `DEVELOPER`

```sh
stored procedures/[3] grant_access_to_user.sql
```

---

### Create tables

1. Create tables using developer

> **Using account**: `DEVELOPER`

```sh
table setup/[5] Uber_Independent_Tables.sql
table setup/[6] Uber_Dependent_Tables.sql
```

---

### Run Triggers

1. Run Trigger using developer

> **Using account**: `DEVELOPER`

```sh
trigger setup/[1] check_driver_status_update.sql
trigger setup/[2] check_ride_request_insert.sql
trigger setup/[3] check_ride_completion_update.sql
trigger setup/[4] check_wallet_balance.sql
```

---

### Grant Access to tables for different users

1. Grant access to tables to different users

> **Using account**: `DEVELOPER`

```sh
env setup/grant access/[7] grant_access_to_all_users.sql
```

---

### Insert Data into table

1. Insert data

> **Using account**: `DEVELOPER`

```sh
[1] insert_data/users_insert_data.sql
[2] insert_data/drivers_insert_data.sql
[3] insert_data/vehicles_insert_data.sql
[4] insert_data/wallet_insert_data.sql
[5] insert_data/ride_request_insert_data.sql
[6] insert_data/ride_assignments_insert_data.sql
[7] insert_data/ride_completion_insert_data.sql
[8] insert_data/payments_insert_data.sql
[9] insert_data/refunds_insert_data.sql
[10] insert_data/ratings_insert_data.sql
```

---

### Grant access to Procedures

> **Using account**: `DEVELOPER`

```sh
setup/grant access/[ ] grant_procedure_access_to_user.sql
```

---

### Run Triggers - After Update

1. Run Trigger using developer

> **Using account**: `DEVELOPER`

```sh
trigger setup/[5] before_after_update_ride_and_payment.sql
```

---

### Create View

1. Create views: most frequent riders  
> **Using account**: `ANALYST`

```sh
views setup/[1] most_frequent_riders.sql
```

2. Create views: top-rated drivers  
> **Using account**: `ANALYST`

```sh
views setup/[2] top_rated_drivers.sql
```

3. Create views: ride activity report  
> **Using account**: `OPERATOR`

```sh
views setup/[3] ride_activity_report.sql
```

4. Create views: current driver availability  
> **Using account**: `OPERATOR`

```sh
views setup/[4] current_driver_availability.sql
```

5. Create views: revenue by region  
> **Using account**: `ANALYST`

```sh
views setup/[5] revenue_by_region.sql
```

6. Create views: wallet usage summary  
> **Using account**: `ANALYST`

```sh
views setup/[6] wallet_usage_summary.sql
```

7. Create views: canceled ride trends  
> **Using account**: `OPERATOR`

```sh
views setup/[7] canceled_ride_trends.sql
```

---

### Flows

[Flows](/flows_uber.md)

