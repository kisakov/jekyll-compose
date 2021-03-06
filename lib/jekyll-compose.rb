require "jekyll-compose/version"
require "jekyll-compose/arg_parser"
require "jekyll-compose/movement_arg_parser"
require "jekyll-compose/file_creator"
require "jekyll-compose/file_mover"
require "jekyll-compose/file_info"

module Jekyll
  module Compose
    DEFAULT_TYPE = "markdown".freeze
    DEFAULT_LAYOUT = "post".freeze
    DEFAULT_LAYOUT_PAGE = "page".freeze
  end
end

# %w{draft post publish unpublish page story}.each do |file|
%w{cooking page story}.each do |file|
  require File.expand_path("jekyll/commands/#{file}.rb", __dir__)
end
