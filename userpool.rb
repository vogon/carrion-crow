require 'yaml'

class UserPool
    def initialize
        parts = YAML.load_file('users.yml')
        @pool = parts[:pool]
        @cursor = parts[:cursor]
    end

    def flush
        obj = {:pool=>@pool, :cursor=>@cursor}
        File.open('users.yml', 'w') do |out|
            YAML.dump(obj, out)
        end
    end

    def add(username)
        if !@pool.include? username
            @pool << username
            flush
        end
    end

    def next!
        @cursor = (@cursor + 1) % @pool.length
        flush
    end

    def current
        @pool[@cursor]
    end
end
