namespace :user_comment do
    desc "テスト"
    task :test do
        puts "Hello World"
    end

    desc "違反コメントの削除"
    task :delete => :environment do
        comments = Comment.where(
                "body LIKE ?", "%死ね%"
            ).or(Comment.where(
                    "body LIKE ?", "%きもい%"
                )).or(Comment.where(
                        "body LIKE ?", "%きも"
                    )).or(Comment.where(
                        "body LIKE ?", "%うんち%"
                    )).or(Comment.where(
                        "body LIKE ?", "%うんこ%"
                    )).or(Comment.where(
                        "body LIKE ?", "%糞%"
                    )).or(Comment.where(
                        "body LIKE ?", "シネ"
                    )).or(Comment.where(
                        "body LIKE ?", "しね%"
                    )).or(Comment.where(
                        "body LIKE ?", "カス"
                    )).or(Comment.where(
                        "body LIKE ?", "ごみ"
                    )).or(Comment.where(
                        "body LIKE ?", "ゴミ"
                    ))
        comments.delete_all
    end
end
