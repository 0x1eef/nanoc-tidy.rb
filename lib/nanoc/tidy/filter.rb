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
      spawn tidy,
            [*default_argv, *(options[:argv] || []), "-modify", file.path]
      File.read(file.path)
    ensure
      file&.unlink
    end

    private

    def default_argv
      self.class.default_argv
    end

    def temporary_file(basename, content)
      tempname = [
        ".nanoc.tidy.#{basename}.#{object_id}",
        SecureRandom.alphanumeric(3)
      ]
      Tempfile.new(tempname).tap do
        _1.write(content)
        _1.flush
      end
    end

    def tidy
      if system("which tidy > /dev/null 2>&1")
        "tidy"
      elsif system("which tidy5 > /dev/null 2>&1")
        "tidy5"
      else
        raise Nanoc::Tidy::Error, "tidy executable not found on $PATH"
      end
    end
  end
end
