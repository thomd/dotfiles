require "fileutils"

class Dotfile

  class << self
    attr_accessor :home
  end

  Dotfile.home = ENV['HOME']

  
  # set forcibly a symlink in user's home directory.
  def self.symlink!(src)
    target = Dotfile.target_of(src)
    FileUtils.ln_sf src, target
    target
  end

  # set a symlink in user's home directory only if missing
  def self.symlink(src)
    return false if Dotfile.symlinked?(src)
    Dotfile.symlink!(src)
  end

  # check if a dotfiles symlink already exist in user's home directory
  def self.symlinked?(src)
    target = Dotfile.target_of(src)
    File.symlink?(target) && File.identical?(src, target)
  end


  private

  # derive path of symlink to be set
  def self.target_of(src)
    File.join(Dotfile.home, ".#{File.basename(src)}")
  end
  

end