class UsersController < ApplicationController
  def show
    puts "aaaaaa"
    @user = User.find(params[:id])
    @driving_requests = @user.driving_requests.page(params[:page]).per(10).order(reservation_datetime: 'DESC')
  end
end
