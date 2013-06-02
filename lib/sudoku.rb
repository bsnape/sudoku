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

  def get_row_possibilities(x, y)
    values = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    row = [0..8].map { |n| @grid[x][n] }.flatten
    values - row
  end

end
