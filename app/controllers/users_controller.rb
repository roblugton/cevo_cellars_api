class UsersController < ApplicationController

  def create
    if user_exists
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_exists?
    User.exists?(:email => user_params['email'])
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
