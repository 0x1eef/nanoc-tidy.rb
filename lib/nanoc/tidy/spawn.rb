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
    # @param [String] err
    #  A path where stderr is redirected to
    #
    # @param [String] out
    #  A path where stdout is redirected to
    #
    # @return [void]
    def spawn(exe, argv, err:, out:)
      id = SecureRandom.hex
      err = "#{err}+#{id}"
      out = "#{out}+#{id}"
      Kernel.spawn(
        exe, *argv, { STDERR => err, STDOUT => out }
      )
      Process.wait
      status = $?
      ##
      # exit codes
      #  * 0: no warnings, no errors
      #  * 1: has warnings
      #  * 2: has errors
      return if [0, 1].include?(status.exitstatus)

      msgs = [err, out].map do
        FileUtils.touch(_1)
        [_1.gsub(Dir.getwd, ''), ":", "\n", File.binread(_1)].join
      end.join("\n")
      raise Error,
            "#{File.basename(exe)} exited unsuccessfully " \
            "(" \
            "exit code: #{status.exitstatus}, " \
            "item: #{item.identifier}" \
            ")" \
            "\n#{msgs}",
            []
    ensure
      [err, out]
        .select { File.exist?(_1) }
        .each { FileUtils.rm(_1) }
    end
  end
end
