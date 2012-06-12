class CommandParser
  def initialize(*args)
    @paths = args
  end

  def perform
    @paths.each do |path|
      Dir.glob(path) do |item|
        puts CommandParser::Command.new(item)
      end
    end
  end


  class Command
    def initialize(file)
      @file = file
      @content = parse_file
    end

    def parse_file
      @contents = File.read(@file)
    end

    def to_s
      tab = @contents.match(/<tabTrigger>(.*)<\/tabTrigger>/)[1]
      description = @contents.match(/<description>(.*)<\/description>/)[1]
      scope = @contents.match(/<scope>(.*)<\/scope>/)[1]

      "<tr><td>#{tab}</td><td>#{description}</td><td>#{scope}</td></tr>"
    end
  end
end

parser = CommandParser.new("#{Dir.home}/Library/Application Support/Sublime Text 2/Packages/Rails/*.sublime-snippet",
  "#{Dir.home}/Library/Application Support/Sublime Text 2/Packages/Ruby/*.sublime-snippet"
)

parser.perform