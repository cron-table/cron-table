module CronTable
  class Definition < Struct.new(:key, :every, :block, keyword_init: true)
    delegate :call, to: :block

    def next_run_at(context)
      case every
      when ActiveSupport::Duration
        (context.last_run_at || Time.current) + every
      when Symbol
        CronTable.every.fetch(every).call(context)
      end
    end
  end
end
