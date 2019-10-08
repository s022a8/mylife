class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
  end

  def warning
  end
end
