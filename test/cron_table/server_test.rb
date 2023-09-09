require "test_helper"

module CronTable
  class ServerTest < ActiveSupport::TestCase
    test "creates valid cronjobs in database" do
      assert_empty(Item.all)
      Server.new.sync!
      assert_equal(["ExampleJob", "hourly"], Item.pluck(:key).sort)
    end
  end
end
