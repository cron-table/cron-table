module CronTable
  class Engine < ::Rails::Engine
    isolate_namespace CronTable

    server do
      Thread.new do
        CronTable::Server.new.run!
      end if CronTable.attach_to_server
    end
  end
end
