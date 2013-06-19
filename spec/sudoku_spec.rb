require_relative '../lib/sudoku'

describe Sudoku do

  before(:each) do
    @sudoku = Sudoku.new
  end

  it 'should take a text file as input' do
    Dir.mkdir 'tmp' unless Dir.exist? 'tmp'
    file = File.new('tmp/file.txt', 'w+')
    @sudoku.read_input file
  end

  it 'should store the input in an instance variable' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.input.should_not be_nil
  end

  it 'should parse the input correctly' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.grid[2][6].should == '4'
  end

  it 'should return the possible row values when given an index' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_row_possibilities(2).should match_array ['2', '3', '5', '7', '9']
  end

  it 'should return the possible column values when given an index' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_column_possibilities(6).should match_array ['1', '7', '8']
  end

  it 'should return the correct square when given a row and column' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_square(0, 0).should == 1
    @sudoku.get_square(2, 5).should == 2
    @sudoku.get_square(6, 4).should == 8
    @sudoku.get_square(7, 6).should == 9
  end

  it 'should return the possible square values when given a row and column' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_square_possibilities(0, 7).should match_array ['2', '3', '5', '7', '8', '9']
  end

end
