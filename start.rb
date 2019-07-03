require_relative 'garden.rb'
require_relative 'bunny.rb'

garden_arr = [[5, 9, 8, 6, 3],
              [0, 0, 6, 0, 4],
              [0, 0, 7, 0, 0],
              [0, 0, 5, 0, 0],
              [4, 6, 3, 4, 9],
              [3, 1, 0, 5, 8]]

# garden_arr = [[5, 7, 8, 6, 3],
#               [0, 0, 7, 0, 4],
#               [0, 0, 5, 0, 0],
#               [0, 0, 9, 0, 0],
#               [0, 0, 7, 0, 0],
#               [4, 6, 3, 4, 9],
#               [3, 1, 0, 5, 8]]

# garden_arr = [[5, 7, 8, 3],
#               [0, 0, 7, 4],
#               [0, 0, 5, 0],
#               [0, 0, 7, 0],
#               [4, 6, 3, 9],
#               [3, 1, 0, 8]]

garden = Garden.new(garden_arr)
bunny = Bunny.new(garden)

bunny.eat_garden