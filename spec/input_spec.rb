require_relative '../lib/input'

describe Input do

  it 'should take a text file as input' do
    @input = Input.new
    file = File.new('tmp/file.txt', 'w+')
    @input.read_input file
  end

end
