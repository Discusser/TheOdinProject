ROWS = 8
COLUMNS = ROWS

# The knight do the following moves:
# (x + 1; y - 2), (x - 1; y - 2)
# (x + 1; y + 2), (x - 1; y + 2)
# (x + 2; y - 1), (x + 2; y + 1)
# (x - 2; y - 1), (x - 2; y + 1)

def cell_index(pos)
  pos[0] + (pos[1] * ROWS)
end

def pos_valid?(pos)
  pos[0].between?(0, COLUMNS) && pos[1].between?(0, ROWS)
end

def add_cell_to_adjacency_list(list, pos, pos_to_add)
  return unless pos_valid?(pos) && pos_valid?(pos_to_add)

  list[cell_index(pos)] << cell_index(pos_to_add)
end

def add_moves_to_adjacency_list(list, pos)
  x, y = pos
  [-1, 1].each do |x_sign|
    [-1, 1].each do |y_sign|
      add_cell_to_adjacency_list(list, [x, y], [x + x_sign, y - (2 * y_sign)])
      add_cell_to_adjacency_list(list, [x, y], [x + (2 * x_sign), y - y_sign])
    end
  end
end

def build_adjacency_list
  adjacency_list = Array.new(ROWS * COLUMNS) { [] }

  COLUMNS.times do |j|
    ROWS.times do |i|
      add_moves_to_adjacency_list(adjacency_list, [j, i])
    end
  end

  adjacency_list
end

def knight_moves(_starting_point, _destination)
  # TODO: Implement
  vertices = (0..63).to_a
  adjacency_list = build_adjacency_list
  graph = DirectedGraph.new(vertices, adjacency_list)
end

knight_moves([0, 0], [1, 2])
