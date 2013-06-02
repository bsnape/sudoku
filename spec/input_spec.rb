require_relative '../lib/input'

describe Input do

  before(:each) do
    @input = Input.new
  end

  it 'should take a text file as input' do
    file = File.new('tmp/file.txt', 'w+')
    @input.read_input file
  end

  it 'should store the input in an instance variable' do
    file = File.new('spec/sudoku.txt', 'r')
    @input.read_input file
    @input.input.should_not be_nil
  end

end
