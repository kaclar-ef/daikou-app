class DrivingRequestsController < ApplicationController
  def new
    @driving_request = DrivingRequest.new
  end

  def create
    @driving_request = DrivingRequest.new(driving_request_params)
    render 'new' and return unless @driving_request.valid?
    @driving_request.save    
  end

  private
  def driving_request_params
    params.require(:driving_request).permit(:reservation_datetime, :departure_place, :destination, :car_model)
      .merge(status: '代行依頼中', receipt_id: SecureRandom.alphanumeric(6), user_id: current_user.id)
  end
end
