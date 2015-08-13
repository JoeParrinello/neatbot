require 'time'
require 'cinch'

dayLastSaid = Time.now

bot = Cinch::Bot.new do
    configure do |c|
        raise "Environment Variable for Server not Set." unless ENV.has_key?("server")
        raise "Environment Variable for Channel not Set." unless ENV.has_key?("channel")
        c.server   = ENV['server']
        c.channels = [ENV['channel']]
        c.nick = "NeatBot"
    end

    on :channel, /\b[Nn][Ee][Aa][Tt]\b/ do |m|
        if m.user.nick!="NeatBot"
            now = Time.now
            daysSince = (now - dayLastSaid).to_i / (24 * 60 * 60)
            hoursSince = ((now - dayLastSaid).to_i / (24 * 60)) - (daysSince * 24)
            minutesSince = ((now - dayLastSaid).to_i / (24)) - (daysSince * 24 * 60) - (hoursSince * 60)
            dayLastSaid = now
            m.reply "It has been #{daysSince} days, #{hoursSince} hours, and #{minutesSince} minutes since the last neat. #{m.user.nick} fucked it up."
        end
    end
end

bot.start
