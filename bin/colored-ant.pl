#!/usr/bin/perl -w
#
# colorize ant output for the sake of readability
#
# based on http://devblog.cellls.com/?p=53
#
# Installation:
#    chmod 755 ~/bin/colored-ant.pl
#    alias ant="ant | ./colored-ant.pl"
#

use Term::ANSIColor;
use strict;

$Term::ANSIColor::AUTORESET++;         # reset color after each print
$SIG{INT} = sub { print "\n"; exit; }; # reset color after Ctrl-C
$| = 1;                                # unbuffer STDOUT;

my %rules = (
              '^\S+:'                             => "green",
              '^\s*\[.*?\]\s+'                    => "blue",           # find everything that contains "error" except "error: 0"
              '[Ee]rror(?!s: 0)(s)?'              => "bold red",       # find everything that contains "fail" except "failures: 0"
              '[Ff]ail(?!ures: 0)(ure)?(ed)?(s)?' => "bold red",
              '(\d+\s*)?([Ww]arnings?|[Ww]arn)'   => "yellow",
              'Exception'                         => "bold red",
              'INFO.*'                            => "bold",
              'ERROR.*'                           => "red bold",
              'FATAL.*'                           => "blink bold red",
              'DEBUG.*'                           => "clear",
              '^BUILD SUCCESSFUL'                 => "on_green bold black"
             );

while (<>) {
   study;
   my $regex;
   foreach $regex (keys %rules) {
      s/$regex/colored($&,$rules{$regex})/ge;
   }
   print;
}

