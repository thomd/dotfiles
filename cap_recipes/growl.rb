# ~/.recipes/growl.rb
set :stage, nil unless defined? stage

namespace :growl do
  task :notify do
    growl_send(ENV["GROWL_MESSAGE"] || "wants your attention", 1)
  end

  task :alert do
    growl_send(ENV["GROWL_MESSAGE"] || "needs your attention", 2)
  end
end

after "deploy" do
  ENV["GROWL_MESSAGE"] = "deployed #{application} #{stage}"
  growl.notify
end

after "rollback" do
  ENV["GROWL_MESSAGE"] = "rolled back #{application} #{stage}"
  growl.alert
end

def growl_send(message, p = 1)
  require 'meow'
  icon = OSX::NSWorkspace.sharedWorkspace.iconForFile(`which cap`.chomp) 
  Meow.notify("cap", "Capistrano", message, :priority => p, :icon => icon)
rescue LoadError
  `growlnotify -ncap -p#{p} -m #{message.inspect} Capistrano`
end
