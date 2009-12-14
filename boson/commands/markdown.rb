module Markdown
  require 'kramdown'

  # Converts markdown file contents to html
  def markdown(file)
    base = File.basename(file,File.extname(file))
    File.open("#{base}.html",'w') do |f|
      f.puts Kramdown::Document.new(File.open(file).read).to_html
    end
  end

end
