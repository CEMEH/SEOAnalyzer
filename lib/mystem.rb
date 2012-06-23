module Mystem
  class Application
    DIR = File.dirname(__FILE__) + '/../script/'

    def initialize
      @exec = DIR + self.application
    end

    def lemma(text)
      result = self.run(text, 'l')

      if (result != nil)
        return result[1...-1]
      else
        return text
      end
    end

    def run(text, mode)
      in_file = DIR + 'in'
      File.open(in_file, 'w') { |f| f.puts(text) }

      out_file = DIR + 'out'
      cmd = @exec + ' -' + mode + ' ' + in_file + ' ' + out_file + ' -e utf-8'

      system(cmd)

      result = File.open(out_file, 'r') { |f| f.gets }
      return result
    end

    protected :run

    def application
      require 'rbconfig'
      os = RbConfig::CONFIG['target_os']
      cpu = RbConfig::CONFIG['target_cpu']
      if os == 'mingw32'
        return 'mystem.exe'
      end
    end

    protected :application

  end

  def self.lemma(text)
    mystem = Application.new
    return mystem.lemma(text)
  end
end