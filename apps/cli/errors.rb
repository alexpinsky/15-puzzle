# frozen_string_literal: true

module CLI
  class InvalidInput < StandardError
    def initialize(key)
      super "Invalid input '#{key}' try again"
    end
  end

  class ExitGame < StandardError
  end
end