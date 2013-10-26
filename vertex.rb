# encoding: UTF-8
# class reponsible for vertices
class Vertex
  attr_accessor :name, :neighbours, :dist, :prev

  def initialize(name, neighbours, dist, prev = nil)
    @name = name
    @neighbours = neighbours
    @dist = dist
    @prev = prev
  end
end
