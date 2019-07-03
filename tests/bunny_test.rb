# frozen_string_literal: true

require_relative '../garden.rb'
require_relative '../bunny.rb'
require 'test/unit'

# bunny.rb
class TestBunny < Test::Unit::TestCase
  def test_next_position
    valid_garden_arr = [[5, 7, 8, 6, 3],
                        [0, 0, 7, 0, 4],
                        [4, 6, 3, 4, 9],
                        [3, 1, 0, 5, 8]]

    garden = Garden.new(valid_garden_arr, false)
    bunny = Bunny.new(garden)

    assert_equal(bunny.next_position(2, 2), [1, 2])
  end

  def test_lets_eat
    valid_garden_arr = [[5, 7, 8, 6, 3],
                        [0, 0, 7, 0, 4],
                        [4, 6, 3, 4, 9],
                        [3, 1, 0, 5, 8]]

    eaten_garden_arr = [[0, 0, 0, 6, 3],
                        [0, 0, 0, 0, 4],
                        [4, 6, 3, 4, 9],
                        [3, 1, 0, 5, 8]]

    garden = Garden.new(valid_garden_arr, false)
    bunny = Bunny.new(garden)

    assert_equal(eaten_garden_arr, bunny.eat_garden)
  end
end
