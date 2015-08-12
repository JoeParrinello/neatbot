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
        if (m.user.nick!="NeatBot"){
            now = Time.now
            daysSince = (now - dayLastSaid).to_i / (24 * 60 * 60)
            dayLastSaid = now
            m.reply "It has been #{daysSince} days since the last neat. #{m.user.nick} fucked it up."
        }
    end
end

bot.start
