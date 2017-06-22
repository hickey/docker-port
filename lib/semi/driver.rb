require 'erb'
require 'ostruct'

module Semi
  class Driver

    def initialize(path)
      @config = Semi::Config.new(path)
    end

    def start
      # Initialize the dictionary with the defaults
      @dictionary = {}
      @config.defaults.each_pair do |name,val|
        hints = @config.validators[name] || nil
        @dictionary[name] = Semi::Variable.import(val, hints)
      end

      # Now manually merge in the env vars
      ENV.each_pair do |name, val|
        hints = @config.validators[name] || nil
        @dictionary[name] = Semi::Variable.import(val, hints)
      end

      #puts @dictionary.inspect

      # Check any validations being asserted
      @config.validators.each_key { |key|
        begin
          Semi::validate(@dictionary[key], @config.validators[key])
        rescue Semi::ValidationError => err
          if @dictionary.include? key
            puts "Can not validate #{key}: #{err}"
          elsif @config.validators[key].include? 'required'
            puts "#{key} is a required value, but it was not found."
            exit(5)
          end
        end
      }

      # prepare the dictionary for the templates
      @dictionary = OpenStruct.new(@dictionary)

      # Process the config files and generate final versions
      @config.files.each do |file|
        # Read the template file and render
        if File.exist? file
          contents = File.open(file, 'r') do |fp|
            renderer = ERB.new(fp.readlines.join, nil, '%<>-')
            renderer.result(@dictionary.instance_eval {binding})
          end

          # Reopen the file and write the rendered contents
          File.open(file, 'w') do |fp|
            fp.write(contents)
          end
        end
      end

      # Check for pre-defined commands
      args = ARGV
      if args.count == 0 and @config.commands.include? 'default'
        args = @config.commands['default']
      elsif args.count == 1 and args[0] == 'help'
        puts "This container also supports the following commands:"
        puts""
        printf("  %-10s||   %s\n", 'Command', 'Actual command run / description')
        puts "---------------------------------------------------------------"
        @config.commands.each_pair do |cmd, cmd_line|
          printf("  %-10s   => %s\n", cmd, cmd_line)
        end
        printf("  %-10s   => %s\n", 'help', 'List shortcut and additional commands')
        exit(0)
      elsif @config.commands.include? args[0]
        args = @config.commands[args[0]]
      end
      

      # Execute the command line
      #puts "Executing: #{args}"
      exec([args].flatten.join(' '))
    end

  end
end
