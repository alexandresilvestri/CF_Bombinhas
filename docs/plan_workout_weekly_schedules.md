# Plan: workout_weekly_schedules model and automatic workout_classes generation

## Overview

Two-phase implementation. Phase 1 creates the `workout_weekly_schedules` table that stores the gym's recurring weekly schedule. Phase 2 creates `workout_classes` and the automation layer that generates class instances from those schedule records.

---

## Phase 1 — workout_weekly_schedules model

### Migration

Create a new migration using Rails generator:

```bash
rails generate migration CreateWorkoutWeeklySchedules
```

**Columns:**

| Column        | Type    | Notes                                          |
|---------------|---------|------------------------------------------------|
| id            | uuid    | Primary key, default: gen_random_uuid()        |
| day_of_week   | integer | Backed by ActiveRecord enum (0 = sunday … 6 = saturday, matching Ruby's Date::DAYNAMES) |
| start_time    | time    | Time of day the class starts                   |
| max_capacity  | integer | not null, check constraint > 0                 |
| created_at    | datetime| Managed by Rails timestamps                    |
| updated_at    | datetime| Managed by Rails timestamps                    |

> **Why integer enum instead of PostgreSQL native enum?**
> ActiveRecord integer enums are simpler to migrate (add/remove values without DDL changes) and still produce readable Ruby code. Switch to a PostgreSQL CHECK constraint or native enum only if raw SQL queries on this column become frequent.

**Migration body:**

```ruby
create_table :workout_weekly_schedules, id: :uuid do |t|
  t.integer  :day_of_week,  null: false
  t.time     :start_time,   null: false
  t.integer  :max_capacity, null: false

  t.timestamps
end

add_index :workout_weekly_schedules, [:day_of_week, :start_time], unique: true
add_check_constraint :workout_weekly_schedules, "max_capacity > 0", name: "workout_weekly_schedules_max_capacity_positive"
```

The unique index on `(day_of_week, start_time)` prevents duplicate schedule slots.

### Model

File: `app/models/workout_weekly_schedule.rb`

```ruby
class WorkoutWeeklySchedule < ApplicationRecord
  enum :day_of_week, {
    sunday:    0,
    monday:    1,
    tuesday:   2,
    wednesday: 3,
    thursday:  4,
    friday:    5,
    saturday:  6
  }

  validates :day_of_week,  presence: true
  validates :start_time,   presence: true
  validates :max_capacity, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :start_time,   uniqueness: { scope: :day_of_week, message: "already has a class at this time" }
end
```

---

## Phase 2 — workout_classes table and automatic generation

### Design decision

`workout_classes` represents a concrete class occurrence on a specific calendar date. It is derived from a `workout_weekly_schedule` record but becomes an independent record once generated, so coaches can edit capacity, cancel a single occurrence, or record attendance without touching the template.

**Columns for workout_classes (preliminary — full migration planned separately):**

| Column                       | Type     | Notes                                         |
|------------------------------|----------|-----------------------------------------------|
| id                           | uuid     | Primary key                                   |
| workout_weekly_schedule_id   | uuid     | FK → workout_weekly_schedules, nullable (kept even if schedule deleted) |
| scheduled_date               | date     | The concrete calendar date of the class       |
| start_time                   | time     | Copied from schedule at generation time       |
| max_capacity                 | integer  | Copied from schedule, editable per occurrence |
| status                       | integer  | enum: scheduled / cancelled / completed       |
| timestamps                   |          |                                               |

Unique index on `(scheduled_date, start_time)` prevents duplicate class slots on the same day.

### Generation strategy

Use a **recurring background job** (Solid Queue, already configured) that runs at the start of each week (e.g., every Sunday at midnight) and projects classes for the upcoming week.

**Job:** `app/jobs/generate_workout_classes_job.rb`

Logic:
1. Determine the target week (next 7 days starting from the next Monday, or a supplied date range).
2. For each `WorkoutWeeklySchedule` record, calculate the concrete date in that week matching `day_of_week`.
3. Use `find_or_create_by(scheduled_date:, start_time:)` to avoid duplicates on re-runs.
4. Copy `max_capacity` and `workout_weekly_schedule_id` at creation time.

This job can also be triggered manually from the admin interface to back-fill or regenerate classes after schedule changes.

**Scheduling the job** (Solid Queue recurring tasks in `config/recurring.yml`):

```yaml
generate_workout_classes:
  class: GenerateWorkoutClassesJob
  schedule: "0 0 * * 0"   # Every Sunday at midnight
```

### Service (optional refactor)

If the generation logic grows, extract it to `app/service/workout_class_generator_service.rb` following the existing service naming convention in the project.

---

## Implementation checklist

### Phase 1
- [ ] Generate and write migration for `workout_weekly_schedules`
- [ ] Run `rails db:migrate`
- [ ] Create `WorkoutWeeklySchedule` model with enum, validations, and unique index
- [ ] Write RSpec model specs (validations, enum values, uniqueness)
- [ ] Add seed data (example weekly schedule for testing)

### Phase 2
- [ ] Generate and write migration for `workout_classes`
- [ ] Create `WorkoutClass` model with enum, validations, and association to `WorkoutWeeklySchedule`
- [ ] Create `GenerateWorkoutClassesJob`
- [ ] Register job in `config/recurring.yml`
- [ ] Write RSpec specs for the job (generates correct dates, idempotent on re-run, handles edge cases like DST)
- [ ] Manual trigger endpoint or admin action for back-filling
