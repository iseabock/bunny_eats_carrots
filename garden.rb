# frozen_string_literal: true

# Garden class initializes valid a garden, and finds the center
# element with the greatest number of carrots
class Garden
  attr_reader :layout, :original_layout

  def initialize(garden)
    @layout = garden
    @original_layout = clone_garden(garden) # Store original for final display
    valid?(garden)
    system 'clear' # Clear terminal for fresh garden
  end

  def center
    row = @layout.length / 2
    el  = @layout[row].length / 2

    # Find greatest number of carrots when there are 4 center cells
    # Find the greatest number when there are 2 center cells
    # Or when there are an odd number of row, and elements
    if @layout.length.even? && @layout[row].length.even?
      possible_center = find_four_center_elements(row, el)
      max = possible_center.max_by { |_k, v| v }
      center_el = [max[0][0], max[0][1]]
    elsif @layout.length.even? && @layout[row].length.odd?
      center_el = @layout[row][el] > @layout[row - 1][el] ? [row, el] : [row - 1, el]
    elsif @layout.length.odd? && @layout[row].length.even?
      center_el = @layout[row][el] > @layout[row][el - 1] ? [row, el] : [row, el - 1]
    else
      center_el = [row, el]
    end

    center_el
  end

  def find_four_center_elements(row, el)
    possible_center = {}
    possible_center[[row, el]]         = @layout[row][el]
    possible_center[[row - 1, el]]     = @layout[row - 1][el]
    possible_center[[row, el - 1]]     = @layout[row][el - 1]
    possible_center[[row - 1, el - 1]] = @layout[row - 1][el - 1]
    possible_center
  end

  def self.print_garden(garden)
    garden.each do |row|
      puts row.inspect
    end
    puts
    print_cute_garden(garden)
    garden
  end

  def self.print_cute_garden(garden, bunny = nil)
    garden.each_with_index do |row, row_index|
      row.each_with_index do |el, el_index|
        if !bunny.nil? && bunny == [row_index, el_index]
          print " \u{1F430} " # Bunny emoji
        else
          print el.zero? ? " \u{1F331} " : " \u{1F955} " # Carrot or sprout emoji
        end
      end
      puts
    end
    puts
  end

  def self.animate_garden(garden, row_el, carrots_eaten, carrots)
    print_cute_garden(garden, [row_el[0], row_el[1]])
    puts "#{carrots} \u{1F955}  in this patch!"
    puts "\u{1F430}  has eaten #{carrots_eaten} #{carrots_eaten == 1 ? 'carrot' : 'carrots'}!"
    sleep(1)
    system 'clear'
  end

  private

  # valid? checks that the all rows are the same length, and that
  # no neighboring cells are the same value.
  def valid?(garden)
    row_length = garden.first.length

    begin
      layout.each_with_index do |row, row_index|
        raise 'invalid garden layout' unless row.length == row_length

        row.each_with_index do |_element, element_index|
          if element_has_equal_value_neighbors?(row_index, element_index)
            raise 'invalid garden layout'
          end
        end
      end
    rescue StandardError => e
      puts "Sorry, #{e} provided."
      exit
    end
  end

  def element_has_equal_value_neighbors?(row_index, el_index)
    el_value = @layout[row_index][el_index]

    # If neighboring element is zero we don't care
    return false if el_value.zero?

    # First confirm we are not at the border of the garden.
    # Then check that the patch N, E, W, and S of us is not
    # equal to the current patch
    if !@layout[row_index - 1].nil? && @layout[row_index - 1][el_index] == el_value
      true
    elsif !@layout[row_index + 1].nil? && @layout[row_index + 1][el_index] == el_value
      true
    elsif !@layout[el_index + 1].nil? && @layout[row_index][el_index - 1] == el_value
      true
    elsif !@layout[el_index - 1].nil? && @layout[row_index][el_index + 1] == el_value
      true
    else
      false
    end
  end

  # Needed a deep clone instead of .dup, .clone
  def clone_garden(garden)
    Marshal.load(Marshal.dump(garden)).freeze
  end
end
