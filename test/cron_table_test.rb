require "test_helper"

class CronTableTest < ActiveSupport::TestCase
  setup do
    CronTable.all.clear
  end

  test "list is empty when no crons are defined" do
    assert_empty CronTable.all
  end

  test "crons are added to the list" do
    job_class do |job|
      job.class_eval { crontable(every: 1.day, key: "daily") { } }

      assert_equal 1, CronTable.all.size
      assert_equal 1.day, CronTable.all["daily"].every
    end
  end

  test "if no block is provided, job is scheduled without params" do
    job_class do |job|
      job.expects(:perform_later).with()
      job.class_eval { crontable(every: 1.day) }

      CronTable.all[job.name].call
    end
  end
end
