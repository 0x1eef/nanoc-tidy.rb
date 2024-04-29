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
    # @example
    #   Nanoc::Tidy.default_argv.concat ["-upper"]
    #
    # @return [Array<String>]
    #  The default argv for tidy-html5
    def self.default_argv
      @default_argv ||= ["-wrap", "120", "-indent"]
    end

    def run(content, options = {})
      path = temporary_file(content).path
      spawn tidy,
            [*default_argv, *(options[:argv] || []), "-modify", path],
            log: File.join(tmpdir, "tidy-html5.log")
      File.read(path).tap { rm(path) }
    end

    private

    def default_argv
      self.class.default_argv
    end

    def temporary_file(content)
      mkdir_p(tmpdir)
      file = Tempfile.new(File.basename(item.identifier.to_s), tmpdir)
      file.write(content)
      file.tap(&:flush)
    end

    def tidy
      case
      when system("which tidy > /dev/null 2>&1") then "tidy"
      when system("which tidy5 > /dev/null 2>&1") then "tidy5"
      else nil
      end
    end

    def tmpdir
      File.join(Dir.getwd, "tmp", "tidy-html5")
    end
  end
end
