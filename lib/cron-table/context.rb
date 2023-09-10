module CronTable
  class Context < Struct.new(:last_run_at, :cron, keyword_init: true)
  end
end
