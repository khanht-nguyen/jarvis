require 'json'

class Hasher
    def initialize()
        @prime_hash = Hash.new
        
        @prime_hash['test'] = {'test' => 'test123', 'test2' => 'test321', 'test3' => 'test456'}
        @prime_hash['test2'] = {'test' => 'test123', 'test2' => 'test321', 'test3' => 'test456'}
        @prime_hash['tes3'] = {'test' => 'test123', 'test2' => 'test321', 'test3' => '4'}
    end
    
    def pull_hash(key, *args)
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
    
    def get_hash(key, delim, val)
        begin
            temp_hash = Hash.new
            
            @prime_hash.select do |k, v|
                case delim
                when '='
                    if v[key] == val
                        temp_hash[k] = v
                    end
                when '>='
                    if v[key] >= val
                        temp_hash[k] = v
                    end
                when '<='
                    if v[key] <= val
                        temp_hash[k] = v
                    end
                when '<'
                    if v[key] < val
                        temp_hash[k] = v
                    end
                when '>'
                    if v[key] > val
                        temp_hash[k] = v
                    end
                end
            end
            
            return temp_hash
        rescue Exception => e
            return JSON.generate({:error => 'No key found!'} )
        end
    end
    
    def push_hash(key, val)
    
    end
end