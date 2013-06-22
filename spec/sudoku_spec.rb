require_relative '../lib/sudoku'

describe Sudoku do

  before(:all) do
    Dir.mkdir 'tmp' unless Dir.exist? 'tmp'
  end

  before(:each) do
    @sudoku = Sudoku.new
  end

  it 'should take a text file as input' do
    file = File.new('tmp/file.txt', 'w+')
    @sudoku.read_input file
  end

  it 'should store the input in an instance variable' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.input.should_not be_nil
  end

  describe 'grid behaviour' do

    before(:each) do
      file = File.new('spec/sudoku.txt', 'r')
      @sudoku.read_input file
      @sudoku.parse_input
    end

    it 'should parse the input correctly' do
      @sudoku.grid[2][6].should == '4'
    end

    it 'should return the row values when given a row index' do
      @sudoku.get_row_values(2).should match_array ["1", "4", "6", "8"]
    end

    it 'should return the column values when given a column index' do
      @sudoku.get_column_values(6).should match_array ["2", "3", "4", "5", "6", "9"]
    end

    it 'should return the correct square when given row and column idices' do
      @sudoku.get_square(0, 0).should == 1
      @sudoku.get_square(2, 5).should == 2
      @sudoku.get_square(6, 4).should == 8
      @sudoku.get_square(7, 6).should == 9
    end

    it 'should return the square values when given row and column indices' do
      @sudoku.get_square_values(0, 7).should match_array ["1", "4", "6"]
    end

    it 'should return the combined row, column and square possibilities when given row and column indices' do
      @sudoku.get_possibilities(8, 5).should match_array ['4', '7']
    end

    it 'should return an empty array and not calculate the possibilities if a value exists at that index' do
      @sudoku.get_possibilities(1, 0).should match_array []
    end

    it 'should traverse the whole Sudoku grid and find the correct first move in the form row, column, value' do
      @sudoku.find_move.should match_array ['4', '5', '4']
    end

    it 'should allow the stored grid to be updated' do
      @sudoku.grid[0][0].should == '0'
      @sudoku.update_grid(0, 0, '1')
      @sudoku.grid[0][0].should == '1'
    end

    it 'should count the number of unsolved values in the grid' do
      @sudoku.count_unsolved_values.should == 49
    end

    it 'should find the correct solution' do
      @sudoku.count_unsolved_values.times do
        row, column, value = @sudoku.find_move
        @sudoku.update_grid(row, column, value)
      end

      proposed_solution = @sudoku.grid

      file = File.new('spec/solution.txt', 'r')
      @sudoku.read_input file
      @sudoku.parse_input

      proposed_solution.should match_array @sudoku.grid
    end

  end
end

