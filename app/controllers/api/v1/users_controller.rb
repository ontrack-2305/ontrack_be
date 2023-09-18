class Api::V1::UsersController < ApplicationController

  def authenticate
    user = User.new(params)
    require 'pry'; binding.pry
  end
end