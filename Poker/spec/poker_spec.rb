require 'poker'
require 'deck'
require 'card'
require 'hand'
require 'rspec'

describe "Poker Game" do

  describe Card do
    context '#initialize' do
      let(:card) { Card.new(9, :spade)}
      it 'should put in a value and a suit' do
        expect(card.value).to eq(9)
        expect(card.suit).to eq(:spade)
      end
    end
  end

  describe Deck do
    let(:deck) { Deck.new }
    context '#initialize' do
      it 'should successfully populate 52 valid cards' do
        Card::SUITS.keys.each do |suit|
          Card::VALUES.keys.each do |value|
            expect(deck.cards.include?(Card.new(value,suit))).to eq(true)
          end
        end

      end
    end

    context '#shuffle' do
      let(:deck) { Deck.new }
      let(:shuffle) { Deck.new.shuffle }
      it 'should successfully shuffle the deck' do
        shuffle.shuffle
        expect(deck.cards).to_not eq(shuffle)
      end
    end

    context '#draw' do
      it 'correctly removes a card from the deck' do
        deck.draw
        expect(deck.cards.count).to eq(51)
      end

    end
  end

  describe Hand do
    context '#initialize' do
      let(:deck) { Deck.new }
      let(:hand1) { Hand.new(deck) }

      it 'creates a hand with 5 cards from the deck' do
        hand1.populate(5)
        expect(hand1.set.count { |i| i.is_a? Card }).to eq(5)
      end
    end

    context '#populate' do
      let(:deck) { Deck.new }

      it 'removes cards from the board correctly' do
        hand = Hand.new(deck)
        hand.populate(5)
        expect(deck.cards.count).to eq(47)
      end
    end

    context 'Royal Flush' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a royal flush' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:ace, :heart), Card.new(:king, :heart), Card.new(:queen, :heart), Card.new(:jack, :heart) ,Card.new(:ten, :heart)]
        expect(hand.royal_flush?).to eq(true)
        hand.set = [Card.new(:ace, :spade), Card.new(:king, :heart), Card.new(:queen, :heart), Card.new(:jack, :heart) ,Card.new(:ten, :heart)]
        expect(hand.royal_flush?).to eq(false)
      end
    end

    context 'Straight Flush' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a straight flush' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :heart), Card.new(:eight, :heart), Card.new(:seven, :heart), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.straight_flush?).to eq(true)
        hand.set = [Card.new(:three, :diamond), Card.new(:king, :heart), Card.new(:queen, :heart), Card.new(:jack, :heart) ,Card.new(:ten, :heart)]
        expect(hand.straight_flush?).to eq(false)
      end
    end

    context 'Four of a kind ' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a 4 of a kind' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :heart), Card.new(:nine, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.four_of_a_kind?).to eq(true)
        hand.set = [Card.new(:eight, :heart), Card.new(:nine, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.four_of_a_kind?).to eq(false)
      end
    end

    context 'Full House' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a full house' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :heart), Card.new(:nine, :spade), Card.new(:nine, :diamond), Card.new(:five, :club) ,Card.new(:five, :heart)]
        expect(hand.full_house?).to eq(true)
        hand.set = [Card.new(:eight, :heart), Card.new(:nine, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.full_house?).to eq(false)
      end
    end

    context 'Flush' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a flush' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :heart), Card.new(:three, :heart), Card.new(:jack, :heart), Card.new(:four, :heart) ,Card.new(:five, :heart)]
        expect(hand.flush?).to eq(true)
        hand.set = [Card.new(:eight, :heart), Card.new(:nine, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.flush?).to eq(false)
      end
    end

    context 'Straight' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a straight' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :club), Card.new(:eight, :heart), Card.new(:seven, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.straight?).to eq(true)
        hand.set = [Card.new(:eight, :heart), Card.new(:nine, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.straight?).to eq(false)
      end
    end

    context '3 of a kind' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a 3 of a kind' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :club), Card.new(:nine, :heart), Card.new(:nine, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.three_of_a_kind?).to eq(true)
        hand.set = [Card.new(:two, :heart), Card.new(:jack, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.three_of_a_kind?).to eq(false)
      end
    end

    context '2 pair' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a 2 pair' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :club), Card.new(:nine, :heart), Card.new(:six, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.two_pair?).to eq(true)
        hand.set = [Card.new(:two, :heart), Card.new(:jack, :spade), Card.new(:nine, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.two_pair?).to eq(false)
      end
    end

    context 'pair' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a pair' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:nine, :club), Card.new(:nine, :heart), Card.new(:jack, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.pair?).to eq(true)
        hand.set = [Card.new(:two, :heart), Card.new(:jack, :spade), Card.new(:queen, :diamond), Card.new(:nine, :club) ,Card.new(:five, :heart)]
        expect(hand.pair?).to eq(false)
      end
    end

    context 'high card' do
      let(:deck) { Deck.new }
      it 'correctly evaluates a high card' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:king, :club), Card.new(:nine, :heart), Card.new(:jack, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.high_card).to eq(13)
        hand.set = [Card.new(:nine, :club), Card.new(:nine, :heart), Card.new(:queen, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.high_card).to eq(12)
      end
    end

    context 'parse hand' do
      let(:deck) { Deck.new }
      it 'correctly parses the hand' do
        hand = Hand.new(deck)
        hand.set = [Card.new(:king, :club), Card.new(:nine, :heart), Card.new(:jack, :spade), Card.new(:six, :heart) ,Card.new(:five, :heart)]
        expect(hand.parse_hand).to eq(0)
        hand.set = [Card.new(:ace, :heart), Card.new(:king, :heart), Card.new(:queen, :heart), Card.new(:jack, :heart) ,Card.new(:ten, :heart)]
        expect(hand.parse_hand).to eq(10)
        hand.set = [Card.new(:nine, :heart), Card.new(:three, :heart), Card.new(:jack, :heart), Card.new(:four, :heart) ,Card.new(:five, :heart)]
        expect(hand.parse_hand).to eq(5)
      end
    end
  end

end
