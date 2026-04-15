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

## Phase 1.5 — Controller, Routes & Views for workout_weekly_schedules

Phase 1 (model + migration) is done. This phase wires up the controller, routes, and views so admins/coaches can manage schedules and regular users can view the weekly timetable.

### Routes

**Modify:** `config/routes.rb`

Add `resources :workout_weekly_schedules` inside the existing draw block, before the root route.

### Controller

**Modify:** `app/controllers/workout_weekly_schedules_controller.rb` (file exists but is empty)

- Inherit from `AuthenticatedController`
- `before_action :authorize_manage!` on `[:new, :create, :edit, :update, :destroy]`
- `before_action :set_schedule` on `[:show, :edit, :update, :destroy]`
- **index**: loads schedules grouped by day -- `WorkoutWeeklySchedule.order(:day_of_week, :start_time).group_by(&:day_of_week)`
- **show/new/edit**: standard
- **create/update**: redirect to index on success, re-render form with `status: :unprocessable_entity` on failure (Turbo convention)
- **destroy**: redirect to index
- Private `authorize_manage!` checks `current_user.is_admin? || current_user.is_coach?`, redirects with alert on failure
- `helper_method :can_manage?` exposed to views for conditional UI
- Strong params: `permit(:day_of_week, :start_time, :max_capacity)`

### Views

**Create directory:** `app/views/workout_weekly_schedules/`

**`index.html.erb` -- Weekly Grid Timetable**
- 7-column CSS grid (one per day of week) on desktop, stacked on mobile
- Iterates `WorkoutWeeklySchedule.day_of_weeks.keys` so all 7 days always render (even if empty)
- Each day column has a dark header with the day name and schedule cards below
- "New Schedule" button visible only to admin/coach (`can_manage?`)

**`_schedule_card.html.erb` -- Partial for each time slot**
- Shows `start_time` formatted as `%H:%M` and `max_capacity`
- Links to show page
- Edit/Delete controls visible only to admin/coach
- Delete uses `button_to` with `data: { turbo_confirm: "..." }`

**`show.html.erb`**
- Displays day, time, capacity in a card layout
- Edit/Delete buttons for admin/coach
- Back link to index

**`_form.html.erb` -- Shared form partial**
- Error messages block
- `f.select` for day_of_week (from enum keys, capitalized)
- `f.time_field` for start_time (native HTML5 time picker)
- `f.number_field` for max_capacity (min: 1, step: 1)
- Submit button

**`new.html.erb` / `edit.html.erb`**
- Heading + back link + render the `_form` partial

### Layout Fix

**Modify:** `app/views/layouts/application.html.erb`

Change `<main>` class from `flex` to `flex flex-col` -- the current `flex` causes children to lay out in a row, which breaks the grid view.

### Tests

**Model Spec** -- `spec/models/workout_weekly_schedule_spec.rb`
- Validations: presence of all 3 fields, max_capacity > 0 and integer-only, start_time uniqueness scoped to day_of_week
- Enum behavior

**Request Spec** -- `spec/requests/workout_weekly_schedules_spec.rb`
- Unauthenticated: all routes redirect to sign-in
- Regular user: can view index/show, blocked from new/create/edit/update/destroy
- Admin user: full CRUD works, validation errors re-render with 422
- Coach user: manage actions succeed

**System Spec** -- `spec/system/workout_weekly_schedules_spec.rb`
- Admin sees grid, creates/edits/deletes schedules
- Regular user sees grid but no management controls

### File Summary

**Create (9 files):**

| File | Purpose |
|------|---------|
| `app/views/workout_weekly_schedules/index.html.erb` | Weekly grid timetable |
| `app/views/workout_weekly_schedules/show.html.erb` | Schedule detail |
| `app/views/workout_weekly_schedules/new.html.erb` | New schedule page |
| `app/views/workout_weekly_schedules/edit.html.erb` | Edit schedule page |
| `app/views/workout_weekly_schedules/_form.html.erb` | Shared form partial |
| `app/views/workout_weekly_schedules/_schedule_card.html.erb` | Card partial for grid |
| `spec/models/workout_weekly_schedule_spec.rb` | Model spec |
| `spec/requests/workout_weekly_schedules_spec.rb` | Request spec |
| `spec/system/workout_weekly_schedules_spec.rb` | System spec |

**Modify (3 files):**

| File | Change |
|------|--------|
| `config/routes.rb` | Add `resources :workout_weekly_schedules` |
| `app/controllers/workout_weekly_schedules_controller.rb` | Full CRUD + authorization |
| `app/views/layouts/application.html.erb` | `flex` to `flex flex-col` on `<main>` |

### Verification

1. Run `bin/rails routes | grep workout` to confirm routes exist
2. Start dev server (`bin/dev`), sign in as admin, create/edit/delete schedules
3. Sign in as regular user, confirm management controls are hidden and direct URL access is blocked
4. Run `bundle exec rspec` -- all specs should pass
5. Run `bundle exec rubocop` -- no offenses

### Phase 1.5 Checklist

- [ ] Add route `resources :workout_weekly_schedules`
- [ ] Implement controller with all 7 actions + authorization
- [ ] Create index view with weekly grid timetable
- [ ] Create schedule card partial
- [ ] Create show view
- [ ] Create form partial
- [ ] Create new and edit views
- [ ] Fix layout `flex` to `flex flex-col`
- [ ] Write model spec
- [ ] Write request spec
- [ ] Write system spec
- [ ] Run full test suite and rubocop

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
