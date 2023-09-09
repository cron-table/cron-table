require "cron-table/version"
require "cron-table/engine"
require "cron-table/definition"
require "cron-table/schedule"
require "cron-table/context"

module CronTable
  mattr_accessor :attach_to_server, default: Rails.env.production?

  mattr_accessor :preload_dirs, default: ["app/jobs"]

  mattr_accessor :every, default: {
            midnight: ->(context) {
              context.last_run_at.present? ?
                (context.last_run_at + 1.day).midnight : Time.now.midnight
            },
            noon: ->(context) {
              context.last_run_at.present? ?
                (context.last_run_at + 1.day).noon : Time.now.noon
            },
          }

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
end
