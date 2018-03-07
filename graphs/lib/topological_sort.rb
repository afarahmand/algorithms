require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

# Kahn's algorithm
def topological_sort(vertices)
  queue = []
  list = []
  new_to_list = []

  vertices.each do |vertex|
    queue.push(vertex) if vertex.in_edges.length == 0
  end

  while queue.length > 0
    new_to_list = [].concat(queue)

    while !queue.empty?
      vertex = queue.pop
    end

    # Add neighbors of removed wo in edges
    new_to_list.each do |vertex|
      vertex.out_edges.each do |edge|
        if edge.to_vertex.in_edges.length == 1
          queue << edge.to_vertex
        end
        edge.destroy!
      end
    end

    # Add new_to_list to list
    list = list.concat(new_to_list)
    new_to_list = []
  end

  if vertices.length == list.length
    return list
  else
    return []
  end
end
