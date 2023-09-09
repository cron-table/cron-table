module CronTable
  class Server
    SLEEP = 1.second..1.day
    SLEEP_IDLE = 1.hour

    def initialize
    end

    def sync!
      crons = CronTable.all.clone
      deleted = []
      Item.transaction do
        Item.lock.all.each do |cron|
          if definition = crons.delete(cron.key)
            context = Context.new(last_run_at: nil)
            cron.update(next_run_at: definition.next_run_at(context)) if cron.next_run_at.nil?
          elsif cron.next_run_at.present?
            deleted << cron.key
          end
        end
        Item.where(key: deleted).update(next_run_at: nil)
        crons.each do |key, definition|
          context = Context.new(last_run_at: nil)
          Item.create(key: key, next_run_at: definition.next_run_at(context))
        end
      end
    end

    def run!
      Item.connection_pool.with_connection do
        sync!
      end

      @exit = false

      Item.connection_pool.with_connection do
        run_once!
      end until exit?
    end

    def exit!
      @exit = true
      interrupt!
    end

    def exit?
      @exit.present?
    end

    private

    def run_once!
      next_run_at = Item.minimum(:next_run_at) || SLEEP_IDLE.from_now
      interruptible_sleep(next_run_at.to_f - Time.now.to_f)

      Item.lock.where(next_run_at: ..Time.now).each do |cron|
        process(cron)
      end
    end

    def process(cron)
      Rails.application.reloader.wrap do
        definition = CronTable.all.fetch(cron.key)
        definition.call

        context = Context.new(last_run_at: cron.next_run_at)
        cron.update(last_run_at: Time.now, next_run_at: definition.next_run_at(context))
      end
    rescue => e
      cron.update(next_run_at: nil)
      Rails.error.report(e, handled: true, severity: :error, context: { cron: cron.id })
    end

    def interruptible_sleep(seconds)
      @sleep, @interrupt = IO.pipe
      IO.select([@sleep], nil, nil, seconds.to_i.clamp(SLEEP))
    end

    def interrupt!
      @interrupt&.close
    end
  end
end
