# Mixin to use RedCarpet for Markdown, and Redcarpet's SmartyPants for rendering HTML
class HTMLWithPants < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants
end
set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true, :autolink => true, :with_toc_data => true, :footnotes => true

# Changing permission after build
class FixPermissions < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
    app.after_build do |builder|
      FixPermissions.chmodr(app.build_dir)
    end
  end

  def self.chmodr(dir)
    return unless File.directory?(dir)
    Dir.foreach(dir) do |entry|
      if(entry != "." && entry != "..")
        entry = File.absolute_path(entry, dir)
        mode = 0644
        mode = 0755 if(File.directory?(entry))
        File.chmod(mode,entry)
        chmodr(entry)
      end
    end
  end
end
::Middleman::Extensions.register(:fix_perm, FixPermissions)

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
helpers do

  # Shorthand to include CSS using absolute path to the CSS dir
  def include_css(*paths)
    parent = settings.css_dir
    paths = paths.map { |it| "/#{parent}/#{it}" }
    stylesheet_link_tag paths
  end

  # Shorthand to include JS using absolute path to the JS dir
  def include_js(*paths)
    parent = settings.js_dir
    paths = paths.map { |it| "/#{parent}/#{it}" }
    javascript_include_tag paths
  end
end

set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'

# Use Uglfier in "beautify" mode in development
# This will allow us to catch and debug any minifier-created issues
# (Minifier-created issues are bugs in either the minifier or our code: please report/fix them!)
activate :minify_javascript
set :js_compressor, Uglifier.new(
  :output => {
    :beautify => true,
    :preserve_line => true,
    :indent_level => 2
  },
  :screw_ie8 => true
)

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
  activate :imageoptim  # If this is too slow for your process, your process is broke
  activate :minify_css
  # activate :ngmin  # Uncomment this if you use Angular
  activate :minify_html
  #activate :gzip # Requires webserver configuration to take advantage of this

  # Change the JS compressor to actually do the compression
  set :js_compressor, Uglifier.new(:screw_ie8 => true)
end

# Ignore vi swap files so that they don't trigger rebuilds
config[:file_watcher_ignore] << /\.swp$/

# Make sure everything has the right permissions
activate :fix_perm

# This plugin activation needs to be last!
activate :alias

