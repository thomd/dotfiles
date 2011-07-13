require 'irb/completion'
require 'irb/ext/save-history'
require 'rubygems' rescue nil
%x{gem install 'wirble' --no-ri --no-rdoc} unless Gem.available?('wirble')
%x{gem install 'hirb' --no-ri --no-rdoc} unless Gem.available?('hirb')
Gem.refresh
require 'wirble'
require 'hirb'

# load wirble
Wirble.init
Wirble.colorize

# load hirb
Hirb::View.enable

IRB.conf[:AUTO_INDENT] = true

if ENV.include?('RAILS_ENV')
  if !Object.const_defined?('RAILS_DEFAULT_LOGGER')
    require 'logger'
    Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
  end

  def sql(query)
    ActiveRecord::Base.connection.select_all(query)
  end

  if ENV['RAILS_ENV'] == 'test'
    require 'test/test_helper'
  end

  # for rails 3
elsif defined?(Rails) && !Rails.env.nil?
  if Rails.logger
    Rails.logger =Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger
  end
  if Rails.env == 'test'
    require 'test/test_helper'
  end
else
  # nothing to do
end

# annotate column names of an AR model
def show(obj)
  y(obj.send("column_names"))
end

# alias
alias q exit

#
# put this into Gemfile of a rails project if you like to use wirble and hirb in rails console
#
#group :development do
#  gem "wirble"
#  gem "hirb"
#end
