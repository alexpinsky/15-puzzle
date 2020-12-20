# frozen_string_literal: true

require "lib/fifteen_puzzle"
require_relative "./base"

module CLI
  module Views
    class Game < Base
      WIDTH = (FifteenPuzzle::BOARD_SIZE * FifteenPuzzle::BOARD_SIZE - 1).to_s.size.freeze
      FRAME = ("+" + "-" * (WIDTH + 2)) * FifteenPuzzle::BOARD_SIZE + "+".freeze
      FORM = "| %#{WIDTH}d " * FifteenPuzzle::BOARD_SIZE + "|".freeze

      def render(board:, steps:, error: nil)
        clear
        board.each do |row|
          out.puts FRAME.green
          out.puts (FORM % row).sub(" 0 ", "   ")
        end
        out.puts FRAME.green
        out.puts "Steps: #{steps}".blue

        if error
          out.puts error.red
        else
          out.puts
        end

        out.puts
        out.puts <<~EOS
          Use the arrow-keys on your keyboard to push board in the given direction.
          PRESS q TO QUIT (or Ctrl-C or Ctrl-D)
        EOS
      end
    end
  end
end