require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    populate
    shuffle
  end

  def populate
    Card::SUITS.each_key do |suit|
      Card::VALUES.each_key do |value|
        @cards << Card.new(value, suit)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def draw(n = 1)
    @cards.shift(n)
  end

  def deal(hand, n)
    hand.set += draw(n)
  end
end
