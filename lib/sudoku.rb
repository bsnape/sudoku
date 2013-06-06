class Sudoku

  attr_reader :grid, :input

  def initialize
    @input = nil
    @grid = []
  end

  def read_input file
    @input = file.read
  end

  def parse_input
    @input.each_line do |row|
      @grid << row.strip.split(//)
    end
  end

  def get_row_possibilities(row_index)
    values = (1..9).map { |n| n.to_s }
    row = (0..8).map { |n| @grid[row_index][n] }.flatten
    values - row
  end

  def get_column_possibilities(column_index)
    values = (1..9).map { |n| n.to_s }
    column = (0..8).map { |n| @grid[n][column_index] }
    values - column
  end

end
