require "rubygems"
require "rake"
require "dotfile"

FILES_NOT_TO_INSTALL = %w[Rakefile README.md dotfile.rb]

PURPLE = "\e[0;35m"
BLUE   = "\e[0;34m"
WHITE  = "\e[0;37m"


task :default do

  Dir['*'].each do |file|
    next if FILES_NOT_TO_INSTALL.include?(file) || File.directory?(file)

    src    = File.join(Dir.pwd, file)
    target = Dotfile.symlink(src)

    if target then
      puts "#{PURPLE}#{target}#{WHITE} -> #{BLUE}#{file}#{WHITE}"
    else
      puts "dotfile for #{BLUE}#{file}#{WHITE} already exists"
    end
  end

end

