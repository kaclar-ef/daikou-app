FactoryBot.define do
  factory :driving_request do
    reservation_datetime { '2199-01-01' }
    departure_place      { '丸亀' }
    destination          { '高松' }
    car_model            { '普通(MT)' }
    status               { '代行依頼中' }
    receipt_id           { 'AbC123' }
    user
  end
end
