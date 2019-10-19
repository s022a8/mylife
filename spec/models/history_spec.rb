require 'rails_helper'

RSpec.describe History, type: :model do
	describe 'バリデーション' do
		# 変数の定義
		let(:history_params) { { age: '22', barometer: '50' } }

		context 'エラーが出る' do
			it '出来事が未入力' do
				expect(History.new(history_params.merge(event: '')).valid?).to be false
			end

			it '出来事が51文字以上' do
				expect(History.new(history_params.merge(event: 'a'*51)).valid?).to be false
			end
		end
	end
end
