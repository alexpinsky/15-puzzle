require_relative '../spec_helper'
require "apps/cli/application"
require "apps/cli/views/game"
require "apps/cli/views/win"
require "lib/fifteen_puzzle"
require "lib/fifteen_puzzle/board"

RSpec.describe CLI::Application do
  subject { CLI::Application.new repo: repo, parser: parser, id: '1234', renderer: renderer }

  let(:repo) { double(get_board: board, get_steps: steps, save_board: true, save_steps: true) }
  let(:parser) { double(parse_move: FifteenPuzzle::MOVES[:right]) }
  let(:renderer) { double }

  let(:steps) { 20 }
  let(:board) do
    FifteenPuzzle::Board.new(board: [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
      [13, 0, 14, 15]
    ])
  end

  describe "start" do
    it "should run 2 steps and then win" do
      call_count = 1
      expect(renderer).to receive(:render) do |view_class, props = {}|
        case call_count
        when 1
          expect(view_class).to eq CLI::Views::Game
          expect(props[:steps]).to eq steps
          expect(props[:board]).to eq board.to_a
        when 2
          expect(view_class).to eq CLI::Views::Game
          expect(props[:steps]).to eq 21
          expect(props[:board]).to eq [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 0, 15]
          ]
        when 3
          expect(view_class).to eq CLI::Views::Game
          expect(props[:steps]).to eq 22
          expect(props[:board]).to eq [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 0]
          ]
        when 4
          expect(view_class).to eq CLI::Views::Win
        end

        call_count += 1
      end.exactly(4).times

      subject.start
    end
  end
end