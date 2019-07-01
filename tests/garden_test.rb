# frozen_string_literal: true

require_relative '../garden.rb'
require 'test/unit'

# garden.rb
class TestGarden < Test::Unit::TestCase
  def test_garden_valid?
    valid_garden_arr = [[5, 7, 8, 6, 3],
                        [0, 0, 7, 0, 4],
                        [4, 6, 3, 4, 9],
                        [3, 1, 0, 5, 8]]

    garden = Garden.new(valid_garden_arr)
    assert_equal(valid_garden_arr, garden.layout)

    invalid_garden_arr = [[5, 7, 8, 6, 3],
                          [0, 0, 5, 0, 4],
                          [4, 6, 5, 4, 9, 9],
                          [3, 1, 0, 5, 8]]

    assert_raises 'Sorry, invalid garden layout provided.' do
      Garden.new(invalid_garden_arr)
    end

    invalid_garden_arr2 = [[5, 7, 8, 6, 3],
                           [0, 0, 5, 0, 4],
                           [4, 6, 5, 4, 9],
                           [3, 1, 0, 5, 8]]

    assert_raises 'Sorry, invalid garden layout provided.' do
      Garden.new(invalid_garden_arr)
    end
  end
end
