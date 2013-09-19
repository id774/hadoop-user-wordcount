#!/opt/ruby/current/bin/ruby
# -*- coding: utf-8 -*-

$:.unshift File.join(File.dirname(__FILE__))

require 'json'

class Reducer
  def reduce(stdin)
    key = nil
    uid = nil
    hits = {}

    stdin.each_line {|line|
      newkey, newuid, word_vector = line.force_encoding("utf-8").strip.split("\t")
      if newkey.length > 0
        unless key == newkey
          reducer_output(key, uid, hits)
          key = newkey
          uid = newuid
          hits = {}
        end
        word_vector.split(",").each {|word|
          hits.has_key?(word) ? hits[word] += 1 : hits[word] = 1
        } unless word_vector.nil?
      end
    }
    reducer_output(key, uid, hits)
  end

  private

  def reducer_output(key, uid, hits)
    puts "#{key}\t#{uid}\t#{JSON.generate(Hash[hits.sort_by{|k,v|-v}])}\n" unless key.nil?
  end
end

if __FILE__ == $0
  reducer = Reducer.new
  reducer.reduce($stdin)
end
