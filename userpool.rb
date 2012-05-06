class UserPool
    def initialize
        @pool = []
    end

    def add(username)
        @pool << username
    end
end