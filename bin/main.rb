#!/usr/bin/env ruby

puts 'Hello!'

class ReadFile
  def initialize(path)
    @path = path
    @file_name = path.match(%r{/\w*\.rb}).to_s[1..-1]
  end

  def to_s
    read_by_lines
    "\nPath: #{@path}\n" \
      "File: \"#{@file_name}\" has #{count_lines} lines."
  end

  def open_file
    @opened_file = File.open(@path, 'r')
    @opened_file.read
  end

  def close_file
    @opened_file.close
  end

  def read_file
    @read_file = File.read(@path)
  end

  def read_by_lines
    @read_by_lines = File.readlines(@path)
  end

  def count_lines
    @read_by_lines.size
  end
end

path = '../lib/student_code.rb'

class ReadWords < ReadFile
  def read_words(nth_line)
    read_by_lines
    @read_by_lines[nth_line].each do |word|
      puts word
    end
  end
end

student_code = ReadWords.new(path)
puts student_code
student_code.read_words(2)
