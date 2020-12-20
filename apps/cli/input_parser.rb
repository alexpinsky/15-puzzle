# frozen_string_literal: true

require 'io/console'
require "lib/fifteen_puzzle"
require_relative './errors'

module CLI
  class InputParser

    def initialize(input: STDIN)
      @input = input
    end

    def parse_move
      case key = key_in
      when "\e[A" then FifteenPuzzle::MOVES[:up]
      when "\e[B" then FifteenPuzzle::MOVES[:down]
      when "\e[C" then FifteenPuzzle::MOVES[:right]
      when "\e[D" then FifteenPuzzle::MOVES[:left]
      when "q","\u0003","\u0004"
        raise CLI::ExitGame.new
      else
        raise CLI::InvalidInput.new(key)
      end
    end

    private

    attr_reader :input

    def key_in
      key = input.getch
      if key == "\e"
        2.times { key << input.getch }
      end
      key
    end
  end
end