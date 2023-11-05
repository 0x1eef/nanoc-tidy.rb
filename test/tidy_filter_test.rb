require_relative "setup"

class FilterTest < Test::Unit::TestCase
  def test_default_options
    html = File.binread "./test/fixtures/1.html"
    assert_equal filter_for("1.html").run(html, "--tidy-mark" => false),
                 result_for("1.html")
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

  def result_for(basename)
    File.binread File.join("test", "results", basename)
  end
end
