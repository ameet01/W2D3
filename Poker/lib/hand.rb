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

  def three_of_a_kind?
    hash = Hash.new(0)

    @set.each do |i|
      hash[i.value] += 1
    end

    return true if hash.values.include?(3)
    false
  end

  def two_pair?
    hash = Hash.new(0)

    @set.each do |i|
      hash[i.value] += 1
    end

    hash.values.count(2) == 2
  end

  def pair?
    hash = Hash.new(0)

    @set.each do |i|
      hash[i.value] += 1
    end

    hash.values.count(2) == 1
  end

  def high_card
    @set.map {|i| Card::VALUES[i.value].to_i }.sort.last
  end

  def parse_hand
    if royal_flush?
      return 10
    elsif straight_flush?
      return 9
    elsif four_of_a_kind?
      return 7
    elsif full_house?
      return 6
    elsif flush?
      return 5
    elsif straight?
      return 4
    elsif three_of_a_kind?
      return 3
    elsif two_pair?
      return 2
    elsif pair?
      return 1
    else
      return 0
    end
  end
end
