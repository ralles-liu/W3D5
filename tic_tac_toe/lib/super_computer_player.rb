require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer

  def move(game, mark)
    my_node = TicTacToeNode.new(game.board, mark)
    #next_move_marker is the computer
    #my_move.prev = humans move except the first time 

    #my_node.children creates all the child nodes that stem from potential "mark" moves
    my_node.children.each do |child|
      # in child, human is the next player, and prev_move is what the computer just moved
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end
    # the computer tests its moves, and if that move results in a winning_node? it returns the move it just tested
    # each child is a move that the computer is testing 
    # if that child state is winning, that means the computer wants to reach that state
    # what was child's previous move that allowed it to get there

    my_node.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise "there are no non-losing nodes"


  end

  
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
