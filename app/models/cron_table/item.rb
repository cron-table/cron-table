module CronTable
  class Item < ApplicationRecord
    self.table_name = "cron_table"
  end
end
