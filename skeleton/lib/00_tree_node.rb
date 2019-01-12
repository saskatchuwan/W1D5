require "byebug"

class PolyTreeNode
  attr_accessor :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    #remove new child (self) from the old parent's list of children if old parent isn't nil
    @parent.children.reject!{|child| child==self} unless @parent.nil?

    #re-assign parent attribute of new child (self) to the node being passed in 
    @parent = node

    unless @parent.nil? 
    #Add new child (self) to new parent's (node) array of children
      node.children << self 
    end
  end

  def add_child(child_node)
    child_node.parent=(self)
  end

  def remove_child(child_node)
    raise Error if child_node.parent == nil
    child_node.parent=(nil)
  end

  def dfs(target_value)
    return self if @value == target_value

    @children.each do |child_node|
      search_result = child_node.dfs(target_value)
      return search_result unless search_result == nil
      
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    until queue.empty?
      el = queue.shift
      return el if el.value == target_value
      @children.each do |child_node|
        queue << child_node
      end
    end

    nil
  end


end