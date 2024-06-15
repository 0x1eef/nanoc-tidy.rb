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
    # @return [Integer]
    #  Returns the exit code of the spawned process
    def spawn(exe, argv)
      r = cmd(exe, *argv)
      ##
      # tidy-html5 exit codes
      #  * 0: no warnings, no errors
      #  * 1: has warnings
      #  * 2: has errors
      if r.exit_status == 1
        if r.stderr =~ /No such file or directory/
          raise Nanoc::Tidy::Error, "The #{exe} executable was not found"
        else
          r.exit_status
        end
      elsif r.exit_status == 0
        r.exit_status
      else
        raise Nanoc::Tidy::Error,
              "#{File.basename(exe)} exited unsuccessfully\n" \
              "(item: #{item.identifier})\n" \
              "(exit code: #{r.exit_status})\n" \
              "(stdout: #{r.stdout&.chomp})\n" \
              "(stderr: #{r.stderr&.chomp})\n",
              []
      end
    end
  end
end
