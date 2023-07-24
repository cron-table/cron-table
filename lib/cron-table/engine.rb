module CronTable
  class Engine < ::Rails::Engine
    isolate_namespace CronTable

    server do
      Thread.new do
        cron = CronTable::Server.new
        cron.sync!
        cron.run until true
      end if CronTable.attach_to_server
    end
  end
end
