require 'time'
require 'cinch'
require 'time_diff'

dayLastSaid = Time.now

bot = Cinch::Bot.new do
    configure do |c|
        raise "Environment Variable for Server not Set." unless ENV.has_key?("server")
        raise "Environment Variable for Channel not Set." unless ENV.has_key?("channel")
        c.server   = ENV['server']
        c.channels = [ENV['channel']]
        c.nick = "NeatBot"
        if ENV.has_key?("username") && ENV.has_key?("password")
          c.nick = ENV['username']
          c.sasl.username = ENV['username']
          c.sasl.password = ENV['password']
        end
    end

    on :channel, /\b[Nn][Ee][Aa][Tt]\b/ do |m|
        if m.user.nick!="NeatBot"
            now = Time.now
            time_diff = Time.diff(dayLastSaid, now, '%y, %M, %w, %d, %H, %N, and %S')
            dayLastSaid = now
            m.reply "It has been #{time_diff[:diff]} since the last neat. #{m.user.nick} fucked it up."
        end
    end
end

bot.start
