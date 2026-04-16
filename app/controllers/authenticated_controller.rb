class AuthenticatedController < ApplicationController
  before_action :auto_sign_in_dev_user, if: -> { Rails.env.development? }
  before_action :authenticate_user!

  private

  def auto_sign_in_dev_user
    return if user_signed_in?

    dev_user = User.find_by(email: "admin@cf.com")
    sign_in(dev_user) if dev_user
  end
end
