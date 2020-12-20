# frozen_string_literal: true

require "securerandom"
require_relative "./board"

module FifteenPuzzle
  class Game
    attr_reader :id

    def initialize(repo:, id: nil)
      @repo = repo

      if id
        @id = id
        load_game
      else
        @id = SecureRandom.hex(4)
        @board = Board.new.randomize
        @steps = 0
      end
    end

    def make_move(move)
      @board.make_move move
      repo.save_board id, board
      @steps += 1
      repo.save_steps id, steps
    end

    def won?
      @board.ordered?
    end

    def board
      @board.to_a
    end

    def steps
      @steps
    end

    private

    attr_reader :repo

    def load_game
      @board = repo.get_board(id)
      @steps = repo.get_steps(id)
    end
  end
end