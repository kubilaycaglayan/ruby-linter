#!/usr/bin/env ruby
require_relative './../lib/check_errors.rb'

path = '../lib/student_code.txt'
student_code = CheckErrors.new(path)

# print "COUNT MATCH UNITS #{student_code.count_match_units}"
# print "SPECIAL WORD COUNT #{student_code.special_w_count}"
# print "LINE #{student_code.line_orders}"

student_code.errors.each do |key, value|
  puts "#{key + 1}. LINE #{value}"
end



# print "ALL UNITS #{student_code.all_units}"
# print "INDEX ALL UNITS #{student_code.index_all_units}"
# puts student_code
