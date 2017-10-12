class Poker

  def initialize(*players)
    @deck = Deck.new
    @players = players
  end
end
