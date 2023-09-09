module CronTable
  class Engine < ::Rails::Engine
    isolate_namespace CronTable

    config.before_initialize do
      CronTable.every[:midnight] = ->(context) {
        (context.last_run_at || Time.current).since(1.day).midnight
      }
      CronTable.every[:noon] = ->(context) {
        (context.last_run_at&.since(1.day) || 12.hours.from_now).noon
      }
      CronTable.every[:beginning_of_hour] = ->(context) {
        (context.last_run_at || Time.current).since(1.hour).beginning_of_hour
      }
    end

    server do
      Thread.new do
        CronTable::Server.new.run!
      end if CronTable.attach_to_server
    end
  end
end
