# frozen_string_literal: true

module FifteenPuzzle
  Index = Struct.new(:x, :y)
  Move = Struct.new(:name, :x, :y)

  BOARD_SIZE = 4.freeze
  BOARD_RANGE = 0...BOARD_SIZE.freeze
  ORDERED_BOARD = [*0...BOARD_SIZE * BOARD_SIZE].rotate.each_slice(BOARD_SIZE).to_a.freeze
  EMPTY_VAL = 0.freeze

  MOVES = {
    up: Move.new('up', -1, 0),
    down: Move.new('down', 1, 0),
    left: Move.new('left', 0, -1),
    right: Move.new('right', 0, 1),
  }
  .freeze
end