case Rails.env
when "production"
  namespace = [Rails.application.class.engine_name, Rails.env].join(':')
  Redis.current = Redis::Namespace.new(namespace,
    redis: Redis.new(url: ENV['REDIS_URL'])
when "development"
  namespace = [Rails.application.class.engine_name, Rails.env].join(':')
  Redis.current = Redis::Namespace.new(namespace,
    redis: Redis.new(host: ENV['REDIS_HOST'], port: ENV['REDIS_PORT']))
when "test"
  namespace = [Rails.application.class.engine_name, Rails.env].join(':')
  Redis.current = Redis::Namespace.new(namespace, redis: MockRedis.new)
end
