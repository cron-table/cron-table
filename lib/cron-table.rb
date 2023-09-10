require "cron-table/version"
require "cron-table/engine"
require "cron-table/definition"
require "cron-table/schedule"
require "cron-table/context"
require "cron-table/middlewares"

module CronTable
  mattr_accessor :attach_to_server, default: Rails.env.production?

  mattr_accessor :preload_dirs, default: ["app/jobs"]

  mattr_accessor :every, default: {}

  @@all = nil
  def self.all
    if @@all.nil?
      @@all = {}

      CronTable.preload_dirs.each do |dir|
        Rails.autoloaders.main.eager_load_dir(Rails.root.join(dir))
      end if CronTable.preload_dirs
    end

    @@all
  end

  def self.register(middleware)
    Middlewares.include(middleware)
  end
end
