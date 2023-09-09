require_relative "../test/dummy/config/environment"
require "rails/test_help"
require "mocha/minitest"

class ActiveSupport::TestCase
  def job_class
    CronTable.const_set("Job", Class.new { include CronTable::Schedule })

    yield CronTable::Job
  ensure
    CronTable.send(:remove_const, "Job")
  end
end
