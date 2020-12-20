# frozen_string_literal: true

require "lib/fifteen_puzzle/game"
require "persistence/null_store"

require_relative "./input_parser"
require_relative "./renderer"
require_relative "./views/game"
require_relative "./views/win"

module CLI
  class Application

    def initialize(repo:, parser:, renderer:, id: nil)
      @repo = repo
      @parser = parser
      @renderer = renderer
      @game = FifteenPuzzle::Game.new(repo: repo, id: id)
    end

    def start
      renderer.render(Views::Game,
        board: game.board,
        steps: game.steps
      )

      until game.won?
        error = nil

        begin
          move = parser.parse_move
          game.make_move move
        rescue CLI::ExitGame
          exit
        rescue => e
          error = e.message
        end

        renderer.render(Views::Game,
          board: game.board,
          steps: game.steps,
          error: error
        )
      end

      renderer.render Views::Win
    end

    def self.start
      Application.new(
        repo: Persistence::NullStore.new,
        parser: CLI::InputParser.new,
        renderer: CLI::Renderer.new
      )
      .start
    end

    private

    attr_reader :parser, :renderer, :game
  end
end
