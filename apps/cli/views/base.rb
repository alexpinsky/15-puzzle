# frozen_string_literal: true

require 'colorize'

module CLI
  module Views
    class Base

      def initialize(out: $stdout)
        @out = out
      end

      def clear
        out.puts "\e[H\e[2J"
      end

      private

      attr_reader :out
    end
  end
end