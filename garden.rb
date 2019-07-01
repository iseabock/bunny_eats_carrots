# frozen_string_literal: true

class Garden
  attr_reader :layout

  def initialize(garden)
    @layout = garden

    begin
      raise 'invalid garden layout' unless valid?(garden)
    rescue StandardError => e
      puts "Sorry, #{e} provided."
      exit
    end
  end

  def valid?(garden)
    row_length = garden.first.length
    valid = true

    layout.each_with_index do |row, row_index|
      return false unless row.length == row_length

      row.each_with_index do |_element, element_index|
        if element_has_equal_value_neighbors(garden, row_index, element_index)
          valid = false
          break
        end
        break unless valid
      end
    end
    valid
  end

  def element_has_equal_value_neighbors(layout, row_index, el_index)
    el_value = layout[row_index][el_index]

    # If neighboring element is zero we don't care
    return false if el_value.zero?

    # First confirm we are not at the border of the garden.
    # Then check that the patch N, E, W, and S of us is not equal to the current patch
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

end
