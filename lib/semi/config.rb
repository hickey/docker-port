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

    def process_file(filename, dictionary)
      if Dir.exist? filename
         Dir.glob("#{filename}/*").each do |file|
           process_file(file, dictionary)
        end
      elsif File.exist? filename
        # Read the file and apply @dictionary values
        contents = File.open(filename, 'r') do |fp|
          renderer = ERB.new(fp.readlines.join, nil, '%<>-')
          renderer.result(dictionary.instance_eval {binding})
        end

        # Reopen the file and write the rendered contents
        File.open(filename, 'w') do |fp|
          fp.write(contents)
        end
      else
        raise RuntimeError, "Unable to find file or directory named #{filename}"
      end
    end

  end
end
