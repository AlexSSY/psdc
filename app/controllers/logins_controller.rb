class LoginsController < ApplicationController
  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.from params.require(:login)

    if user = @form.authenticate
      login user
      redirect_to :root, notice: "You logged in successfully."
    else
      flash[:alert] = "Fail to log in."
      render :new, status: :unauthorized
    end
  end

  def destroy
    logout
    redirect_to :new_logins, notice: "You successfully logged out."
  end

  private

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end
