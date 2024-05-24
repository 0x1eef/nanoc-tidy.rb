# frozen_string_literal: true

require_relative "setup"

class FilterTest < Test::Unit::TestCase
  def test_default_options
    options = {argv: ["--tidy-mark", "false"]}
    assert_equal read_result("default_options.html"),
                 filter_for("fixture.html").run(html, options)
  end

  def test_upper_option
    options = {argv: ["-upper", "--tidy-mark", "false"]}
    assert_equal read_result("upper_option.html"),
                 filter_for("fixture.html").run(html, options)
  end

  private

  def filter_for(basename)
    @filter ||= begin
      filter = Nanoc::Tidy::Filter.new
      filter.extend module_for(basename)
    end
  end

  def module_for(basename)
    Module.new do
      define_method(:item) do
        OpenStruct.new(identifier: basename)
      end
    end
  end

  def read_result(basename)
    File.binread File.join("test", "results", basename)
  end

  def html
    File.binread "./test/fixtures/fixture.html"
  end
end
