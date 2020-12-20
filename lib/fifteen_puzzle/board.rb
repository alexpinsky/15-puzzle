# frozen_string_literal: true

require "lib/fifteen_puzzle"
require "lib/fifteen_puzzle/errors"

module FifteenPuzzle
  class Board

    def initialize(board: nil)
      if board
        @board = board
        @current_index = find_current_index(board)
      else
        @board = ORDERED_BOARD.map { |row| row.dup }
        @current_index = Index.new(3, 3)
      end
    end

    def randomize
      raise RandomizationError.new unless ordered?

      board[0][0] = EMPTY_VAL
      board[BOARD_SIZE - 1][BOARD_SIZE-1] = 1
      board[BOARD_SIZE - 1][0] = board[0][BOARD_SIZE - 1]
      board[0][BOARD_SIZE - 1] = board[BOARD_SIZE - 1][0]

      x = 0
      y = 0
      dx = 1
      dy = 0

      50.times do
        nx, ny = [
          [x + dx, y + dy],
          [x + dy, y - dx],
          [x - dy, y + dx]
        ]
        .select { |nx, ny| in_range? nx, ny }
        .sample

        board[x][y] = board[nx][ny]
        board[nx][ny] = EMPTY_VAL

        dx = nx - x
        dy = ny - y
        x = nx
        y = ny
      end

      @current_index.x = x
      @current_index.y = y

      self
    end

    def make_move(move)
      new_index = Index.new(@current_index.x + move.x, @current_index.y + move.y)

      if in_range? new_index.x, new_index.y
        board[@current_index.x][@current_index.y] = board[new_index.x][new_index.y]
        board[new_index.x][new_index.y] = EMPTY_VAL
        @current_index.x = new_index.x
        @current_index.y = new_index.y
      else
        raise OutOfRangeMove.new(move)
      end
    end

    def to_a
      board.dup
    end

    def ordered?
      board == ORDERED_BOARD
    end

    def current_index
      @current_index
    end

    private

    attr_reader :board

    def in_range?(x, y)
      BOARD_RANGE.include?(x) && BOARD_RANGE.include?(y)
    end

    def find_current_index(board)
      board.each_with_index do |row, i|
        row.each_with_index do |val, j|
          return Index.new(i, j) if val == EMPTY_VAL
        end
      end
    end
  end
end