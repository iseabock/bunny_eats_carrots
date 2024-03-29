# frozen_string_literal: true

require_relative '../garden.rb'
require 'test/unit'

# garden.rb
class TestGarden < Test::Unit::TestCase
  def test_garden_valid?
    # A valid garden has rows that are all the same length
    # no cells of equal value neighboring eachother
    valid_garden_arr = [[5, 7, 8, 6, 3],
                        [0, 0, 7, 0, 4],
                        [4, 6, 3, 4, 9],
                        [3, 1, 0, 5, 8]]

    garden = Garden.new(valid_garden_arr)
    assert_equal(valid_garden_arr, garden.layout)

    # Not valid because one row is longer than the rest
    invalid_garden_arr = [[5, 7, 8, 6, 3],
                          [0, 0, 5, 0, 4],
                          [4, 6, 5, 4, 9, 9],
                          [3, 1, 0, 5, 8]]

    assert_raises 'Sorry, invalid garden layout provided.' do
      Garden.new(invalid_garden_arr)
    end

    # Not valid because the two cells at [1][2], are
    # equal to the cells at [2][2]
    invalid_garden_arr2 = [[5, 7, 8, 6, 3],
                           [0, 0, 5, 0, 4],
                           [4, 6, 5, 4, 9],
                           [3, 1, 0, 5, 8]]

    assert_raises 'Sorry, invalid garden layout provided.' do
      Garden.new(invalid_garden_arr2)
    end
  end

  def test_center
    # When there is an odd number of rows, we pick the middle
    # element of the middle array
    garden_arr1 = [[5, 7, 8, 6, 3],
                   [0, 0, 7, 0, 4],
                   [0, 0, 4, 0, 0],
                   [4, 6, 3, 4, 9],
                   [3, 1, 0, 5, 8]]

    garden = Garden.new(garden_arr1)
    assert_equal([2, 2], garden.center)

    # When there is an even number of rows with an odd number of
    # elements, we have to choose the greatest value in the two
    # "center" cells
    garden_arr2 = [[5, 7, 8, 6, 3],
                   [0, 0, 7, 0, 4],
                   [4, 6, 3, 4, 9],
                   [3, 1, 0, 5, 8]]

    garden = Garden.new(garden_arr2)
    assert_equal([1, 2], garden.center)

    # When there is an odd number of rows with an even number of
    # elements, we have to choose the greatest value in the two
    # "center" cells
    garden_arr3 = [[5, 7, 8, 3],
                   [0, 0, 7, 4],
                   [0, 6, 5, 0],
                   [0, 0, 7, 0],
                   [3, 1, 0, 8]]

    garden = Garden.new(garden_arr3)
    assert_equal([2, 1], garden.center)

    # When there is an even number of rows and even number of
    # elements, we have to choose the greatest value in the
    # four "center" cells
    garden_arr4 = [[5, 7, 8, 3],
                   [0, 0, 7, 4],
                   [0, 0, 5, 0],
                   [0, 0, 7, 0],
                   [4, 6, 3, 9],
                   [3, 1, 0, 8]]

    garden = Garden.new(garden_arr4)
    assert_equal([3, 2], garden.center)
  end
end
