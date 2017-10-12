class Hand

  attr_accessor :set

  def initialize(deck)
    @deck = deck
    @set = []
  end

  def populate(n)
    n.times do |i|
      @set << @deck.cards.shift
    end
  end

  def royal_flush?
    hash = Hash.new(0)
    @set.each do |i|
      hash[i.suit] += 1
    end

    @set.count {|i| i.value == :ace} == 1 &&
    @set.count {|i| i.value == :king} == 1 &&
    @set.count {|i| i.value == :queen} == 1 &&
    @set.count {|i| i.value == :jack} == 1 &&
    @set.count {|i| i.value == :ten} == 1 &&
    hash.keys.length == 1
  end

  def straight_flush?
    hash = Hash.new(0)
    @set.each do |i|
      hash[i.suit] += 1
    end

    sorted_array = @set.map {|i| Card::VALUES[i.value].to_i}.sort
    max = sorted_array.max
    min = sorted_array.min
    difference = max - min

    hash.keys.length == 1 && difference == 4
  end

  def four_of_a_kind?
    hash = Hash.new(0)

    @set.each do |i|
      hash[i.value] += 1
    end

    hash.each do |k,v|
      return true if v == 4
    end
    false
  end

  def full_house?
    hash = Hash.new(0)

    @set.each do |i|
      hash[i.value] += 1
    end

    hash.values.count(3) == 1 &&
    hash.values.count(2) == 1
  end

  def flush?
    hash = Hash.new(0)

    @set.each do |i|
      hash[i.suit] += 1
    end
    return true if hash.values.include?(5)
    false
  end

  def straight?

    sorted_array = @set.map {|i| Card::VALUES[i.value].to_i}.sort
    sorted_array.each_index do |j|
      break if j == sorted_array.length - 1
      return false if sorted_array[j+1] - sorted_array[j] != 1
    end
    true
  
  end

  def parse_hand

  end
end
