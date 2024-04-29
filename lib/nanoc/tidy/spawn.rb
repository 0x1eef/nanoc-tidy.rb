module Nanoc::Tidy
  module Spawn
    Error = Class.new(RuntimeError)
    def spawn(exe, argv, log:)
      Kernel.spawn(
        exe, *argv, { STDOUT => log, STDERR => log }
      )
      Process.wait
      status = $?
      ##
      # exit codes
      #  * 0: no warnings, no errors
      #  * 1: has warnings
      #  * 2: has errors
      return if [0, 1].include?(status.exitstatus)

      raise Error,
            "#{File.basename(exe)} exited unsuccessfully " \
            "(" \
            "exit code: #{status.exitstatus}, " \
            "item: #{item.identifier}" \
            ")" \
            "\n" \
            "#{log.gsub(Dir.getwd, '')[1..]}:" \
            "#{File.binread(log)}" \
            []
    end
  end
end
