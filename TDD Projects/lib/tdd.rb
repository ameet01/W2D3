class Array

  def my_uniq
    hsh = Hash.new
    self.each do |i|
      hsh[i] = true
    end
    hsh.keys
  end

  def two_sum
    arr = []
    self.each_index do |i|
      self.each_index do |j|
        arr << [i, j] if self[i] + self[j] == 0 && j > i
      end
    end
    arr
  end

  def my_tranpose
    result = []
    n = 0

    until n == self.length
      temp = []
      self.each_index do |i|

        temp << self[i][n]
      end

      result << temp
      n += 1
    end

    result
  end

  def stock_picker
    result = []
    (0...self.length-1).each do |i|
      array = self[i+1...self.length]
      max = array.max
      result << [i, self.index(max)]# if i < self.index(max)
    end
    result.max_by { |el| self[el[1]] - self[el[0]] }
  end



end
