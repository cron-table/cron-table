# CronTable
Basic cron-like system to schedule jobs

## Setup
1. Add `cron-table` gem
2. Run `rails app:cron_table:install:migrations`
3. Run `rails db:migrate` to apply migrations

## Usage
1. Add `include CronTable::Schedule` to the job
2. Define cron schedule using `crontable(every: <interval>)`
3. Use block if cron requires params, eg `crontable(every: 1.day) { perform_later(Time.current) }`

## Interval specification
Use `every` to specify when cron should run. Allowed values include:
1. Positive `ActiveSupport::Duration` like `1.hour`, `2.days`
2. Predefined intervals
  - `midnight`
  - `noon`
  - `beginning_of_hour`
3. Custom interval registered in `CronTable.every`, eg
```
  # config/initializers/cron_table.rb
  CronTable.every[:custom] = ->(context) { rand(1.hour..1.day).from_now }
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
