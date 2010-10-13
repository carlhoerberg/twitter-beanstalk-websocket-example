require 'rubygems'
require 'beanstalk-client'
require 'twitter/json_stream'

username = ARGV.shift
password = ARGV.shift
raise "need username and password" if !username or !password

EventMachine::run {  
	stream = Twitter::JSONStream.connect(
		:path => '/1/statuses/filter.json?track=iphone',
		:auth => "#{username}:#{password}"
	)

	bt = Beanstalk::Pool.new(['localhost:11300'])

	stream.each_item do |status|
		bt.put(status)
	end
}
