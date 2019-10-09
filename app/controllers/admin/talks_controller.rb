class Admin::TalksController < ApplicationController
  before_action :authenticate_admin!

  def index
  end
end
