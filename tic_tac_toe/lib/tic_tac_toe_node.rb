require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board 
    @next_mover_mark = next_mover_mark 
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over? 
      if @board.winner != evaluator && @board.winner != nil 
        return true 
      else
        return false 
      end
    end
    if @next_mover_mark == evaluator
      #if it's our turn and any move that we make is a losing moves(losing states), then we lose the game
      return self.children.all? {|child| child.losing_node?(evaluator)}
    else
      #assume he plays optimally. if he has any move that forces us to lose, he will play that. 
      return self.children.any? {|child| child.losing_node?(evaluator)}
      #at this child board state, which is the board state where the opponent has just played, if any of the one states is a losing node for us, then we lose because he will play that.
    end
    
  end

  def winning_node?(evaluator)
    if @board.over? 
      if @board.winner == evaluator 
        return true 
      else
        return false 
      end
    end

    if @next_mover_mark == evaluator 
      return self.children.any? {|child| child.winning_node?(evaluator)}
    else
      return self.children.all? {|child| child.winning_node?(evaluator)}
    end

  end

  def switch_mark 
    if @next_mover_mark == :x 
      return :o 
    else
      return :x 
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_nodes = []
    #figure out all potential game states 
    #nested loop to loop through all the positions of the board 
    #at that position, if empty, then potential move and create new node 
    (0...@board.rows.length).each do |row|
      (0...@board.rows.length).each do |col|
        position = [row, col]
        #now we go through each position in the grid
        if @board.empty?(position)
          #if that position if empty, then we create a duplicate of that board and then stick next player's mark
          #into that duplicate and create child node with that and shovel in each time.
          #each time, the dup is set to @board, which is the og board.
          dupped = @board.dup 
          dupped[position] = @next_mover_mark 
          children_nodes << TicTacToeNode.new(dupped, self.switch_mark, position )
        end

      end
    end
    children_nodes
  end
end

# o _ _   _ o _   
# _ x _ 
# _ _ _ 

# board = Board.new
# board[[1,1]] = :x 
# p node = TicTacToeNode.new(board, :o, [1,1])
# p node.children 
