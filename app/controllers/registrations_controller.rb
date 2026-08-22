class RegistrationsController < ApplicationController
  def new
    @form = RegistrationForm.new
  end

  def create
    @form = RegistrationForm.from params.require(:registration)

    if @form.save
      redirect_to :root, notice: "Registration completed."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
