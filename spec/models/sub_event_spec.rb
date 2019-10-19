require 'rails_helper'

RSpec.describe SubEvent, type: :model do
  describe 'バリデーション' do
		context 'タイトル' do
			it 'タイトルが未入力' do
				expect(SubEvent.new(
          part: '',
          detail: 'aaaaaa'
        ).valid?).to be false
			end

			it 'タイトルが16文字以上' do
				expect(SubEvent.new(
          part: 'a'*16,
          detail: 'aaaaaa'
        ).valid?).to be false
			end
    end
    
    context '内容' do
      it '内容が未入力' do
				expect(SubEvent.new(
          part: 'aaaaa',
          detail: ''
        ).valid?).to be false
			end

			it '内容が51文字以上' do
				expect(SubEvent.new(
          part: 'aaaaa',
          detail: 'a'*51
        ).valid?).to be false
			end
    end
	end
end
