require 'yaml'

module Semi
  class Config
    
    attr_reader :defaults
    attr_reader :files
    attr_reader :validators
    attr_reader :commands

    def initialize(path=nil)
      @defaults = {}
      @validators = {}
      @files = []
      @commands = {}

      if path
        self.load(path)
      end
    end

    def load(path)
      data = YAML.load_file(path)
      if data.key? 'defaults'
        @defaults = data['defaults']
      end

      if data.key? 'validate'
        @validators = data['validate']
      end

      if data.key? 'files'
        @files = data['files']
      end

      if data.key? 'commands'
        @commands = data['commands']
      end
      
      return data
    end
  end
end
