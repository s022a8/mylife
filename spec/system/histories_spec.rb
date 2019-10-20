require 'rails_helper'

describe '歴史機能', type: :system do
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

    describe '一覧表示機能' do
        context 'テストユーザーでログインしているとき' do
            # テストユーザーを定義
            let(:user) { User.find(1) }
            let(:histories) { user.histories }

            let(:user2) { User.find(2) }
            let(:user2_history_event) { user2.histories.first.event }

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
                expect(user.id).to eq(1)
            end

            it '自分が作成した歴史が表示される' do
                expect(all(:css, '.user-history-row').size).to eq(histories.size)
            end

            it '他人の歴史が表示されない' do
                expect(page).not_to have_content(user2_history_event)
            end

            # it '自分の歴史をブックマークする' do
            #     all('img')[0].click
            #     expect(all(:css, '.history-index-td')[0].text[0]).to eq('1')
            # end

            it '歴史の詳細ページへ遷移する' do
                all(:css, '.history-index-td')[4].click
                expect(page).to have_content('タイトル')
            end

            # it '歴史の編集ページへ遷移する' do
            #     all(:css, '.edit-history-icon')[0].click
            #     expect(page).to have_content('歴史の訂正')
            # end

            it '歴史の追加ページへ遷移する' do
                click_link(find(:css, '.add-history-link').text[0])
                expect(page).to have_content('歴史を記録')
            end
        end
    end


    describe '追加機能' do
        # テストユーザーを定義
        let(:user) { User.find(1) }
        let(:user_name) { user.name }

        # ログイン後歴史追加ページへ
        before do
            visit new_user_session_path
            fill_in 'メールアドレス', with: 'test@example.com'
            fill_in 'パスワード', with: 'password'
            find('.devise-button').click
            expect(page).to have_content 'ログインしました'
            visit new_user_history_path(user.id)
        end

        context '正常に歴史を追加' do
            it '歴史一覧ページへ遷移する' do
                fill_in('history_age', with: 20)
                fill_in('history_event', with: 'テスト中。テスト中。')
                fill_in('history_barometer', with: 50)
                (find_by_id('memory_history')).click
                expect(page).to have_content(user_name + 'の歴史')
            end
        end

        context 'エラーがでる歴史の追加' do
            it '出来事が入力されていない' do
                fill_in('history_age', with: 20)
                fill_in('history_event', with: '')
                fill_in('history_barometer', with: 50)
                (find_by_id('memory_history')).click
                expect(page).to have_content('主な出来事が入力されていません。')
            end

            it 'バロメーターが101より大きな数値' do
                fill_in('history_age', with: 20)
                fill_in('history_event', with: 'テスト中。テスト中。')
                fill_in('history_barometer', with: 101)
                (find_by_id('memory_history')).click
                expect(page).to have_content('バロメーターは101より小さい値にしてください')
            end
        end
    end


    describe '詳細表示機能' do
        # テストユーザーを定義
        let(:user) { User.find(1) }
        let(:user_name) { user.name }
        let(:first_history) { user.histories.first }

        # ログイン後歴史詳細ページへ
        before do
            visit new_user_session_path
            fill_in 'メールアドレス', with: 'test@example.com'
            fill_in 'パスワード', with: 'password'
            find('.devise-button').click
            expect(page).to have_content 'ログインしました'
            visit user_history_path(user.id, first_history.id)
        end

        context 'エラーが出るコメント' do
            before do
                find_by_id('comment_trriger').click
            end

            it 'コメントが未入力' do
                fill_in('comment_body', with: '')
                find_by_id('comment_btn').click
                expect(page).to have_content 'コメント内容が入力されていません'
            end

            it 'コメントが３６文字以上' do
                fill_in('comment_body', with: 'a' * 36)
                find_by_id('comment_btn').click
                expect(page).to have_content 'コメント内容は35文字以下に設定して下さい。'
            end
        end
    end
end