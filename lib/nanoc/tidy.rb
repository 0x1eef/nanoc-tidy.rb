# frozen_string_literal: true

require "nanoc"
module Nanoc::Tidy
  require_relative "tidy/version"
  require_relative "tidy/filter"

  ##
  # @example (see Nanoc::Tidy::Filter.default_argv)
  # @return (see Nanoc::Tidy::Filter.default_argv)
  def self.default_argv
    Filter.default_argv
  end
end
