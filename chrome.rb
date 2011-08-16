#!/usr/bin/env ruby

require "pp"
framework "ScriptingBridge"

def configure()
  config_version = (Integer(ARGV[0]) or 0)
  mod_version = (config_version % 10)
  urls = (["http:%s" % mod_version] + (ARGV[1..-1] or []))
  puts "Opening Deployment Dashboard for Config #%s" % mod_version
  puts "Lauching urls::"
  puts urls
  launch(urls)
end

def launch(urls)
  chrome = SBApplication::applicationWithBundleIdentifier('com.Google.Chrome')
  chrome.windows.push(GoogleChromeWindow.new)
  (0..urls.length-1).each do |x|
      chrome.windows[0].tabs.push(GoogleChromeTab.new)
    chrome.windows[0].activeTab.URL = urls[x]
  end
  chrome.activate
end

configure()
