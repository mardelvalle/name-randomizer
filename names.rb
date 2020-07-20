require "json"
require 'optparse'
@file = File.open "./names.json"
@data = JSON.load @file


OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"
  opts.on("-a=s", "--add", "Add name to list") do |name|
    puts name
    if @data["names"].include?(name)
      puts "#{name} is already in the list"
      return
    end
    @data["names"].push(name)
    File.write(@file, @data.to_json)
    puts "You have successfully added #{name} from the list. The name list is now: #{@data["names"]}"
  end

  opts.on("-d=s", "--delete", "Delete a name in the list") do |name|
    if @data["names"].include?(name)
      @data["names"].delete(name)
      File.write(@file, @data.to_json)
      puts "You have successfully deleted #{name} from the list. The name list is now: #{@data["names"]}"
    else
      puts "#{name} isn't in the list"
    end
  end

  opts.on("-l", "--list", "Print list of names") do
    puts @data["names"]
  end

  opts.on("-r", "--random", "Print randomly ordered name list") do
    puts @data["names"].shuffle
  end
end.parse!
