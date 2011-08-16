#!/usr/bin/env ruby

require "osx/cocoa"
require "pp"

include OSX
OSX.require_framework "ScriptingBridge"

events = SBApplication.applicationWithBundleIdentifier_("com.apple.SystemEvents")

def to_menu(_list)
  locations = {}
  for item in _list
    name = yield item
    locations[name] = item
  end
  return locations
end

locs = to_menu(events.networkPreferences.locations) {|x| x.name.to_str}
pp locs
