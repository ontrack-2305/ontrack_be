class Api::V1::UsersController < ApplicationController

  def authenticate
    user = User.new(params)
    service = GoogleCalendarService.new(user)
    require 'pry'; binding.pry
  end
end