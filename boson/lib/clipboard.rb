# code taken from:
#   http://github.com/cldwalker/irbfiles/blob/master/boson/lib/clipboard.rb
require 'platform'

class Clipboard
  
  def self.available?
    @@implemented || false
  end
  
  case Platform::IMPL
  when :macosx

    def self.read
      IO.popen('pbpaste') {|clipboard| clipboard.read}
    end

    def self.write(stuff)
      IO.popen('pbcopy', 'w+') {|clipboard| clipboard.write(stuff)}
    end
    @@implemented = true

  when :mswin

    begin
      # Try loading the win32-clipboard gem
      require 'win32/clipboard'

      def self.read
        Win32::Clipboard.data
      end

      def self.write(stuff)
        Win32::Clipboard.set_data(stuff)
      end
      @@implemented = true

    rescue LoadError
      raise "You need the win32-clipboard gem for clipboard functionality!"
    end

  when :linux
    #test execute xsel
    `xsel`
    if $?.exitstatus != 0
      raise "You need to install xsel for clipboard functionality!"
    end

    def self.read
      `xsel`
    end
    
    def self.write(stuff)
      `echo '#{stuff}' | xsel -i`
    end
    @@implemented = true

  else
    raise "No suitable clipboard implementation for your platform found!"
  end
end
