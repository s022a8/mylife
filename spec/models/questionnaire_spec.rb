require 'rails_helper'

RSpec.describe Questionnaire, type: :model do
  describe 'バリデーション' do
    context '入力された値' do
      let(:test_user) { create(:user, name: 'tester', email: 'tester@example.com') }

      let(:blank_theme_question) { build(:questionnaire, theme: nil, user: test_user) }
      let(:over_theme_question) { build(:questionnaire, theme: 'a'*133, user: test_user) }
      let(:blank_category_question) { build(:questionnaire, category: '', user: test_user) }
      let(:over_category_question) { build(:questionnaire, category: 'a'*39, user: test_user) }

      it 'テーマが未入力' do
        # 2.times do
        #   create(:questionnaire_item, questionnaire: blank_theme_question)
        # end
        blank_theme_question.valid?
				expect(blank_theme_question.errors.full_messages).to include('テーマが入力されていません。')
			end

      it 'テーマが133文字以上' do
        # 2.times do
        #   create(:questionnaire_item, questionnaire: over_theme_question)
        # end
        over_theme_question.valid?
				expect(over_theme_question.errors.full_messages).to include('テーマは132文字以下に設定して下さい。')
			end
    
      it 'カテゴリーは未入力でもOK' do
        # 2.times do
        #   create(:questionnaire_item, questionnaire: blank_category_question)
        # end
        blank_category_question.valid?
				expect(blank_category_question.errors.full_messages).not_to include('カテゴリーが入力されていません。')
			end

      it 'カテゴリーが39文字以上' do
        # 2.times do
        #   create(:questionnaire_item, questionnaire: over_category_question)
        # end
        over_category_question.valid?
				expect(over_category_question.errors.full_messages).to include('カテゴリーは38文字以下に設定して下さい。')
			end
    end
	end
end
