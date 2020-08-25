#!/usr/bin/env ruby

require "open3"
require 'optparse'

def text_file?(filename)
  file_type, status = Open3.capture2e("file", filename.to_s)
  status.success? && file_type.include?("text")
end

ARGV.extend OptionParser::Arguable

ARGV.options.banner = <<USAGE
Usage:
ruby #{File.basename(__FILE__)} [options] from to [glob]
from      - gsub from string or ruby script
to        - gsub to string or ruby script
glob      - (optional)ruby glob pattern.
options:
-e|--eval   Evaluate `from` and `to` as a ruby script and replace the `to` string with the result of `from`.

example:
git gsub hoge piyo
git gsub -e '/hoge([0-9]+)/' 'piyo\#{$1.to_i + 1}'
git gsub -e '/belongs_to :(\w+)([^#\n]*)(#.*)?$/' '"belongs_to :\#{$1}\#{$2.include?("optional: false") ? $2 : $2.strip + ", optional: true"}\#{$3 != nil ? " " + $3 : ""}"' 'app/models/**/*.rb'
USAGE

opts = ARGV.getopts('e', 'eval')
evaluate = (opts['e'] || opts['eval']) ? true : false

begin
  raise "Invalid argument" if ARGV.size != 2 && ARGV.size != 3

  from_str, to_str, glob = ARGV
  from = evaluate ? eval(from_str) : from_str
  glob ||= '**/*'
  puts "from: #{from.inspect}, to_str: #{to_str}, glob: #{glob}"

  lsfiles = `git ls-files`
  files = lsfiles.lines.to_a.map { |path| Pathname.new(path.strip) } & Pathname.glob(glob)
  files.each do |path|
    next unless text_file? path
    buf = nil
    open(path) do |f|
      old_buf = f.read
      begin
        if evaluate
          buf = old_buf.gsub(from) { eval(to_str) }
        else
          buf = old_buf.gsub(from, to_str)
        end
        buf = nil if old_buf == buf
      rescue => ex
        puts "error:#{ex.inspect} on:#{path} backtrace:#{ex.backtrace}"
        next
      end
    end
    if buf
      puts "replaced:#{path}"
      open(path, "w") do |f|
        f.write buf
      end
    end
  end
rescue => ex
  puts ex.message
  puts ex.backtrace
  puts ARGV.options.help
end
