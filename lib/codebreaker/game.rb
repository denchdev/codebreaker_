module Codebreaker
  class Game
    attr_reader :user
    CODESIZE = 4
    MAXATTEMPS = 4

    def initialize name
      @secret_code = ""
      @saver = Saver.new
      if @saver.users[name].nil?
        @user = User.new name
        @saver.users[name] = @user
      else
        @user = @saver.users[name]
      end
    end

    def start
      random = Random.new
      CODESIZE.times { @secret_code += random.rand(1..6).to_s }
    end

    def check_up answer
      code = @secret_code.dup
      result = ""
      i = 0
      answer.each_char do |c|
        if c == code[i]
          result << "+"
          code[i], answer[i] = "0", "0"
        end
        i += 1
      end
      answer.each_char do |c|
        unless c == "0"
          result << "-" if code.include? c
        end
      end
      result
    end

    def hint index
      if @user.score > 50
        @user.score -= 50
        @secret_code[index]
      else
        "You do not have score("
      end
    end

    def save
      @saver.save
    end
    
#    def game guess
#      count = 0
#      until result.eq "++++"
#        count += 1
#        result = check_up guess
#        @user.attempts_total += 1
#        if (count) == MAXATTEMPS
#          return 0
#        end
#      end
#      @user.attempts << count
#      @user.score += 100
#      return 1
#      end
#    end

  end
end
