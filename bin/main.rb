#!/usr/bin/env ruby
require_relative './../lib/check_errors.rb'

def show_errors(instance_name)
  puts "\n____ERROR CHECKING RESULTS:____"
  puts instance_name
  puts "\nDETAILS:\n" if instance_name.error_counter.positive?
  instance_name.errors.each do |key, value|
    next if value.empty?

    print "#{key + 1}. LINE:________\n"
    count = 0
    value.each do |error|
      count += 1
      comma = count < value.size ? ", \n" : ''
      print '        *' + error + comma
    end
    puts
  end
  puts "\n"
end

def paths
  int = $PROGRAM_NAME[0..-8]
  ['', int + '../lib/student_codes/student_code1.rb',
   int + '../lib/student_codes/student_code2.rb',
   int + '../lib/student_codes/student_code3.rb',
   int + '../lib/student_codes/student_code4.rb',
   int + '../lib/student_codes/student_code5.rb',
   int + '../lib/student_codes/student_code6.rb']
end

def instances
  ['', CheckErrors.new(paths[1]),
   CheckErrors.new(paths[2]),
   CheckErrors.new(paths[3]),
   CheckErrors.new(paths[4]),
   CheckErrors.new(paths[5]),
   CheckErrors.new(paths[6])]
end

def show
  show_errors(instances[1])
  show_errors(instances[2])
  show_errors(instances[3])
  show_errors(instances[4])
  show_errors(instances[5])
  show_errors(instances[6])
end

if ARGV.empty?
  show
else
  given_path = ARGV[0]
  new_check = CheckErrors.new(given_path)
  show_errors(new_check)
end
