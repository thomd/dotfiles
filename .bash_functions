# vim:ft=sh


# list all folders in PATH environment variable more readable (non existent folders in red)
#
function paths {
  IFS=$':'
  for i in $PATH; do if [ -d $(eval echo $i) ]; then echo $i; else echo -e "\033[0;31m$i\033[0m"; fi; done;
  unset IFS
}


#
# create temporary scratch directory [inspired by http://ku1ik.com/2012/05/04/scratch-dir.html]
#
export SCRATCH_HOME="$HOME/scratch"
[[ -h $SCRATCH_HOME && ! -d $SCRATCH_HOME ]] && rm $SCRATCH_HOME     # delete scratch link if scratch folder doesn't exist anymore

function scratch {
  local NEW="/tmp/scratch-`date +'%s'`"                              # scratch folder with timestamp in /tmp. will be deleted after system reboot
  mkdir -p $NEW                                                      # create scratch folder
  ln -nfs $NEW $SCRATCH_HOME                                         # symlink to scratch folder
  cd $SCRATCH_HOME                                                   # cd into scratch folder
  if [ -n "$TMUX" ]; then
    tmux rename-window 'scratch';                                    # set tmux window
  fi
}

alias s="scratch $@"


#
# colored ant
#
function antc {
  if [ -n "$1" ]; then
    ant $1 | colored-ant.pl;
  else
    ant | colored-ant.pl;
  fi;
}


#
# mkdir & cd
#
function mkcd {
  mkdir -p "$@" && cd "$_"
}


#
# mvd - move down
# move all files & folders in current directory into a new folder one hierarchy down
#
# EXAMPLE
#
#   > tree
#   .
#   ├── .bar
#   └── baz
#
#   > mvd foo
#   > tree
#   .
#   └── foo
#       ├── .bar
#       └── baz
#
function mvd {
  if [ ! -z "$1" ] && [ "$(ls -A)" ]; then  # if argument given and folder not empty
    local tmp=`mktemp -d mvdXXXX`
    mkdir -p "$tmp"
    for f in $(ls -A); do
      [ "$f" != "$tmp" ] && mv "$f" "$tmp"
    done
    mv "$tmp" "$1"
  else
    echo "usage: mvd <folder>"
  fi
}


#
# mvu - move up
# move all files & folders in a folder one hierarchy up and deletes the - now empty - folder
#
# EXAMPLE
#
#   > tree
#   .
#   └── foo
#       ├── .bar
#       └── baz
#
#   > mvu foo
#   > tree
#   .
#   ├── .bar
#   └── baz
#
function mvu {
  if [ ! -z "$1" ] && [ -d "$1" ]; then  # if argument given and folder exist
    for f in $(ls "$1"); do
      mv "$1/$f" "$PWD"
    done
    rm -r "$1"
  else
    echo "usage: mvu <folder>"
  fi
}


#
# find folder depth
#
function ffd {
  if [ "$1" == "-v" ]; then
    {
      echo "folders depth"
      find . -type d 2>/dev/null | awk -F'/' '{print NF -1}' | sort | uniq -c | sort -nk2
    } | column -t
  else
    find . -type d 2>/dev/null | awk -F'/' '{print NF-1}' | sort -n | tail -1
  fi
}


# open my side-projects file
function projects {
  ${EDITOR:-vi} "/develop/PROJECTS"
}


# cd to project root (determined .git folder)
function p {
  local root=`git root`
  [ `pwd` = "$root" ] && echo -e "${GREY}this is project root"
  cd "$root"
}





