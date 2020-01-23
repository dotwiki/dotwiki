if Rails.env.production?
  Redis.current = Redis.new(
    host: ENV['REDIS_HOST'],
    port: ENV['REDIS_PORT'],
    password: ENV['REDIS_PASSWORD']
  )
else
  Redis.current = Redis.new(
    host: ENV['REDIS_HOST'],
    port: ENV['REDIS_PORT'],
  )
end