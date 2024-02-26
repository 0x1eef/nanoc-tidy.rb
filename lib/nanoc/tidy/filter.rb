# frozen_string_literal: true

class Nanoc::Tidy::Filter < Nanoc::Filter
  require "fileutils"
  include FileUtils
  Error = Class.new(RuntimeError)

  identifier :tidy
  type text: :text

  ##
  # @example
  #   Nanoc::Tidy.default_options.merge!(
  #     "-upper" => true
  #   )
  #
  # @return [{"-wrap" => 120, "-indent" => true}]
  #  Returns the default options forwarded as command-line
  #  arguments to tidy-html5.
  def self.default_options
    @default_options ||= {"-wrap" => 120, "-indent" => true}
  end

  def run(content, options = {})
    tidy temporary_file(content),
         self.class.default_options.merge(options)
  end

  private

  def temporary_file(content)
    dir = cwd
    mkdir_p(dir) unless Dir.exist?(dir)
    file = Tempfile.new(File.basename(item.identifier.to_s), dir)
    file.write(content)
    file.tap(&:flush)
  end

  ##
  # tidy executable interface

  def tidy(file, options)
    Process.wait spawn(
      tidy_exe, "-modify", "-quiet", *tidy_args(options), file.path,
      spawn_options
    )
    if $?.success?
      File.read(file.path).tap { file.tap(&:unlink).close }
    else
      raise Error,
            "tidy exited unsuccessfully " \
            "(exit code: #{$?.exitstatus}, " \
            "item: #{item.identifier}, " \
            "log: #{log.gsub(Dir.getwd, '')[1..]})",
            []
    end
  end

  def tidy_exe
    case
    when system("which tidy > /dev/null 2>&1") then "tidy"
    when system("which tidy5 > /dev/null 2>&1") then "tidy5"
    else raise Error, "unable to find a tidy executable on $PATH"
    end
  end

  def tidy_args(options)
    options.each_with_object([]) do |(key, value), ary|
      if value.equal?(true)
        ary << key
      else
        ary.concat [key, value.to_s]
      end
    end
  end

  ##
  # spawn-related methods

  def spawn_options
    { STDOUT => log, STDERR => log }
  end

  def log
    File.join(cwd, "tidy.log")
  end

  def cwd
    File.join(Dir.getwd, "tmp", "nanoc-tidy.rb")
  end
end
