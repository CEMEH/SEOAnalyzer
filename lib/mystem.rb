module Mystem
  class Application
    DIR = File.dirname(__FILE__) + '/../script/'

    def initialize
      @exec = DIR + self.application
    end

    def lemma(text)
      return self.run(text, 'l')
    end

    def run(text, mode)
      in_file = DIR + 'in'
      File.open(in_file, 'w') {|f| f.puts(text) }

      out_file = DIR + 'out'
      cmd = @exec + ' -n' + mode + ' ' + in_file + ' ' + out_file + ' -e utf-8'

      system(cmd)

      result = File.open(out_file, 'r') {|f| f.gets }
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

  def self.test
    mystem = Application.new
    puts mystem.lemma('автомашины')
  end
end

Mystem.test