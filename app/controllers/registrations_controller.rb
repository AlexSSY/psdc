class RegistrationsController < ApplicationController
  def new
    @form = UserRegistrationForm.new
  end

  def create
    redirect_to :root, success: "Registration completed"
  end
end
