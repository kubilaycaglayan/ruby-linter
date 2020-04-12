require_relative 'index_code.rb'

class CheckErrors < IndexCode
  def initialize(path)
    @error_counter = 0
    super
    create_error_storage_hash
    check_for_errors
  end

  def to_s
    error_message = @error_counter.zero? ? "No errors detected.\n" : "Errors (#{@error_counter}) detected.\n"
    "\nPath: #{@path}\n" \
      "File: \"#{@file_name}\" has #{count_lines} lines.\n" +
      error_message
  end

  private

  def check_for_errors
    indentation_error
    paranthese_error
    square_error
    curly_error
    extra_space_error
    new_line_error
    end_error
  end

  def record_error(line, error_message)
    @errors[line] << error_message
    @error_counter += 1
  end

  def create_error_storage_hash
    @errors = {}
    count_lines.times do |i|
      @errors[i] = []
    end
  end

  def indentation_error?(value, line)
    true unless value.size == calculate_indentation_order(line)
  end

  def record_indentation_error(line)
    record_error(line, 'Indentation Error')
  end

  def indentation_error
    @all_units.each do |line, value|
      @all_units[line].size.times do |i|
        word = value[i][0]
        if indentation?(i, word)
          record_indentation_error(line) if indentation_error?(word, line)
        end
      end
    end
  end

  def paranthese_check
    if @count_match_units[:open_paranthese] < @count_match_units[:close_paranthese]
      1
    elsif @count_match_units[:open_paranthese] > @count_match_units[:close_paranthese]
      2
    else
      0
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

  def paranthese_error
    case paranthese_check
    when 1
      record_error(last_appearing(')')[0], 'Opening paranthese missing')
    when 2
      record_error(last_appearing('(')[0], 'Closing paranthese missing')
    end
  end

  def square_error
    case paranthese_check
    when 1
      record_error(last_appearing(']')[0], 'Opening square bracket missing')
    when 2
      record_error(last_appearing('[')[0], 'Closing square bracket missing')
    end
  end

  def curly_error
    case paranthese_check
    when 1
      record_error(last_appearing('}')[0], 'Opening curly bracket missing')
    when 2
      record_error(last_appearing('{')[0], 'Closing curly bracket missing')
    end
  end

  def wrong_spaces
    spaces_in_the_text.select do |_key, value|
      condition = false
      value.each do |_first, second|
        condition = true unless second.zero?
      end
      condition
    end
  end

  def extra_space_error
    wrong_spaces.each do |_key, value|
      value.each do |line, _unit|
        record_error(line, 'Extra spacing detected.')
      end
    end
  end

  def special_word_occurings
    word_occuring_lines('def') + word_occuring_lines('class') +
      word_occuring_lines('if') + word_occuring_lines('module')
  end

  def new_line_check
    (after_end - special_word_occurings).size == after_end.size
  end

  def new_line_error
    unless new_line_check
      expected_newlines = after_end - (after_end - special_word_occurings)
      expected_newlines.each do |line|
        record_error(line, 'Expected newline.')
      end
    end
  end

  def end_missing_error
    line = last_appearing('end').nil? ? count_lines : last_appearing('end')
    record_error(line[0], "Expected \'end\' or redundant keyword.")
  end

  def end_too_much_error
    record_error(last_appearing('end')[0], "Redundant \'end\' or missing keywords.")
  end

  def end_error
    case special_w_count_excluding_end <=> special_w_count[:endd]
    when 1
      end_missing_error
    when -1
      end_too_much_error
    end
  end
end

# path = './student_code.rb'
# student_code = CheckErrors.new(path)
# student_code.scan_all_lines
# student_code.calculate
# student_code.check_for_errors
# p student_code.count_match_units
# student_code.create_hash_index_all_units
# p student_code.last_appearing(' ')
