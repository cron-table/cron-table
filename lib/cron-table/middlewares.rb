module CronTable
  class BaseMiddleware
    def process(context)
      yield
    end
  end

  class Middlewares < BaseMiddleware
  end
end
