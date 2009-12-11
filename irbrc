#require 'irb/completion'
#require 'pp'
#IRB.conf[:AUTO_INDENT]=true
#ARGV.concat [ "--readline", "--prompt-mode", "simple" ]
require 'rubygems'
require 'wirble'
Wirble.init
Wirble.colorize



#hirb (http://blog.10to1.be/Rails/2009/12/09/hirb/)
if ENV['RAILS_ENV']
  require 'hirb'
  Hirb.enable
end


# alias
alias q exit


# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end


print "ruby version: ", `/usr/bin/env ruby --version`

