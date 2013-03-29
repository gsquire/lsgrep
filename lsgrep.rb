#!/usr/bin/ruby

# Search for files here instead

require 'find'
require 'optparse'

dir = ARGV.first

opts = Hash.new
cmd = OptionParser.new do |o|
  o.banner = "Usage: #{__FILE__} path options"

  o.on("-f", "--fixed STRING", String, "Fixed string search pattern") do |f|
    opts[:fixed] = f
  end

  o.on("-r", "--regex REGEX", ::Regexp, "Regular expression search pattern") do |r|
    opts[:regex] = r
  end
end

cmd.parse!

puts "Can only choose one option" if opts[:fixed] and opts[:regex]

def walk(path, opts)
  sim = opts[:fixed]
  com = opts[:regex]

  Find.find(path) do |f|
    base = File.basename(f)
    if sim
      if base[sim]
        puts f
      end
    end

    if com
      if base.match(com)
        puts f
      end
    end
  end
end

walk(dir, opts)
