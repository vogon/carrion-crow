class UserPool
    def initialize
        @pool = []
        @cursor = 0
    end

    def add(username)
        @pool << username
    end

    def next!
        @cursor = (@cursor + 1) % @pool.length
    end

    def current
        @pool[@cursor]
    end
end