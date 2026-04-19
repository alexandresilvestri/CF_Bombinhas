class WorkoutWeeklySchedulesController < AuthenticatedController
  before_action :authorize_manage!, only: [ :new, :create, :update, :edit, :destroy ]
  before_action :set_schedule, only: [ :show, :edit, :update, :destroy ]

  helper_method :can_manage?

  def index
    @schedules_by_day = WorkoutWeeklySchedule
      .order(:week_day, :start_time)
      .group_by(&:week_day)
  end

  def show
  end

  def new
    @schedule = WorkoutWeeklySchedule.new
  end

  def edit
  end

  def create
    @schedule = WorkoutWeeklySchedule.new(schedule_params)

      if @schedule.save
        redirect_to workout_weekly_schedules_path, notice: "Schedule created"
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to workout_weekly_schedules_path, notice: "Schedule updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @schedule.destroy
    redirect_to workout_weekly_schedules_path, notice: "Schedule deleted"
  end

  private

  def set_schedule
    @schedule = WorkoutWeeklySchedule.find(params[:id])
  end

  def schedule_params
    params.require(:workout_weekly_schedule)
      .permit(:week_day, :start_time, :max_capacity)
  end

  def authorize_manage!
    return if can_manage?

    redirect_to workout_weekly_schedules_path, alert: "Not authorized"
  end

  def can_manage?
    current_user.is_admin? || current_user.is_coach?
  end
end
