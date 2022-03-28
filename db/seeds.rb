# coding: utf-8

user = User.create(email: 'sample@example.com', password: 'pass1234', first_name: '太郎', last_name: '田中', first_name_kana: 'タロウ', last_name_kana: 'タナカ', phone_number: '09000000000')
50.times do |num|
  DrivingRequest.new(reservation_datetime: Time.current - 1.days, departure_place: '高松市番町四丁目1番10号', destination: '大阪市中央区大手前2丁目', car_model: '普通(AT)', status: '依頼完了済', receipt_id: SecureRandom.alphanumeric(6), user_id: 1).save(validate: false)
end
DrivingRequest.create(reservation_datetime: Time.current + 2.days, departure_place: '高松市番町四丁目1番10号', destination: '大阪市中央区大手前2丁目', car_model: '普通(AT)', status: '代行受領済', receipt_id: SecureRandom.alphanumeric(6), user_id: 1)
DrivingRequest.create(reservation_datetime: Time.current + 2.days, departure_place: '高松市番町四丁目1番10号', destination: '大阪市中央区大手前2丁目', car_model: '普通(AT)', status: '代行依頼中', receipt_id: SecureRandom.alphanumeric(6), user_id: 1)