class ExampleJob < ApplicationJob
  include CronTable::Schedule

  crontable every: 1.day
  crontable every: 1.hour, key: "hourly"

  def perform
    puts "This will be called once a day and once an hour"
  end
end
