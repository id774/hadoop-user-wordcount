#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'json'

class Mapper
  def map(stdin)
    stdin.each_line {|line|
      key, tag, json = line.force_encoding("utf-8").strip.split("\t")
      timestamp, screen_name, uid = key.strip.split(",")
      hash = JSON.parse(json)
      mapper_output(screen_name, uid, hash["word_vector"])
    }
  end

  private

  def mapper_output(screen_name, uid ,array)
    puts "#{screen_name}\t#{uid}\t#{array}"
  end
end

if __FILE__ == $0
  mapper = Mapper.new
  mapper.map($stdin)
end

