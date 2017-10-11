class TowersOfHanoi

  attr_accessor :name, :board

  def initialize(name)
    @board = Array.new(3) { Array.new }
    @board[0] = [1,2,3]
    @name = name
  end

  def play
    until won?
      prompt
    end
    puts 'You won!!!!!!11111111'
  end

  def prompt
    begin
      p @board
      puts "enter a number between 0 and 2"
      start = gets.chomp.to_i
      puts "enter another number between 0 and 2"
      ending = gets.chomp.to_i

      move(start, ending)
    rescue StandardError => e
      puts e
      retry
    end
  end

  def move(start, ending)
    raise StandardError if !valid_move?(start, ending)
    @board[ending].unshift(@board[start].shift)
  end

  def valid_move?(start, ending)
    return false if !(0..2).cover?(start) || !(0..2).cover?(ending)
    return false if @board[start].empty?
    if @board[start][0] && @board[ending][0]
      return false if @board[start][0] > @board[ending][0]
    end
    true
  end

  def won?
    @board == [[],[],[1,2,3]] || @board == [[],[1,2,3],[]]
  end

end

if __FILE__ == $PROGRAM_NAME
  game = TowersOfHanoi.new("Mike")
  game.play
end
