# frozen_string_literal: true

require "nanoc"
module Nanoc::Tidy
  require_relative "tidy/version"
  require_relative "tidy/filter"

  ##
  # @example (see Nanoc::Tidy::Filter.default_options)
  # @return (see Nanoc::Tidy::Filter.default_options)
  def self.default_options
    Filter.default_options
  end
end
