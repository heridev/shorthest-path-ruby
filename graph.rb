# encoding: UTF-8
require 'pry'
require_relative 'vertex'
# this class is responsible to calculate the shorthest path
class Graph

  attr_reader :vertices

  def initialize(graph)
    @vertices = Hash.new { |h, k| h[k] = Vertex.new(k, [], Float::INFINITY) }
    @edges = {}
    format_graph_values graph
    @dijkstra_source = nil
  end

  def dijkstra(source)
    vertex_values = @vertices.values
    @vertices[source].dist = 0

    until vertex_values.empty?
      get_vertices_distances vertex_values
      vertices_dist = vertex_values.min_by { |vertex| vertex.dist }
      break if vertices_dist.dist == Float::INFINITY
      vertex_values.delete(vertices_dist)
    end

    @dijkstra_source = source
  end

  def shortest_path(start, finish)
    dijkstra(start) unless @dijkstra_source == start
    path = []
    u = finish
    while u
      path.unshift(u)
      u = @vertices[u].prev
    end
    [path, @vertices[finish].dist]
  end

  private

  def get_vertices_distances(vertex_values)
    vertices_dist = vertex_values.min_by { |vertex| vertex.dist }
    vertices_dist.neighbours.each do |v|
      vv = @vertices[v]
      alt = vertices_dist.dist + @edges[[vertices_dist.name, v]]
      if vertex_values.include?(vv) && alt < vv.dist
        vv.dist = alt
        vv.prev = vertices_dist.name
      end
    end
  end

  def format_graph_values(graph)
    graph.each do |(v1, v2, dist)|
      @vertices[v1].neighbours << v2
      @vertices[v2].neighbours << v1
      @edges[[v1, v2]] = @edges[[v2, v1]] = dist
    end
  end
end
