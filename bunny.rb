# frozen_string_literal: true

class Bunny
  def initialize(garden)
    @garden = garden
    @carrots_eaten = 0
  end

  # Start eating the garden from the center
  def eat_garden
    lets_eat(@garden.center.first, @garden.center.last)
  end

  # I generally avoid recursion, but this seems like an appropiate time,
  # assuming our garden doesn't get too big. If it did, I'd opt for an
  # iterative solution
  def lets_eat(row, el)
    if row == false
      @garden.print_garden
      puts "\u{1F430}  ate #{@carrots_eaten} #{@carrots_eaten == 1 ? 'carrot' : 'carrots'}!"
    else
      # Add the number of carrots in this patch to the total eaten
      @carrots_eaten += @garden.layout[row][el]
      eat_this_patch(row, el)

      # Find our next patch of carrots to eat
      next_row, next_el = next_position(row, el)

      lets_eat(next_row, next_el)
    end
  end

  # Determine the next position with the greatest number of carrots
  def next_position(row, el)
    last_row = @garden.layout.length - 1
    last_el = @garden.layout.first.length - 1

    potential_moves = {}

    # North of current element
    potential_moves[[row + 1, el]] = @garden.layout[row + 1][el] unless row == last_row
    # South of current element
    potential_moves[[row - 1, el]] = @garden.layout[row - 1][el] unless row.zero?
    # East of current element
    potential_moves[[row, el + 1]] = @garden.layout[row][el + 1] unless el == last_el
    # West of current element
    potential_moves[[row, el - 1]] = @garden.layout[row][el - 1] unless el.zero?

    # If all of the values in potential_moves == 0 bunny has eaten her fill
    # otherwise, she continues to the next patch with the greatest number of carrots
    if potential_moves.values.all?(&:zero?)
      false
    else
      # Find and return the greatest value in the hash of potential moves
      potential_moves.max_by { |_k, v| v }.first
    end
  end

  def eat_this_patch(row, el)
    @garden.layout[row][el] = 0
  end
end
