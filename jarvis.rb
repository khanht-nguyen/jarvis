require './deps/server'
require 'yaml'

config = YAML.load_file(__dir__ + "/config.yml")

if config == false then
    raise('Either the configuration file could not be found or nothing was in there!')
end

threads = []

config.each do |k, v|
    threads << Thread.new do 
        puts 'Setting up channel: ' + k
        server = Server.new(v['port'], v['debug_level'], v['key'])
        server.serve()
    end
end

begin
    threads.each{ |t| t.join }
rescue Exception => e
    puts e
    puts 'Good bye!'
end