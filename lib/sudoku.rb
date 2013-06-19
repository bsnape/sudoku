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

  def get_square(original_row, original_column)
    squares = {
        1 => {:row => 0, :column => 0},
        2 => {:row => 0, :column => 3},
        3 => {:row => 0, :column => 6},
        4 => {:row => 3, :column => 0},
        5 => {:row => 3, :column => 3},
        6 => {:row => 3, :column => 6},
        7 => {:row => 6, :column => 0},
        8 => {:row => 6, :column => 3},
        9 => {:row => 6, :column => 6}}

    puts "looking for coordinates: [#{original_row},#{original_column}]"
    squares.each do |square, coords|
      puts "trying square: #{square}..."
      row, column = coords.values
      (column..column+2).each do |c|
        (row..row+2).each do |r|
          puts "current co-ordinates: [#{r},#{c}]"
          return square if "#{original_row}#{original_column}" == "#{r}#{c}"
        end
      end
    end
  end

end
