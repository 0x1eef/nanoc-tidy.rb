# frozen_string_literal: true

module Nanoc::Tidy
  class Filter < Nanoc::Filter
    require "fileutils"
    require_relative "spawn"
    include Spawn
    include FileUtils

    identifier :tidy
    type text: :text

    ##
    # The default argv for tidy-html5
    #
    # @example
    #   Nanoc::Tidy.default_argv.concat ["-upper"]
    #
    # @return [Array<String>]
    #  Default argv for tidy-html5
    def self.default_argv
      @default_argv ||= ["-wrap", "120", "-indent"]
    end

    ##
    # Runs the filter
    #
    # @param [String] content
    #  HTML content
    #
    # @param [Hash] options
    #  Filter options
    #
    # @return [String]
    #  Returns HTML content (modified)
    def run(content, options = {})
      file = temporary_file(
        File.basename(item.identifier.to_s),
        content
      )
      spawn options[:exe] || "tidy5",
            [*default_argv, *(options[:argv] || []), "-modify", file.path]
      File.read(file.path)
    ensure
      file ? file.tap(&:unlink).close : nil
    end

    private

    def default_argv
      self.class.default_argv
    end

    def temporary_file(basename, content)
      tmpdir = File.join(Dir.getwd, "tmp", "tidy")
      name = item.identifier.to_s
      file = Tempfile.new(
        [ File.basename(name), File.extname(name) ],
        mkdir_p(tmpdir).last
      )
      file.write(content)
      file.tap(&:flush)
    end
  end
end
