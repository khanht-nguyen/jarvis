require 'socket'
require 'colorize'
require './deps/hasher'

class Server
    def initialize(port, debug, key)
        @port = port
        @key = key
        @hash_obj = Hasher.new()
        
        @hash_obj.select_hash('test', 'test123')
    end
    
    def debug(stat, str)
        case stat
            when 1
                puts ("[#{Time.now}] ").colorize(:blue) + str.colorize(:green)
        end
    end
    
    def serve()
        debug(1, 'Listening on port: ' + @port.to_s)
        
        server = TCPServer.new @port
        
        loop do
            Thread.start(server.accept) do |c|
                while l = c.gets
                    if l.chop == 'exit'
                        c.close
                    else
                    
                        if l.chop == 'get'
                            c.puts @hash_obj.get_hash('test')
                        end
                    end
            end
          end
        end
    end
end
