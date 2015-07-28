require 'json'

class Hasher
    def initialize()
        @prime_hash = Hash.new
        
        @prime_hash['test'] = {'test' => 'test123', 'test2' => 'test321', 'test3' => 'test456'}
    end
    
    def get_hash(key, *args)
        begin
            if args.size < 1
                return JSON.generate(@prime_hash[key])
            else
                return JSON.generate(@prime_hash[key].select { |k,v| args.include?(k) })
            end
        rescue Exception
            return JSON.generate({:error => 'No key found!'} )
        end
    end
    
    def select_hash(key, val)
        begin
            puts @prime_hash.select { |k| k[key] == val }
        rescue Exception => e
            puts e
        end
    end
end