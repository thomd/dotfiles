require "rubygems"
require "fileutils"
require File.dirname(__FILE__) + "/../dotfile"

describe Dotfile do

  before :each do
    @home = File.join(Dir.pwd, "_test")
    @dir = File.join(@home, "dotfiles")
    Dotfile.home = @home

    FileUtils.mkdir_p @dir                          # mock a directory

    @src = File.join(@dir, "test_file")             # path of a source file
    FileUtils.touch @src                            # mock source file which is not symlinked
    @target = File.join(@home, ".test_file")        # path of a target file

    @src2 = File.join(@dir, "test_file_2")          # path of an other source file
    FileUtils.touch @src2                           # mock source file which is already symlinked in user's home
    @target2 = File.join(@home, ".test_file_2")     # path of an other target file
    FileUtils.ln_s @src2, @target2                  # mock target file which already exists in user's home
  end
  
  it "should check if a dotfile has a link in user's home" do
    Dotfile.symlinked?(@src2).should == true
    Dotfile.symlinked?(@src).should == false
  end
  
  it "should forcibly set a symlink in user's home" do
    File.symlink?(@target2).should be_true               # target2 is a dotfile-symlink ...
    Dotfile.symlink(@src2).should be_false               # .... so,  do not set it again
    Dotfile.symlink!(@src2).should == @target2           # but set it  forcibly!
  end
  
  it "should set a symlink in user's home" do
    File.symlink?(@target).should be_false
    Dotfile.symlink(@src)
    File.symlink?(@target).should be_true
  end
  
  it "should set a symlink in user's home only if missing" do
    Dotfile.symlink(@src).should == @target              # create symlink
    Dotfile.symlink(@src).should be_false                # symlink was already created, so do not create symlink now
    lambda { Dotfile.symlink(@src) }.should_not raise_error(Errno::EEXIST)   # do not raise error if symlink exists, just return bool 
  end

  it "should replace a symlink if symlink does not point to its dotfile" do
    FileUtils.ln_sf @src, @target2                       # set a symlink to wrong target
    Dotfile.symlinked?(@src).should be_false
    Dotfile.symlink(@src).should == @target
    Dotfile.symlinked?(@src).should be_true
  end  

  after :each do
    FileUtils.rm @src
    FileUtils.rm @target if File.symlink?(@target)
    FileUtils.rm @src2
    FileUtils.rm @target2
    FileUtils.rm_r @home
  end
  
end
