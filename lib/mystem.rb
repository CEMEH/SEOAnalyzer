module Mystem
  class Application
    DIR = File.dirname(__FILE__) + '/../script/'

    def initialize
      @exec = DIR + self.application
    end

    def lemma(text)
      result = self.run(text, 'l')
      return result
    end

    def run(text, mode)
      in_file = DIR + 'in'
      File.open(in_file, 'w') { |f|
        text.each { |word| f.puts(word) }
      }

      out_file = DIR + 'out'
      cmd = @exec + ' -c' + mode + ' ' + in_file + ' ' + out_file + ' -e utf-8'

      system(cmd)

      result = Array.new

      # однострочный и много строчный режим (в зависимости от входных параметров)
      File.open(out_file, "r") do |infile|
        while (line = infile.gets)
          result.push(line)
        end
      end

      return result
    end

    protected :run

    def application
      require 'rbconfig'
      os = RbConfig::CONFIG['target_os']
      cpu = RbConfig::CONFIG['target_cpu']
      
      result = ''
      if os == 'mingw32'
        result = 'mystem.exe'
      end
      if os == 'linux'
        result = 'mystem_linux'
        if cpu == 'i686'
          result += '32'
        else
          result += '64'
        end
      end
      return result
    end

    protected :application

  end

  def self.lemma(text)
    mystem = Application.new
    return mystem.lemma(text)
  end
end
