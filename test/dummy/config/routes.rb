Rails.application.routes.draw do
  mount CronTable::Engine => "/cron-table"
end
