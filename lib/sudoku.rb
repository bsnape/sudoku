class Sudoku

  attr_reader :grid, :input

  def initialize
    @input = nil
    @grid = []
  end

  def read_input(file)
    @input = File.read file
  end

  def parse_input
    @input.each_line do |row|
      @grid << row.strip.split(//)
    end
  end

end
