require 'rails_helper'

describe '歴史機能', type: :system do
    describe '一覧表示機能' do
        before do
            user_a = create(:user)
            10.times do
                create(:history, user: user_a)
            end
        end

        context 'テストユーザーでログインしているとき' do
            # テストユーザーを定義
            let(:user) { User.find(1) }

            # ログイン
            before do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'test@example.com'
                fill_in 'パスワード', with: 'password'
                find('.devise-button').click
                expect(page).to have_content 'ログインしました'
                visit user_histories_path(user.id)
                find_by_id('a_content_tab').click
            end

            it 'ユーザーのID確認' do
                expect(user.id).to eq(1)    # テスト通る
            end

            it 'テストユーザーが作成した歴史が表示される' do
                expect(all(:css, '.user-history-row').size).to eq(10)
            end
        end
    end
end