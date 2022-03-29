require 'rails_helper'

RSpec.describe DrivingRequest, type: :model do
  before do
    @driving_request = FactoryBot.build(:driving_request)
  end

  describe 'バリデーション' do
    describe 'reservation_datetime' do
      context '正常系' do
        it '未来の日時であれば登録できる' do
          @driving_request.reservation_datetime = Time.current + 1.hours
          expect(@driving_request).to be_valid
        end
      end
      context '異常系' do
        it '空では登録できない' do
          @driving_request.reservation_datetime = nil
          expect(@driving_request).not_to be_valid
        end
        it '過去の日時では登録できない' do
          @driving_request.reservation_datetime = Time.current - 1.hours
          expect(@driving_request).not_to be_valid
        end
      end
      describe 'departure_place' do
        context '正常系' do
          it '空でなければ登録できる' do
            @driving_request.departure_place = '香川県高松市'
            expect(@driving_request).to be_valid
          end
        end
        context '異常系' do
          it '空では登録できない' do
            @driving_request.departure_place = ''
            expect(@driving_request).not_to be_valid
          end
          it '256文字以上では登録できない' do
            @driving_request.departure_place = 'あ' * 256
            expect(@driving_request).not_to be_valid
          end
        end
      end
      describe 'destination' do
        context '正常系' do
          it '空でなければ登録できる' do
            @driving_request.destination = '香川県高松市'
            expect(@driving_request).to be_valid
          end
        end
        context '異常系' do
          it '空では登録できない' do
            @driving_request.destination = ''
            expect(@driving_request).not_to be_valid
          end
          it '256文字以上では登録できない' do
            @driving_request.destination = 'あ' * 256
            expect(@driving_request).not_to be_valid
          end
        end
      end
      describe 'car_model' do
        context '正常系' do
          it '値が普通(AT)であれば登録できる' do
            @driving_request.car_model = '普通(AT)'
            expect(@driving_request).to be_valid
          end
          it '値が普通(MT)であれば登録できる' do
            @driving_request.car_model = '普通(MT)'
            expect(@driving_request).to be_valid
          end
          it '値が中型であれば登録できる' do
            @driving_request.car_model = '中型'
            expect(@driving_request).to be_valid
          end
          it '値が大型であれば登録できる' do
            @driving_request.car_model = '大型'
            expect(@driving_request).to be_valid
          end
        end
        context '異常系' do
          it '空では登録できない' do
            @driving_request.car_model = nil
            expect(@driving_request).not_to be_valid
          end
          it '「普通(AT),普通(MT),中型,大型」以外の値では登録できない' do
            @driving_request.car_model = 'スポーツカー'
            expect(@driving_request).not_to be_valid
          end
        end
      end
      describe 'status' do
        context '正常系' do
          it '値が代行依頼中であれば登録できる' do
            @driving_request.status = '代行依頼中'
            expect(@driving_request).to be_valid
          end
          it '値が代行受領済であれば登録できる' do
            @driving_request.status = '代行受領済'
            expect(@driving_request).to be_valid
          end
          it '値が依頼完了済であれば登録できる' do
            @driving_request.status = '依頼完了済'
            expect(@driving_request).to be_valid
          end
        end
        context '異常系' do
          it '空では登録できない' do
            @driving_request.status = nil
            expect(@driving_request).not_to be_valid
          end
          it '「代行依頼中、代行受領済、依頼完了済」以外の値では登録できない' do
            @driving_request.status = '期限切れ'
            expect(@driving_request).not_to be_valid
          end
        end
      end
      describe 'receipt_id' do
        context '正常系' do
          it '英数字6文字であれば登録できる' do
            @driving_request.receipt_id = 'AabB12'
            expect(@driving_request).to be_valid
          end
          it '英字(小文字)のみでも登録できる' do
            @driving_request.receipt_id = 'abcdef'
            expect(@driving_request).to be_valid
          end
          it '英字(大文字)のみでも登録できる' do
            @driving_request.receipt_id = 'ABCDEF'
            expect(@driving_request).to be_valid
          end
          it '数字のみでも登録できる' do
            @driving_request.receipt_id = '123456'
            expect(@driving_request).to be_valid
          end
        end
        context '異常系' do
          it '空では登録できない' do
            @driving_request.receipt_id = ''
            expect(@driving_request).not_to be_valid
          end
          it '5文字以下だと登録できない' do
            @driving_request.receipt_id = 'aBc12'
            expect(@driving_request).not_to be_valid
          end
          it '7文字以上だと登録できない' do
            @driving_request.receipt_id = 'aBc1234'
            expect(@driving_request).not_to be_valid
          end
          it '全角数字では登録できない' do
            @driving_request.receipt_id = 'aBc１２３４'
            expect(@driving_request).not_to be_valid
          end
          it '英数字以外が含まれていると登録できない' do
            @driving_request.receipt_id = 'aBc123!'
            expect(@driving_request).not_to be_valid
          end
        end
      end
      describe 'user' do
        context '正常系' do
          it 'userが紐づいていれば登録できる' do
            user = FactoryBot.create(:user)
            @driving_request.user_id = user.id
            expect(@driving_request).to be_valid
          end
        end
        context '異常系' do
          it 'userが紐づいていなければ登録できない' do
            @driving_request.user = nil
            expect(@driving_request).not_to be_valid
          end
          it '紐づいているuserがデータベースに存在しない場合は登録できない' do
            user = FactoryBot.create(:user)
            @driving_request.user_id = user.id
            user.destroy
            expect(@driving_request).not_to be_valid
          end
        end
      end
    end
  end
end
