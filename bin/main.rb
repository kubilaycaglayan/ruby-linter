#!/usr/bin/env ruby
require_relative './../lib/check_errors.rb'

path = '../lib/student_code.rb'
student_code = CheckErrors.new(path)

student_code.scan_all_lines
student_code.calculate
student_code.check_for_errors
p student_code.count_match_units
student_code.create_hash_index_all_units
p student_code.last_appearing(' ')
