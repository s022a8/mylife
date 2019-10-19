require 'rails_helper'

RSpec.describe User, type: :model do
	describe 'ブックマーク関連機能' do
		before do
			user_a = create(:user)
			10.times do
				create(:history, user: user_a)
			end
			user_a.histories.each do |history|
				3.times do
					create(:sub_event, history: history)
				end
			end

			user_b = create(:user, name: 'テストユーザーB', email: 'test2@example.com')
			5.times do
				create(:history, user: user_b)
			end
			user_b.histories.each do |history|
				2.times do
					create(:sub_event, history: history)
				end
			end
		end

		# 変数の定義
		let (:user) { User.first }
		let (:other_user) { User.second }
		let (:history) { user.histories.first }
		let (:other_history) { other_user.histories.first }


		context '#book_mark' do
			it '自分の歴史にいいねする' do
				user.book_mark(history)
				expect(BookMark.all.size).to eq(1)
			end

			it '相手の歴史をブックマークする' do
				user.book_mark(other_history)
				expect(BookMark.all.size).to eq(1)
			end
		end


		context '#un_book_mark' do
			it '相手の歴史をブックマークして外す' do
				user.book_mark(other_history)
				user.un_book_mark(other_history)
				expect(BookMark.all.size).to eq(0)
			end
		end


		context '#book_mark?' do
			it 'ブックマークされているか確認する' do
				user.book_mark(other_history)
				expect(user).to be_book_mark(other_history)
			end
		end
	end


	describe 'OmniAuth認証関連機能' do
		context 'uidとproviderが見つからなければ新規のUserを返す' do
			# 変数の定義
			let(:double_auth) { { uid: '1111', provider: 'facebook', name: 'omniauth'*2, email: 'omni@example.com'} }

			it 'Facebookのアカウント名が15文字以上でも正常に登録されるか' do
				allow(User).to receive(:find_for_oauth) do |d_auth|
					User.new(
						uid: d_auth[:uid],
						provider: d_auth[:provider],
						name: d_auth[:name].slice(0, 15),
						email: d_auth[:email],
						password: 'password'
					)
				end

				expect(User.find_for_oauth(double_auth).valid?).to be true
			end
		end
	end
end
