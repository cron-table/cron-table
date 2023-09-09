module CronTable
  class Context < Struct.new(:last_run_at, keyword_init: true)
  end
end
