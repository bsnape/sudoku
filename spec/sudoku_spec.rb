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

  it 'should return the row values when given a row index' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_row_values(2).should match_array ["1", "4", "6", "8"]
  end

  it 'should return the column values when given a column index' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_column_values(6).should match_array ["2", "3", "4", "5", "6", "9"]
  end

  it 'should return the correct square when given row and column idices' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_square(0, 0).should == 1
    @sudoku.get_square(2, 5).should == 2
    @sudoku.get_square(6, 4).should == 8
    @sudoku.get_square(7, 6).should == 9
  end

  it 'should return the square values when given row and column indices' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_square_values(0, 7).should match_array ["1", "4", "6"]
  end

  it 'should return the combined row, column and square possibilities when given row and column indices' do
    file = File.new('spec/sudoku.txt', 'r')
    @sudoku.read_input file
    @sudoku.parse_input
    @sudoku.get_possibilities(8, 5).should match_array ['4', '7']
  end

end
