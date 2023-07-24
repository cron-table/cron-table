module CronTable
  class Definition < Struct.new(:key, :every, :block, keyword_init: true)
    delegate :call, to: :block

    def next_run_at(now)
      now + every
    end
  end
end
