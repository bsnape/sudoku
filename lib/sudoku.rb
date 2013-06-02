class Sudoku

  attr_reader :grid

  def initialize
    @grid = nil
  end

  def read_input(file)
    @grid = File.read file
  end

end
