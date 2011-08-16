#!/usr/bin/env ruby

require "optparse"
require "ostruct"
require "osx/cocoa"

include OSX
OSX.require_framework "ScriptingBridge"

options = OpenStruct.new

optparse = OptionParser.new do|opts|
  opts.banner = "Usage: togglespaces.rb -v -r <rows> -c <columns>"

  opts.on('-v', '--verbose', 'output more info') do |v|
    options.verbose = v
  end

  opts.on('-r', '--rows [N]', Integer, 'number of rows to have') do |rows|
    if rows == nil or rows < 1
      puts "A row count > 1 is required"
      exit 1
    end
    options.rows = rows
  end

  opts.on('-c', '--columns [N]', Integer, 'number of columns to have') do |cols|
    if cols == nil or cols < 1
      puts "A column count > 1 is required"
      exit 1
    end

    options.cols = cols
  end
end.parse!

if options.verbose
  puts "Setting Spaces to have %s rows" % options.rows
  puts "Setting Spaces to have %s columns" % options.cols
end

events = SBApplication.applicationWithBundleIdentifier_("com.apple.SystemEvents")
events.exposePreferences.spacesPreferences.spacesRows = options.rows
events.exposePreferences.spacesPreferences.spacesColumns = options.cols

if options.verbose
  puts "Successfully set Spaces preferences"
end
