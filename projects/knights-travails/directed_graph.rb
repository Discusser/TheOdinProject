class DirectedGraph
  INFINITY = 100_000_000_000

  def initialize(vertices, adjacency_list)
    @vertices = vertices
    @adjacency_list = adjacency_list
  end

  def bfs_traversal(starting_position, destination)
    distances = Hash.new(INFINITY)
    parents = Hash.new(nil)
    enqueued = [starting_position]

    until enqueued.empty?
      current = enqueued.shift
      # Return early, because we know that the first path we find with BFS is one of the shortest paths
      break if current == destination

      @adjacency_list[current].each do |neighbor|
        # If the neighbor is not visited yet
        next unless distances[neighbor] == INFINITY

        parents[neighbor] = current
        # This line marks the neighbor as visited
        distances[neighbor] = distances[current] + 1
        enqueued << neighbor
      end
    end

    parents
  end

  def find_shortest_path(starting_position, destination)
    parents = bfs_traversal(starting_position, destination)
    path = []
    current = destination

    loop do
      path << current
      break if current == starting_position

      current = parents[current]
    end

    path.reverse
  end
end
