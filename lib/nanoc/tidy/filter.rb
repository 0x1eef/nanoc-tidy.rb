# frozen_string_literal: true

class Nanoc::Tidy::Filter < Nanoc::Filter
  require "fileutils"
  include FileUtils
  Error = Class.new(RuntimeError)

  identifier :tidy
  type text: :text

  ##
  # @return [{"-wrap" => 120, "-indent" => true}]
  #  Returns the default options forwarded as command-line
  #  arguments to tidy-html5.
  def self.default_options
    @default_options ||= {"-wrap" => 120, "-indent" => true}
  end

  def run(content, options = {})
    file = temporary_file_for(content)
    tidy file, self.class.default_options.merge(options)
  end

  private

  def tidy(file, options)
    system tidy_exe, "-modify", "-quiet", *tidy_args(options), file.path
    if $?.success?
      File.read(file.path).tap { file.tap(&:unlink).close }
    else
      raise Error, "tidy exited unsuccessfully (exit code: #{$?.exitstatus})", []
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

  def tidy_exe
    case
    when system("which tidy > /dev/null 2>&1") then "tidy"
    when system("which tidy5 > /dev/null 2>&1") then "tidy5"
    else raise Error, "unable to find a tidy executable on $PATH"
    end
  end

  def temporary_file_for(content)
    dir = File.join(Dir.getwd, "tmp", "nanoc-tidy.rb")
    mkdir_p(dir) unless Dir.exist?(dir)
    file = Tempfile.new(File.basename(item.identifier.to_s), dir)
    file.write(content)
    file.tap(&:flush)
  end
end
