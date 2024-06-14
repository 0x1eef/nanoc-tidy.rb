# frozen_string_literal: true

module Nanoc::Tidy
  module Spawn
    require "fileutils"
    require "test-cmd"

    ##
    # Spawns a process
    #
    # @param [String] exe
    #  The path to an executable
    #
    # @param [Array<String>] argv
    #  An array of command line arguments
    #
    # @return [void]
    def spawn(exe, argv)
      r = cmd(exe, *argv)
      ##
      # exit codes
      #  * 0: no warnings, no errors
      #  * 1: has warnings
      #  * 2: has errors
      if [0, 1].include?(r.exit_status)
        r.exit_status
      else
        raise Nanoc::Tidy::Error,
              "#{File.basename(exe)} exited unsuccessfully\n" \
              "(item: #{item.identifier})\n" \
              "(exit code: #{r.exit_status})\n" \
              "(stdout:\n#{r.stdout})\n" \
              "(stderr:\n#{r.stderr})\n",
              []
      end
    end
  end
end
