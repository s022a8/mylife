require 'rails_helper'

describe 'ユーザー機能', type: :system do
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
    end

    describe '会員でないユーザー' do
        let (:user) { User.find(1) }
        let (:history) { user.histories.first }

        it 'ルートページにアクセスできる' do
            visit root_path
            expect(page).not_to have_content('アカウント登録もしくはログインしてください。')
        end

        it '各ユーザーの歴史一覧ページにを見ることができる' do
            visit user_histories_path(user.id)
            expect(page).not_to have_content('アカウント登録もしくはログインしてください。')
        end

        it '各ユーザーの歴史詳細ページにを見ることができる' do
            visit user_history_path(user.id, history.id)
            expect(page).not_to have_content('アカウント登録もしくはログインしてください。')
        end

        it 'アンケート一覧ページににアクセスできる' do
            visit questionnaires_path
            expect(page).not_to have_content('アカウント登録もしくはログインしてください。')
        end
    end

    describe '会員登録' do
        before do
            visit new_user_registration_path
        end

        it '正常な会員登録' do
            fill_in 'アカウント名', with: 'テスト太郎'
            fill_in 'メールアドレス', with: 'testtest@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in '確認用パスワード', with: 'password'
            (find_by_id('user_registration_button')).click
            expect(page).to have_content('アカウント登録が完了しました。')
        end

        it 'アカウント名は15文字以内になる' do
            fill_in 'アカウント名', with: 'a' * 16
            fill_in 'メールアドレス', with: 'testtest@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in '確認用パスワード', with: 'password'
            (find_by_id('user_registration_button')).click
            expect(page).to have_content('アカウント名は15文字以下に設定して下さい。')
        end

        it 'アカウント名はサイト内で一意になる' do
            fill_in 'アカウント名', with: 'テストユーザー'
            fill_in 'メールアドレス', with: 'testtest@example.com'
            fill_in 'パスワード', with: 'password'
            fill_in '確認用パスワード', with: 'password'
            (find_by_id('user_registration_button')).click
            expect(page).to have_content('アカウント名は既に使用されています。')
        end

        it '短いパスワード' do
            fill_in 'アカウント名', with: 'テストユーザー'
            fill_in 'メールアドレス', with: 'testtest@example.com'
            fill_in 'パスワード', with: 'pass'
            fill_in '確認用パスワード', with: 'pass'
            (find_by_id('user_registration_button')).click
            expect(page).to have_content('パスワードは6文字以上に設定して下さい。')
        end
    end

    describe '会員のユーザー' do
        context 'ログイン画面' do
            it '正常なログイン' do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'test@example.com'
                fill_in 'パスワード', with: 'password'
                find('.devise-button').click
                expect(page).to have_content 'ログインしました'
            end

            it '不正なログイン' do
                visit new_user_session_path
                fill_in 'メールアドレス', with: ''
                fill_in 'パスワード', with: ''
                find('.devise-button').click
                expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
            end
        end



        context 'ログイン後' do
            before do
                visit new_user_session_path
                fill_in 'メールアドレス', with: 'test@example.com'
                fill_in 'パスワード', with: 'password'
                find('.devise-button').click
                expect(page).to have_content 'ログインしました'
            end

            it 'プロフィールページへのアクセス' do
                visit users_path 
                expect(page).not_to have_content('アカウント登録もしくはログインしてください。')
            end

            it 'ユーザー編集ページへのアクセス' do
                visit edit_user_registration_path
                expect(page).not_to have_content('アカウント登録もしくはログインしてください。')
            end

            it 'ログアウトする' do
                click_link 'ログアウト'
                expect(page).to have_content('ログアウトしました。')
            end

            it '退会する' do
                visit warning_users_path
                click_link '退会する'
                page.driver.browser.switch_to.alert.accept
                expect(page).to have_content('正常に退会が行われました。')
            end
        end
    end
end