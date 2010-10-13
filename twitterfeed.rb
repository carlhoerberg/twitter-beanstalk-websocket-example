require 'rubygems'
require 'em-jack'
require 'twitter/json_stream'

username = ARGV.shift
password = ARGV.shift
raise "need username and password" if !username or !password

EventMachine::run do  
	stream = Twitter::JSONStream.connect(
		:path => '/1/statuses/filter.json?track=iphone',
		:auth => "#{username}:#{password}"
	)

	jack = EMJack::Connection.new
	jack.use 'twitter'

	stream.each_item do |status|
		jack.put(status)
	end
end
