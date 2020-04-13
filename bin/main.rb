#!/usr/bin/env ruby
require_relative './../lib/check_errors.rb'
require 'colorize'

def show_errors(instance_name)
  puts "\n____ERROR CHECKING RESULTS:____".colorize(:blue)
  puts instance_name
  puts "\nDETAILS:\n".colorize(:blue) if instance_name.error_counter.positive?
  instance_name.errors.each do |key, value|
    next if value.empty?

    print "#{key + 1}. LINE:________\n"
    count = 0
    value.each do |error|
      count += 1
      comma = count < value.size ? ", \n" : ''
      print '        *' + error.colorize(:red) + comma
    end
    puts
  end
  puts "\n"
end

def file_names_in_student_codes_file
  int = $PROGRAM_NAME[0..-8]
  path_students_code = int + '../lib/student_codes/*'
  files_in_students_code = Dir[path_students_code]
  file_names = files_in_students_code.map do |file_path|
    file_path.reverse.split("\/")[0].reverse
  end
  file_names
end

def paths
  int = $PROGRAM_NAME[0..-8]
  student_codes_path = int + '../lib/student_codes/'
  file_paths_in_student_codes = file_names_in_student_codes_file.map do |file_names|
    student_codes_path + file_names
  end
  file_paths_in_student_codes
end

def instances
  paths.map do |file_path|
    CheckErrors.new(file_path)
  end
end

def show
  instances.map do |instance|
    show_errors(instance)
  end
end

if ARGV.empty?
  show
else
  given_path = ARGV[0]
  new_check = CheckErrors.new(given_path)
  show_errors(new_check)
end
