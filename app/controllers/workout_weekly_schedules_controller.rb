class WorkoutWeeklySchedulesController < AuthenticateController
  before_action :authorize_manege! [:new, :create, :edit, :destroy]
  before_action :set_schedule [:show, :edit, :update, :destroy]
end
