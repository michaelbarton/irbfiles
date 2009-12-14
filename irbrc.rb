require 'irb/completion'
require 'rubygems'

%w{wirble hirb alias boson}.each do |e|
  begin
    require e
  rescue LoadError
    puts "#{e} not installed: sudo gem install #{e}"
  end
end

Wirble.init
Wirble.colorize
Boson.start
