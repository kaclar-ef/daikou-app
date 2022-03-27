require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do
    describe 'email' do
      context '正常系' do
        it '正しい形式であれば登録できる' do
          @user.email = 'hoge@example.com'
          expect(@user).to be_valid
        end
      end
      context '異常系' do
        it '空では登録できない' do
          @user.email = ''
          expect(@user).not_to be_valid
        end
        it "256文字以上では登録できない" do
          @user.first_name = 'hoge@example.com' + 'a' * 240
          expect(@user).not_to be_valid  
        end
        it '正しいアドレス形式でない場合は登録できない' do
          @user.email = 'hogefuga'
          expect(@user).not_to be_valid
        end
        it '重複するメールアドレスは登録できない' do
          saved_user = FactoryBot.create(:user)
          @user.email = saved_user.email
          expect(@user).not_to be_valid
        end
      end
    end
    describe 'password' do
      context '正常系' do
        it '英数字混合6文字以上であれば登録できる' do
          @user.password = 'hoge12'
          expect(@user).to be_valid
        end
        it '英数字に加えて記号が含まれていても登録できる' do
          @user.password = 'hoge1!'
          expect(@user).to be_valid
        end
      end
      context '異常系' do
        it '空では登録できない' do
          @user.password = ''
          expect(@user).not_to be_valid
        end
        it '5文字以下では登録できない' do
          @user.password = 'hoge1'
          expect(@user).not_to be_valid
        end
        it '256文字以上では登録できない' do
          @user.password = 'a' * 255 + '1'
          expect(@user).not_to be_valid
        end
        it '英字が含まれていない場合は登録できない' do
          @user.password = '123!!!'
          expect(@user).not_to be_valid
        end
        it '数字が含まれていない場合は登録できない' do
          @user.password = 'abc!!!'
          expect(@user).not_to be_valid
        end
      end
    end
    describe 'first_name' do
      context '正常系' do
        it "漢字で登録ができる" do
          @user.first_name = '太郎'
          expect(@user).to be_valid  
        end
        it "平仮名で登録ができる" do
          @user.first_name = 'たろう'
          expect(@user).to be_valid  
        end
        it "片仮名で登録ができる" do
          @user.first_name = 'タロウ'
          expect(@user).to be_valid  
        end
      end
      context '異常系' do
        it "空では登録できない" do
          @user.first_name = ''
          expect(@user).not_to be_valid  
        end
        it "256文字以上では登録できない" do
          @user.first_name = 'あ' * 256
          expect(@user).not_to be_valid  
        end
        it "漢字・平仮名・片仮名以外の文字が含まれると登録できない" do
          @user.first_name = 'taro'
          expect(@user).not_to be_valid  
        end
      end
    end
    describe 'last_name' do
      context '正常系' do
        it "漢字で登録ができる" do
          @user.last_name = '田中'
          expect(@user).to be_valid  
        end
        it "平仮名で登録ができる" do
          @user.last_name = 'たなか'
          expect(@user).to be_valid  
        end
        it "片仮名で登録ができる" do
          @user.last_name = 'タナカ'
          expect(@user).to be_valid  
        end
      end
      context '異常系' do
        it "空では登録できない" do
          @user.last_name = ''
          expect(@user).not_to be_valid  
        end
        it "256文字以上では登録できない" do
          @user.last_name = 'あ' * 256
          expect(@user).not_to be_valid  
        end
        it "漢字・平仮名・片仮名以外の文字が含まれると登録できない" do
          @user.last_name = 'tanaka'
          expect(@user).not_to be_valid  
        end
      end
    end
    describe 'first_name_kana' do
      context '正常系' do
        it "片仮名で登録できる" do
          @user.first_name_kana = 'タロウ'
          expect(@user).to be_valid  
        end
      end
      context '異常系' do
        it "空では登録できない" do
          @user.first_name_kana = ''
          expect(@user).not_to be_valid  
        end
        it "256文字以上では登録できない" do
          @user.first_name_kana = 'ア' * 256
          expect(@user).not_to be_valid  
        end
        it "片仮名以外では登録できない" do
          @user.first_name_kana = 'たろう'
          expect(@user).not_to be_valid  
          @user.first_name_kana = '太郎'
          expect(@user).not_to be_valid  
          @user.first_name_kana = 'taro'
          expect(@user).not_to be_valid  
        end
      end
    end
    describe 'last_name_kana' do
      context '正常系' do
        it "片仮名で登録できる" do
          @user.last_name_kana = 'タナカ'
          expect(@user).to be_valid  
        end
      end
      context '異常系' do
        it "空では登録できない" do
          @user.last_name_kana = ''
          expect(@user).not_to be_valid  
        end
        it "256文字以上では登録できない" do
          @user.last_name_kana = 'ア' * 256
          expect(@user).not_to be_valid  
        end
        it "片仮名以外では登録できない" do
          @user.last_name_kana = 'たなか'
          expect(@user).not_to be_valid  
          @user.last_name_kana = '田中'
          expect(@user).not_to be_valid  
          @user.first_name_kana = 'tanaka'
          expect(@user).not_to be_valid  
        end
      end
    end
    describe 'phone_number' do
      context '正常系' do
        it "ハイフンなしの10桁であれば登録できる" do
          @user.phone_number = '0901234567'
          expect(@user).to be_valid
        end
        it "ハイフンなしの11桁であれば登録できる" do
          @user.phone_number = '09012345678'
          expect(@user).to be_valid
        end
      end
      context '異常系' do
        it "空では登録できない" do
          @user.phone_number = ''
          expect(@user).not_to be_valid
        end
        it "数字以外を含むと登録できない" do
          @user.phone_number = '090-1234-5678'
          expect(@user).not_to be_valid
        end
        it "9桁以下では登録できない" do
          @user.phone_number = '090123456'
          expect(@user).not_to be_valid
        end
        it "12桁以上では登録できない" do
          @user.phone_number = '090123456789'
          expect(@user).not_to be_valid
        end
      end
    end
  end
end