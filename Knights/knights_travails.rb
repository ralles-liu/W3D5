require_relative "../skeleton 2/lib/00_tree_node"

class KnightPathFinder

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)

        # these are the locations we've visted
        @considered_pos = [pos]
        self.build_move_tree
    end


    def build_move_tree
        # this will build the moves of our knight 
        
        # each child of the root node is one of the considered "next" position 
        # for each node, there can be up to 8 children
        # we're just building the nodes and connecting them, not DOING anything
        
        queue = [@root_node]

        while !queue.empty?
            first = queue.shift
            # now we work with first, which is a node (in the beginning it is our root node

            # we start with the root node
            # we need to figure out who its children are
            children_locations = new_move_positions(first.value)
            # so now we have a list of all the locations
            # we need to turn all these locations into children (aka instances of nodes)
            children_locations.each do |pos|
                child = PolyTreeNode.new(pos)
                # now we are individually creating each child
                first.add_child(child)
                queue.push(child) # this only runs when children_locations doesn't have array anymore.
            end
        end
        # so now we have all the children created and all the initial lines connecting them done
        # so clearly we need some iteration cuz we're gonna be doing this a lot
       
    end

    def new_move_positions(pos)
        # we are at position 0,0 -> where can our knight go?
        # calling valid_moves gives us ALL the places knight can go from 0,0
        # but some of these places, we dont care about because we've already visited
        moves = KnightPathFinder.valid_moves(pos)
        correct_moves = []
        moves.each do |move|
            if !@considered_pos.include?(move)
                @considered_pos << move
                correct_moves << move
            end
        end    
        
        return correct_moves

    end

    def self.valid_moves(pos)
        # here we need to return all potential positions 
        directions = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, -1], [-2, 1], [-1, -2], [-1, 2]]
        moves = []
        row = pos[0]
        col = pos[1]
        directions.each do |dir|
            new_row = row + dir[0]
            new_col = col + dir[1]
            if !(new_row < 0 || new_col < 0 || new_row > 7 || new_col > 7)
                moves << [new_row, new_col]
            end
        end
        return moves
    end


    # we need 

    def find_path(pos)
        target_node = @root_node.bfs(pos)
        path = [target_node.value]

        # array.unshift(value)
        while target_node.parent != nil
            path.unshift(target_node.parent.value)
            target_node = target_node.parent
        end
        path
    end

    # def path_print
    #     # this is going to print our tree in a more readable format
    #     # @root_node is the start of our tree
    #     queue = [@root_node]

    #     while !queue.empty?
    #         first = queue.shift
    #         first.children.each do |child|
    #             print child.value
    #             print "  "
    #             queue << child
    #         end

    #         if first.children != []
    #             puts
    #         end

    #         # puts
    #     end

    # end



    #   0 1 2 3 4 5 6 7 
    # 0 X
    # 1     O 
    # 2   O
    # 3
    # 4       X
    # 5           O
    # 6
    # 7
end

kpf = KnightPathFinder.new([0, 0])

p kpf.find_path([2, 1]) # => [[0, 0], [2, 1]]
p kpf.find_path([3, 3]) # => [[0, 0], [2, 1], [3, 3]]