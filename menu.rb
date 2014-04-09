module Stujo
  module CommandLine
    class Menu
      def initialize(prompt)
        @prompt = prompt
        @options = {}
      end

      def add_option(input_string, &block)
        @options[input_string] = block_given? ? block : lambda {|x| x}
      end

      def run_no_options
        puts "#{@prompt}"
        input = gets.chomp.capitalize
      end

      def run_with_options
        input = nil
        begin
          puts "#{@prompt} (#{@options.keys.join(',')})"
          input = gets.chomp.capitalize
        end while !@options.has_key? input
        @options[input].call(input)
      end

      def run
        if @options.empty?
          run_no_options
        else
          run_with_options
        end
      end
      
    end
  end
end

