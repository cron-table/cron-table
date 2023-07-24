# CronTable
Basic cron-like system to schedule jobs

## Setup
1. Add `cron-table` gem
2. Run `rails app:cron_table:install:migrations`
3. Run `rails db:migrate` to apply migrations

## Usage
1. Add `include CronTable::Schedule` to the job
2. Define cron schedule using `crontable(every: <interval>)`
3. Use block if cron requires params, eg `crontable(every: 1.day) { perform_later(Time.now) }`

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
