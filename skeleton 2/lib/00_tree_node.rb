class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent_node)
        @parent.children.delete(self) if @parent != nil 

        @parent = parent_node
        if @parent != nil && !(@parent.children.include?(self))
            @parent.children << self
            #p @parent.children
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise "not my child!!" if !self.children.include?(child)
        child.parent = nil
    end

    def dfs(target)
        if self.value == target
            return self
        else
            self.children.each do |child|
                answer = child.dfs(target)
                return answer if answer != nil
            end
        end
        nil
    end

    def bfs(target)
        queue = [self]
        while !queue.empty?
            # everything in here will repeat until our queue is empty 
            first = queue.shift
            # p first.value
            # for now queue = []

            if first.value == target
                return first
            else
                first.children.each do |child|
                    queue.push(child)
                end
            end
        end
        nil
    end
end


#     a 
#    / \
#   b   c
#  / \   \
# d   e   f

# queue = [a]
# queue = []
# queue = [b, c]
# queue = [c, d, e]

#   we are looking for c
#   dfs(a)
#   for each of b and c
#     dfs(b) -> nil