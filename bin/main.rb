#!/usr/bin/env ruby
require_relative './../lib/check_errors.rb'

path1 = '../lib/student_code1.rb'
path2 = '../lib/student_code2.rb'
student_code1 = CheckErrors.new(path1)
student_code2 = CheckErrors.new(path2)

def show_errors(instance_name)
  puts "\n------RESULTS:"
  puts instance_name
  instance_name.errors.each do |key, value|
    next if value.empty?

    print "#{key}. LINE: "
    value.each do |error|
      print error + ', '
    end
    puts
  end
end

show_errors(student_code1)
show_errors(student_code2)

# print "ALL UNITS #{student_code.all_units}"
# print "INDEX ALL UNITS #{student_code.index_all_units}"
# puts student_code
