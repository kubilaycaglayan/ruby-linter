require_relative 'index_code.rb'

class CheckErrors < IndexCode
  def initialize(path)
    super
    create_error_storage_hash
    check_for_errors
  end

  private

  def check_for_errors
    indentation_error
    paranthese_error
    square_error
    curly_error
    extra_space_error
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
    @errors[line] << 'Indentation Error'
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
      @errors[last_appearing(')')[0]] << 'Opening paranthese missing'
    when 2
      @errors[last_appearing('(')[0]] << 'Closing paranthese missing'
    end
  end

  def square_error
    case paranthese_check
    when 1
      @errors[last_appearing(']')[0]] << 'Opening square bracket missing'
    when 2
      @errors[last_appearing('[')[0]] << 'Closing square bracket missing'
    end
  end

  def curly_error
    case paranthese_check
    when 1
      @errors[last_appearing('}')[0]] << 'Opening curly bracket missing'
    when 2
      @errors[last_appearing('{')[0]] << 'Closing curly bracket missing'
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
    wrong_spaces.each do |key, value|
      value.each do |line, unit|
        @errors[line] << 'Extra spacing detected.'
      end
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
