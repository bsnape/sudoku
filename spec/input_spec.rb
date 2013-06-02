require_relative '../lib/sudoku'

describe Sudoku do

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
    @sudoku.grid.should_not be_nil
  end

end
