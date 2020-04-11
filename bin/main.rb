#!/usr/bin/env ruby

puts 'Hello!'

class ReadFile
  attr_accessor :line_orders
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
    line_order
  end

  def count_lines
    @read_by_lines.size
  end

  def line_order
    @line_orders = {}
    count_lines.times do |line|
      @line_orders[line] = 0
    end
  end
end

path = '../lib/student_code.rb'

require 'strscan'

class ReadLines < ReadFile
  attr_accessor :count_match_units, :special_w_count, :line_orders
  def initialize(path)
    super
    match_units
    special_words
  end

  def nth_line(nth)
    read_by_lines
    @read_by_lines[nth]
  end

  def nth_line_show(nth)
    read_by_lines
    p @read_by_lines[nth]
    @read_by_lines[nth]
  end

  def match_units
    @match_units = {
      a_word: /[a-zA-Z]+\d+*/,
      a_number: /\d+/,
      a_doublequote: /\"/,
      a_singlequote: /\'/,
      a_newline: /\n/,
      a_space: / +/,
      a_sign: /[!\?\.\+\-\*]/,
      open_paranthese: /\(/,
      close_paranthese: /\)/,
      a_comma: /,/,
      other: /.{1}/
    }
    @keys_match_units = @match_units.each_key.to_a
    @count_match_units = {}
    @match_units.each_key do |key|
      @count_match_units[key] = 0
    end
  end

  def special_words
    @special_words = {
      method: 'def',
      classs: 'class',
      modules: 'module',
      endd: 'end'
    }
    @keys_special_words = @special_words.each_key.to_a
    @values_special_words = @special_words.each_value.to_a
    @special_w_count = {}
    @special_words.each_key do |key|
      @special_w_count[key] = 0
    end
  end

  def special_word?(word)
    @values_special_words.include?(word)
  end

  def increase_special_word(word)
    @special_words.each do |key, value|
      @special_w_count[key] += 1 if value == word
    end
  end

  def scan_line(line)
    scn = StringScanner.new(nth_line(line))
    until scn.eos?
      matched = false
      @match_units.size.times do |i|
        value = scn.scan(@match_units[@keys_match_units[i]])
        unless value.nil?
          @count_match_units[@keys_match_units[i]] += 1
          matched = true
        end
        break if matched
      end
    end
  end

  def scan_line_show(line)
    scn = StringScanner.new(nth_line_show(line))
    until scn.eos?
      matched = false
      unit = 0
      @match_units.size.times do |i|
        value = scn.scan(@match_units[@keys_match_units[i]])
        unless value.nil?
          p "UNIT: key: #{@keys_match_units[i]}   :  #{value}"
          @count_match_units[@keys_match_units[i]] += 1
          increase_special_word(value) if special_word?(value)
          matched = true
          unit += 1
        end
        break if matched
      end

    end
  end

  def indendation?(unit, value)
    if unit.zero? && value.match(/ +/)
      true
    else
      false
    end
  end

  def scan_all_lines
    count_lines.times do |line|
      scan_line_show(line)
    end
  end
end

student_code = ReadLines.new(path)
puts student_code
puts '---'
# student_code.count_lines.times do |i|
#  p student_code.nth_line(i)
# end
puts '----'
p student_code.scan_all_lines
p student_code.line_orders
