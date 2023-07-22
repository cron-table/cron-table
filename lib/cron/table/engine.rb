module Cron
  module Table
    class Engine < ::Rails::Engine
      isolate_namespace Cron::Table
    end
  end
end
