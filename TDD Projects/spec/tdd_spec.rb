require 'tdd'
require 'towers_of_hanoi'

RSpec.describe Array do

  context 'methods' do
    describe '#my_uniq' do
      let(:array1) { [1, 1, 1, 2, 3, 4, 4, 5] }
      let(:array2) { [1, 2, 3, 4, 5] }
      it 'should return a new array with duplicates removed' do
        expect(array1.my_uniq).to eq(array2)
      end

      it 'should should be in order from original array' do
        expect([4,5,2,1,7,4,5,7,2].my_uniq).to eq([4,5,2,1,7])
      end
    end

    describe '#two_sum' do
      it 'should return all pairs that sum to zero' do
        expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
      end

      it 'should not count an element in an array twice' do
        expect([0, 1, 2, 3].two_sum).to be_empty
      end

      it 'should have smaller first elements come first' do
        expect([-1, 0, 2, -2, 1].two_sum).to_not eq([[2, 3], [0, 4]])
        expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
      end

      it 'should have smaller second elements come first' do
        expect([-1, 1, 1].two_sum).to_not eq([[0, 2], [0, 1]])
        expect([-1, 1, 1].two_sum).to eq([[0, 1], [0, 2]])
      end

    end

    describe "#my_transpose" do
      let(:array1) { [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ] }
      let(:array2) { [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8]
        ] }
      it 'should tranpose rows into columns' do
        expect(array1.my_tranpose).to eq(array2)
      end
    end

    describe "#stock_picker" do
      stocks = [86,55,105,89,27,30,99,23]
      it 'should output the most profitable pair of days' do
        expect(stocks.stock_picker).to eq([4, 6])
      end

      it 'should not should sell before you buy' do
        expect(stocks.stock_picker).to_not eq([2, 7])
      end
    end

  end

end

RSpec.describe TowersOfHanoi do

  subject(:game) { TowersOfHanoi.new('mike') }

  describe '#initialize' do
    it 'should initialize with array of arrays, first spot is [1,2,3]' do
      expect(game.board).to eq([[1,2,3], [], []])
    end

    it 'sets the name of the player' do
      expect(game.name).to eq('mike')
    end
  end

  describe '#move' do
    it 'should properly move a ring to another spot' do
      game.move(0, 2)
      expect(game.board).to eq([[2,3],[],[1]])
    end

    it 'should raise a standarderror if move is not valid' do
      expect {game.move(5, 5)}.to raise_error(StandardError)
    end
  end

  describe '#valid_move?' do
    it 'should not move big ring onto small ring' do
      game.board = [[1],[2],[3]]
      expect(game.valid_move?(2,0)).to eq(false)
    end

    it 'should not be out of bounds for both beginning and ending' do
      expect(game.valid_move?(2,5)).to eq(false)
      expect(game.valid_move?(5,2)).to eq(false)
    end

    it 'should not have an empty beginning value' do
      game.board = [[2,3],[],[1]]
      expect(game.valid_move?(1,2)).to eq(false)
    end
  end

  describe '#won?' do
    it 'should not be true when the game starts' do
      expect(game.won?).to eq(false)
    end

    it 'should properly know when the game is won' do
      game.board = [[],[1,2,3],[]]
      expect(game.won?).to eq(true)

      game.board = [[1,2,3],[],[]]
      expect(game.won?).to eq(false)

      game.board = [[],[],[1,2,3]]
      expect(game.won?).to eq(true)

      game.board = [[],[3],[1,2]]
      expect(game.won?).to eq(false)
    end
  end
end
