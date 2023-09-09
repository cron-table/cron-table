require "active_support/all"

module CronTable
  module Schedule
    class DuplicateKeyError < ArgumentError
      def initialize(key)
        @key = key
      end

      def message = "There can be only one crontable entry with key `#{@key}`. Use `crontable(key: '<other unique name>')` to select a different key"
    end

    class MissingBlockError < ArgumentError
      def message = "Provide a block to `crontable(..) { }` with code to execute"
    end

    class InvalidEvery < ArgumentError
      def initialize(every)
        @every = every
      end

      def message = "Invalid every: #{every} "
    end

    extend ActiveSupport::Concern

    included do |_base|
      singleton_class.prepend(PrependedClassMethods)
    end

    module PrependedClassMethods
      def crontable(every:, key: self.name, &block)
        raise DuplicateKeyError.new(key) if CronTable.all.key? key

        block ||= -> { self.perform_later } if self.respond_to?(:perform_later)
        raise MissingBlockError if block.nil?
        raise InvalidEvery.new(every) unless every.is_a?(ActiveSupport::Duration)

        CronTable.all[key] = Definition.new(key:, every:, block:)

        self
      end
    end
  end
end
