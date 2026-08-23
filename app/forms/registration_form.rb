class RegistrationForm < ApplicationForm
  attribute :email, :string
  attribute :password, :string
  attribute :password_confirmation, :string

  validate :user_is_valid

  attr_reader :user

  def initialize(...)
    super
    @user = User.new(email:, password:, password_confirmation:)
  end

  def user_is_valid
    return if user.valid?
    merge_errors!(user)
  end

  def submit!
    user.save!
  end
end
