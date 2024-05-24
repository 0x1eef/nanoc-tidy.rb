# frozen_string_literal: true

module Nanoc::Tidy
  module Spawn
    require "securerandom"
    require "fileutils"
    Error = Class.new(RuntimeError)

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
    def spawn(exe, argv, workdir: File.join(Dir.getwd, "tmp"))
      logfile = File.join(workdir, ".#{Process.pid}.tidy")
      Kernel.spawn(exe, *argv, {$stderr => logfile, $stdout => logfile})
      Process.wait
      status = $?
      ##
      # exit codes
      #  * 0: no warnings, no errors
      #  * 1: has warnings
      #  * 2: has errors
      if [0, 1].include?(status.exitstatus)
        status.exitstatus
      else
        raise Error,
              "#{File.basename(exe)} exited unsuccessfully\n" \
              "(item: #{item.identifier})\n" \
              "(exit code: #{status.exitstatus})\n" \
              "output:\n#{File.binread(logfile)}\n",
              []
      end
    ensure
      FileUtils.rm(logfile)
    end
  end
end
