class Sudoku

  attr_reader :grid, :input

  def initialize
    @input = nil
    @grid = []
  end

  def squares
    {1 => {:row => 0, :column => 0},
     2 => {:row => 0, :column => 3},
     3 => {:row => 0, :column => 6},
     4 => {:row => 3, :column => 0},
     5 => {:row => 3, :column => 3},
     6 => {:row => 3, :column => 6},
     7 => {:row => 6, :column => 0},
     8 => {:row => 6, :column => 3},
     9 => {:row => 6, :column => 6}}
  end

  def values
    %w(1 2 3 4 5 6 7 8 9)
  end

  def read_input(file)
    @input = File.read file
  end

  def parse_input
    @input.each_line do |row|
      @grid << row.strip.split(//)
    end
  end

  def get_row_values(row_index)
    (0..8).map { |n| @grid[row_index][n] }.delete_if { |value| value == '0' }
  end

  def get_column_values(column_index)
    (0..8).map { |n| @grid[n][column_index] }.delete_if { |value| value == '0' }
  end

  def get_square(original_row, original_column)
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

  def get_square_values(original_row, original_column)
    square = get_square(original_row, original_column)

    found_values = []

    row = squares[square].fetch(:row)
    column = squares[square].fetch(:column)

    (column..column+2).each do |c|
      (row..row+2).each do |r|
        current_value = @grid[r][c]
        puts "got value: #{current_value} for co-ordinates: [#{r},#{c}]"
        found_values << current_value unless current_value == '0' || "#{r}#{c}" == "#{original_row}#{original_column}"
      end
    end

    found_values
  end

  def get_possibilities(row, column)
    row_possibilities = get_row_values(row)
    column_possibilities = get_column_values(column)
    square_possibilities = get_square_values(row, column)

    values - (row_possibilities + column_possibilities + square_possibilities)
  end

  def find_move
    candidates = []
    (0..8).each do |row|
      (0..8).each do |column|
        puts "For [#{row}, #{column}] the possibilities are: #{get_possibilities(row, column)}"
        value = get_possibilities(row, column)
        candidates << {value.join.to_i => {:row => row, :column => column}} if value.size == 1
      end
    end

    candidates.each { |hash| hash.each { |k, v| puts "key: #{k}, value: #{v}" } }

    duplicates = Hash.new(0)
    candidates.each { |hash| hash.each_key { |key| duplicates[key] += 1 } }
    duplicates.each { |k, v| puts "#{k} appears #{v} times" }

    key = duplicates.key(1)

    candidates.map { |hash| [hash[key].values_at(:row, :column), key] if hash.has_key?(key) }.compact.flatten
  end

end
