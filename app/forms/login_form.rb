class LoginForm < ApplicationForm
  attribute :email
  attribute :password

  def authenticate
    User.authenticate_by(email:, password:)
  end
end
