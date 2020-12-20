require_relative '../spec_helper'
require 'lib/fifteen_puzzle'
require 'lib/fifteen_puzzle/errors'
require 'lib/fifteen_puzzle/board'

RSpec.describe FifteenPuzzle::Board do
  subject { FifteenPuzzle::Board.new board: board }

  let(:board) { nil }
  let(:pre_defined_board) do
    [
      [1, 2, 3, 0],
      [5, 6, 7, 8],
      [9, 10, 11, 12],
      [13, 14, 15, 4]
    ]
  end

  describe "initialize" do

    context "when a board is provided" do
      let(:board) { pre_defined_board }

      it "should set the given board and the current index" do
        expect(subject.to_a).to eq board
        expect(subject.current_index).to eq FifteenPuzzle::Index.new(0, 3)
      end
    end

    context "when a board is NOT provided" do

      it "should initialize an ordered board default index" do
        expect(subject.to_a).to eq FifteenPuzzle::ORDERED_BOARD
        expect(subject.current_index).to eq FifteenPuzzle::Index.new(3, 3)
      end
    end
  end

  describe "randomize" do

    context "when the board is ordered (initial state)" do

      it "should randomize the numbers" do
        subject.randomize
        expect(subject.to_a).to_not eq FifteenPuzzle::ORDERED_BOARD
        expect(subject.to_a.flatten).to include(0..15)
      end
    end

    context "when the board isn't ordered" do
      let(:board) { pre_defined_board }

      it "should raise an error" do
        expect { subject.randomize }.to raise_error FifteenPuzzle::RandomizationError
      end
    end
  end

  describe "make_move" do
    let(:board) { pre_defined_board }

    context "when move is out of range" do
      let(:move) { FifteenPuzzle::MOVES[:right] }

      it "should raise an error" do
        expect { subject.make_move(move) }.to raise_error FifteenPuzzle::OutOfRangeMove
      end
    end

    context "when move is within range" do
      let(:move) { FifteenPuzzle::MOVES[:left] }

      it "should make the move" do
        subject.make_move move
        expect(subject.to_a).to eq(
          [
            [1, 2, 0, 3],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 4]
          ]
        )
      end
    end
  end
end