require_relative 'index_code.rb'

class CheckErrors < IndexCode
  def error_storage
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
end

#path = './student_code.rb'

