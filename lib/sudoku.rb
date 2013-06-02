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

  def get_row_possibilities(row_index)
    values = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    row = (0..8).map { |n| @grid[row_index][n] }.flatten
    values - row
  end

  def get_column_possibilities(column_index)
    values = ['1', '2', '3', '4', '5', '6', '7', '8', '9']
    column = (0..8).map { |n| @grid[n][column_index] }
    values - column
  end

end
