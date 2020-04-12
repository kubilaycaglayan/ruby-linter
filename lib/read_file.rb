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

  private

  def count_lines
    @read_by_lines.size
  end
end
