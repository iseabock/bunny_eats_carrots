# frozen_string_literal: true

class Garden
  attr_reader :layout

  def initialize(garden, cute=true)
    @layout = garden
    @cute = cute

    begin
      raise 'invalid garden layout' unless valid?(garden)
    rescue StandardError => e
      puts "Sorry, #{e} provided."
      exit
    end

    print_garden
  end

  # valid? checks that the all rows are the same length, and that
  # no neighboring cells are the same value.
  def valid?(garden)
    row_length = garden.first.length
    valid = true

    layout.each_with_index do |row, row_index|
      return false unless row.length == row_length

      row.each_with_index do |_element, element_index|
        if element_has_equal_value_neighbors?(garden, row_index, element_index)
          valid = false
          break
        end
        break unless valid
      end
    end
    valid
  end

  def element_has_equal_value_neighbors?(layout, row_index, el_index)
    el_value = layout[row_index][el_index]

    # If neighboring element is zero we don't care
    return false if el_value.zero?

    # First confirm we are not at the border of the garden.
    # Then check that the patch N, E, W, and S of us is not
    # equal to the current patch
    if !layout[row_index - 1].nil? && layout[row_index - 1][el_index] == el_value
      true
    elsif !layout[row_index + 1].nil? && layout[row_index + 1][el_index] == el_value
      true
    elsif !layout[el_index - 1].nil? && layout[row_index][el_index - 1] == el_value
      true
    elsif !layout[el_index - 1].nil? && layout[row_index][el_index + 1] == el_value
      true
    else
      false
    end
  end

  def center
    row = @layout.length / 2
    el  = @layout[row].length / 2

    # Find greatest number of carrots when there are 4 center cells
    # Find the greatest number when there are 2 center cells
    # Or when there are an odd number of row, and elements
    if @layout.length.even? && @layout[row].length.even?
      possible_center = {}
      possible_center[[row, el]]         = @layout[row][el]
      possible_center[[row - 1, el]]     = @layout[row - 1][el]
      possible_center[[row, el - 1]]     = @layout[row][el - 1]
      possible_center[[row - 1, el - 1]] = @layout[row - 1][el - 1]

      max = possible_center.max_by { |_k, v| v }
      center_el = [max[0][0], max[0][1]]
    elsif @layout.length.even? && @layout[row].length.odd?
      center_el = @layout[row][el] > @layout[row - 1][el] ? [row, el] : [row - 1, el]
    else
      center_el = [row, el]
    end

    center_el
  end

  def print_garden
    @layout.each do |row|
      puts row.inspect
    end
    puts
    print_cute_garden if @cute
    @layout
  end

  def print_cute_garden
    @layout.each do |row|
      row.each do |el|
        print el.zero? ? " \u{1F331}} " : " \u{1F955}} "
      end
      puts
    end
    puts
  end
end
