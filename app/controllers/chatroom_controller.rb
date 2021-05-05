class ChatroomController < ApplicationController

  def index
    @users = User.all
  end
end