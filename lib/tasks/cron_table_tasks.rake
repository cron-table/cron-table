namespace :cron_table do
  desc "Run cron_table scheduler"
  task run: :environment do
    cron = CronTable::Server.new
    cron.sync!

    Signal.trap("INT") { cron.exit! }
    Signal.trap("TERM") { cron.exit! }

    cron.run! until cron.exit?
  end
end
