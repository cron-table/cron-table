require_relative "../test/dummy/config/environment"
require "rails/test_help"
require "mocha/minitest"

class ActiveSupport::TestCase
  def job_class
    CronTableTest.const_set("Job", Class.new { include CronTable::Schedule })

    yield CronTableTest::Job
  ensure
    CronTableTest.send(:remove_const, "Job")
  end
end
