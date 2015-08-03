require 'socket'
require 'colorize'
require './deps/hasher'
require 'json'

class Server
    def initialize(port, debug, key)
        @port = port
        @key = key
        @hash_obj = Hasher.new()
        
        puts @hash_obj.get_hash('test', 'test123', '=')
    end
    
    def debug(stat, str)
        case stat
            when 1
                puts ("[#{Time.now}] ").colorize(:blue) + str.colorize(:green)
        end
    end
    
    def return_message(str)
        return JSON.generate({:message => str})
    end
    
    def serve()
        debug(1, 'Listening on port: ' + @port.to_s)
        
        server = TCPServer.new @port
        
        loop do
            Thread.start(server.accept) do |c|
                logged_in = false
                
                while l = c.gets
                    f, *r = l.chop.split(' ')
                    if f == 'exit'
                        c.close
                    else
                        if(defined? @key and logged_in == true) || (defined? key == false)
                            if f == 'pull'
                                c.puts @hash_obj.pull_hash(r[0])
                            elsif f == 'get'
                                c.puts @hash_obj.get_hash(r[0], r[1], r[2])
                            end 
                        else
                            if f == 'login'
                                if r[0] == @key
                                    c.puts return_message('Correct')
                                    logged_in = true
                                else
                                    c.puts return_message('Wrong')
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
