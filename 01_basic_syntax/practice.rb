class User
    attr_accessor :name, :email, :password, :rooms
  
    def initialize(name, email, password)
      @name = name
      @email = email
      @password = password
      @rooms = []
    end
  
    def enter_room(room)
      room.add_user(self)
      @rooms << room unless @rooms.include?(room)
    end
  
    def send_message(room, content)
      if @rooms.include?(room)
        message = Message.new(self, room, content)
        room.broadcast(message)
      else
        puts "คุณต้องเข้าร่วมห้องนี้ก่อน"
      end
    end
  
    def acknowledge_message(room, message)
      puts "ข้อความจาก #{message.user.name} ในห้อง #{room.name}: #{message.content}"
    end
  end
  
  class Room
    attr_accessor :name, :description, :users
  
    def initialize(name, description)
      @name = name
      @description = description
      @users = []
    end
  
    def add_user(user)
      @users << user unless @users.include?(user)
    end
  
    def broadcast(message)
      @users.each do |user|
        user.acknowledge_message(self, message) unless user == message.user
      end
    end
  end
  
  class Message
    attr_accessor :user, :room, :content
  
    def initialize(user, room, content)
      @user = user
      @room = room
      @content = content
    end
  end
  
  user1 = User.new("Alice", "alice@example.com", "password123")
  user2 = User.new("Bob", "bob@example.com", "password456")
  room1 = Room.new("General", "ห้องสำหรับแชททั่วไป")
  
  user1.enter_room(room1)
  user2.enter_room(room1)
  
  user1.send_message(room1, "สวัสดีทุกคน!")
  