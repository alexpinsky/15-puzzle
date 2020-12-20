require_relative '../spec_helper'
require 'lib/fifteen_puzzle/game'

RSpec.describe FifteenPuzzle::Game do
  subject { FifteenPuzzle::Game.new repo: repo, id: id }

  let(:id) { nil }
  let(:steps) { 20 }
  let(:board) do
    [
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
      [13, 14, 0, 15]
    ]
  end

  let(:repo) do
    dbl = double

    allow(dbl).to receive(:get_board) do |_id|
      _id == id ? FifteenPuzzle::Board.new(board: board) : nil
    end

    allow(dbl).to receive(:get_steps) do |_id|
      _id == id ? steps : nil
    end

    dbl
  end

  describe "initialize" do

    context "when id is provided (load a game)" do
      let(:id) { '12345' }

      it "should load from the repo" do
        expect(subject.id).to eq id
        expect(subject.board).to eq board
        expect(subject.steps).to eq steps
      end
    end

    context "when id is NOT provided" do

      it "should setup a new game" do
        expect(subject.id).to_not be_empty
        expect(subject.board).to_not be_empty
        expect(subject.steps).to eq 0
      end
    end
  end

  describe "make_move" do
    let(:id) { '12345' }

    it "should trigger the move changes and persist the result" do
      expect(repo).to receive(:save_board)
      expect(repo).to receive(:save_steps)

      subject.make_move FifteenPuzzle::MOVES[:right]

      expect(subject.board).to eq FifteenPuzzle::ORDERED_BOARD
      expect(subject.won?).to be true
      expect(subject.steps).to eq steps + 1
    end
  end
end