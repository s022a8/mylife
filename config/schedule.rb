# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")

#実行環境の指定
set :environment, Rails.env.to_sym
#実行logの出力先
set :output, "#{Rails.root.to_s}/log/cron.log"


# 違反コメントの削除（６時間おき）
every 6.hours do
    rake "user_comment:delete"
end

# １ヶ月たったアンケートの削除（１日おき）
every 24.hours do
    rake "user_questionnaire:expire"
end