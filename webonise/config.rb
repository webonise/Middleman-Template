# Mixin to use RedCarpet for Markdown, and Redcarpet's SmartyPants for rendering HTML
class HTMLWithPants < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
end
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true, :with_toc_data => true, :footnotes => true

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
activate :automatic_image_sizes

# Reload the browser automatically whenever files change
configure :development do
   activate :livereload
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'css'

set :js_dir, 'js'

set :images_dir, 'img'

# Build-specific configuration
configure :build do
  # Remove unnecessary CSS vendor prefixes, and add any that are missing.
  # Shouldn't be necessary for devs, who should be using modern browsers for testing
  activate :autoprefixer do |config|
    # Which browsers should we support
    config.browsers = [
      # Google supports the last 2 versions. Follow their lead.
      "last 2 versions",
      # Going down to 1% results in autoprefixer generating downright bad CSS.
      "> 2%",
      # Be nice to universities
      "Firefox ESR"
    ]

    # Make the output CSS pretty
    config.cascade = true
  end

  # Make things small as part of the build
  activate :imageoptim
  activate :minify_css
  activate :minify_javascript
  activate :minify_html
  activate :gzip # Requires webserver configuration to take advantage of this
end

# Ignore vi swap files so that they don't trigger rebuilds
config[:file_watcher_ignore] << /\.swp$/

# This plugin activation needs to be last!
activate :alias

