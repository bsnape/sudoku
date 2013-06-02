class Input

  attr_reader :input

  def initialize
    @input = nil
  end

  def read_input(file)
    @input = File.read file
  end

end
