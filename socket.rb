require 'rubygems'
require 'em-websocket'
require 'em-jack'

EventMachine::WebSocket.start(:host => "127.0.0.1", :port => 8080) do |ws|
	ws.onopen do
		puts "WebSocket opened"

		jack = EMJack::Connection.new
		jack.each_job do |msg|
			ws.send msg.body
			jack.delete msg
		end
	end

	ws.onclose do
		puts "WebSocket closed"
	end
end
