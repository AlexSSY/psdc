class RegistrationForm < ApplicationForm
  attribute :email
  attribute :password
  attribute :password_confirmation

  validate :user_is_valid

  attr_reader :user

  def initialize(...)
    super(...)
    debugger
    @user = User.new(email:, password:, password_confirmation:)
  end

  def user_is_valid
    return if user.valid?
    merge_errors!(user)
  end

  def submit!
    # user.assign(
    #   email: email,
    #   password: password,
    #   password_confirmation: password_confirmation
    # )

    user.save!
  end
end
