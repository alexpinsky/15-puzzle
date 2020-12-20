module FifteenPuzzle
  class OutOfRangeMove < StandardError
    def initialize(move)
      super "You can't move #{move.name}, it's our of range"
    end
  end

  class RandomizationError < StandardError
    def initialize
      super "Can't randomize an unordered board"
    end
  end
end