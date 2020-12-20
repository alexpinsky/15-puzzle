# frozen_string_literal: true

require_relative "./base"

module CLI
  module Views
    class Win < Base

      def render(props = {})
        clear
        out.puts "Congratulations, you have won!".yellow
      end
    end
  end
end