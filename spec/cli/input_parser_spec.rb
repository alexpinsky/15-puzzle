require_relative '../spec_helper'
require 'apps/cli/input_parser'
require 'apps/cli/errors'
require "lib/fifteen_puzzle"

RSpec.describe CLI::InputParser do
  subject { CLI::InputParser.new input: input }

  let(:input) { double(getch: key) }

  describe "parse_move" do

    context "when arrow-key is pressed" do
      let(:key) { "\e[A" }

      it "should return the proper move" do
        expect(subject.parse_move).to eq FifteenPuzzle::MOVES[:up]
      end
    end

    context "when 'quit' option is pressed" do
      let(:key) { "q" }

      it "should raise exit exception" do
        expect { subject.parse_move }.to raise_error CLI::ExitGame
      end
    end

    context "when an invalid option is pressed" do
      let(:key) { "x" }

      it "should raise invalid input exception" do
        expect { subject.parse_move }.to raise_error CLI::InvalidInput
      end
    end
  end
end