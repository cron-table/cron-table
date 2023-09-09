require "test_helper"

class CronTable::EveryTest < ActiveSupport::TestCase
  test "midnight resolves to closest 00:00" do
    travel_to "5 am" do
      assert_equal 1.day.from_now.midnight, call(:midnight)
    end
  end

  test "noon resolves to closest 12:00" do
    travel_to "5 am" do
      assert_equal Time.current.noon, call(:noon)
    end
    travel_to "5 pm" do
      assert_equal 1.day.from_now.noon, call(:noon)
    end
  end

  test "beginning_of_hour resolves to closest hour" do
    travel_to "10:00" do
      assert_equal DateTime.parse("11:00"), call(:beginning_of_hour)
    end
    travel_to "10:01" do
      assert_equal DateTime.parse("11:00"), call(:beginning_of_hour)
    end
    travel_to "10:59" do
      assert_equal DateTime.parse("11:00"), call(:beginning_of_hour)
    end
  end

  def call(every)
    CronTable.every.fetch(every).call(Struct.new(:last_run_at).new(nil))
  end
end
