#!/usr/bin/env ruby

puts 'Hello!'

class ReadFile
  attr_accessor :line_orders
  def initialize(path)
    @path = path
    @file_name = path.match(%r{/\w*\.rb}).to_s[1..-1]
    @read_by_lines = File.readlines(@path)
  end

  def to_s
    "\nPath: #{@path}\n" \
      "File: \"#{@file_name}\" has #{count_lines} lines."
  end

  def count_lines
    @read_by_lines.size
  end
end

path = '../lib/student_code.rb'

require 'strscan'

class ReadLines < ReadFile
  attr_accessor :count_match_units, :special_w_count, :line_orders, :errors, :all_units, :index_all_units
  def initialize(path)
    super
    match_units
    special_words
    line_order
    error_storage
    create_all_units
  end

  def nth_line(nth)
    read_by_lines
    @read_by_lines[nth]
  end

  def nth_line_show(nth)
    read_by_lines
    @read_by_lines[nth]
  end

  def match_units
    @match_units = {
      a_word: /[a-zA-Z]+(\d+)*/,
      a_number: /\d+/,
      a_doublequote: /\"/,
      a_singlequote: /\'/,
      a_newline: /\n/,
      a_space: / +/,
      a_sign: /[!\?\.\+\-\*_@=]/,
      open_paranthese: /\(/,
      close_paranthese: /\)/,
      a_comma: /,/,
      open_square: /\[/,
      close_square: /\]/,
      open_curly: /\{/,
      close_curly: /\}/,
      other: /.{1}/
    }
    @keys_match_units = @match_units.each_key.to_a
    @count_match_units = {}
    @match_units.each_key do |key|
      @count_match_units[key] = 0
    end
  end

  def calculate_match_units
    @all_units.each do |key, value|
      @all_units[key].size.times do |i|
        match_type = value[i][1]
        @count_match_units[@keys_match_units[match_type]] += 1
      end
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

  def calculate_special_word()
    @all_units.each do |key, value|
      @all_units[key].size.times do |i|
        word = value[i][0]
        increase_special_word(word) if special_word?(word)
      end
    end
  end

  def line_order
    @line_orders = {}
    count_lines.times do |line|
      @line_orders[line] = 0
    end
  end

  def increase_line_order(line)
    @line_orders[line + 1] += 2
  end

  def decrease_line_order(line)
    @line_orders[line] -= 2
  end

  def change_line_order(word, line)
    word == 'end' ? decrease_line_order(line) : increase_line_order(line)
  end

  def calculate_line_order()
    @all_units.each do |key, value|
      @all_units[key].size.times do |i|
        word = value[i][0]
        change_line_order(word, key) if special_word?(word)
      end
    end
  end

  def calculate_indentation_order(line)
    result = @line_orders.each.reduce(0) do |sum, key_value|
      return sum if key_value[0] == line + 1

      sum + key_value[1]
    end
    result
  end

  def error_storage
    @errors = {}
    count_lines.times do |i|
      @errors[i] = []
    end
  end

  def indentation?(unit, value)
    if unit.zero? && value.match(/ +/)
      true
    else
      false
    end
  end

  def indentation_error?(value, line)
    true unless value.size == calculate_indentation_order(line)
  end

  def record_indentation_error(line)
    @errors[line] << 'Indentation Error'
  end

  def create_all_units
    @all_units = {}
    count_lines.times do |i|
      @all_units[i] = []
    end
  end

  def add_all_units(value, line, match_type)
    @all_units[line] << [value, match_type]
  end

  def create_hash_index_all_units
    # { "word" => [[2.line,3.unit], [4.line,1.unit]] }
    @index_all_units = {}
    @all_units.each do |line, value_match_type|
      value_match_type.each_with_index do |unit, round|
        @index_all_units[unit[0]] ||= []
        @index_all_units[unit[0]] << [line, round]
      end
    end
  end

  def calculate
    calculate_match_units
    calculate_special_word
    calculate_line_order
  end

  def check_for_errors
    @all_units.each do |line, value|
      @all_units[line].size.times do |i|
        word = value[i][0]
        if indentation?(i, word)
          record_indentation_error(line) if indentation_error?(word, line)
        end
      end
    end
  end

  def scan_line(line, index)
    scn = StringScanner.new(line)
    # p "LINE: #{index}"
    # unit = 0
    until scn.eos?
      matched = false
      @match_units.size.times do |i|
        value = scn.scan(@match_units[@keys_match_units[i]])
        unless value.nil?
          add_all_units(value, index, i)
          matched = true
          #  unit += 1
        end
        break if matched
      end
    end
  end

  def scan_all_lines
    @read_by_lines.each_with_index do |line, index|
      scan_line(line, index)
    end
  end

  def paranthese_check
    if @count_match_units[:open_paranthese] < @count_match_units[:close_paranthese]
      'Open paranthese expected.'
    elsif @count_match_units[:open_paranthese] > @count_match_units[:close_paranthese]
      'Closing paranthese expected.'
    end
  end

  def square_check
    if @count_match_units[:open_square] < @count_match_units[:close_square]
      'Open square expected.'
    elsif @count_match_units[:open_square] > @count_match_units[:close_square]
      'Closing square expected.'
    end
  end

  def curly_check
    if @count_match_units[:open_curly] < @count_match_units[:close_curly]
      'Open curly expected.'
    elsif @count_match_units[:open_curly] > @count_match_units[:close_curly]
      'Closing curly expected.'
    end
  end

  def first_appearing(unit)
    @index_all_units[unit].first
  end

  def last_appearing(unit)
    @index_all_units[unit].last
  end
end

student_code = ReadLines.new(path)

student_code.scan_all_lines
student_code.calculate
student_code.check_for_errors
p student_code.count_match_units
student_code.create_hash_index_all_units
p student_code.last_appearing(' ')
