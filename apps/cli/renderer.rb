# frozen_string_literal: true

module CLI
  class Renderer

    def initialize(out: $stdout)
      @out = out
    end

    def puts(str = "")
      out.puts str
    end

    def render(view_class, props = {})
      view_class.new(out: self).render(props)
    end

    private

    attr_reader :out
  end
end