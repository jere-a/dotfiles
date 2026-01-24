alias rr="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias cls="clear"
alias npm="pnpm"
alias open="xdg-open"

# start kitty with command: kitty -o allow_remote_control=yes --listen-on unix:/tmp/kitty_remote_control
alias mpvk='kitty @ --to unix:'$XDG_RUNTIME_DIR'/kitty_remote_control launch --type=tab --title="mpv" --no-response /bin/bash -c "cd '$PWD' && mpv --vo=kitty $*"'

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
# VFIO GPU passthrough configuration
local gpu="0000:04:00.0"
local aud="0000:04:00.1"

function get_pci_ids {
  local device=$1
  if [[ ! -d "/sys/bus/pci/devices/$device" ]]; then
    print -u2 "PCI device not found: $device"
    return 1
  fi
  
  local vendor=$(cat "/sys/bus/pci/devices/$device/vendor" 2>/dev/null)
  local device_id=$(cat "/sys/bus/pci/devices/$device/device" 2>/dev/null)
  
  if [[ -z "$vendor" || -z "$device_id" ]]; then
    print -u2 "Failed to read PCI IDs for: $device"
    return 1
  fi
  
  print "$vendor $device_id"
}

function bind_vfio {
  local gpu_vd aud_vd
  
  gpu_vd=$(get_pci_ids "$gpu") || return 1
  aud_vd=$(get_pci_ids "$aud") || return 1
  
  # Check if vfio-pci driver is loaded
  if ! lsmod | grep -q vfio_pci; then
    print -u2 "vfio-pci driver not loaded"
    return 1
  fi
  
  # Unbind from current driver
  if [[ -d "/sys/bus/pci/devices/$gpu/driver" ]]; then
    echo "$gpu" > "/sys/bus/pci/devices/$gpu/driver/unbind" 2>/dev/null || {
      print -u2 "Failed to unbind GPU"
      return 1
    }
  fi
  
  if [[ -d "/sys/bus/pci/devices/$aud/driver" ]]; then
    echo "$aud" > "/sys/bus/pci/devices/$aud/driver/unbind" 2>/dev/null || {
      print -u2 "Failed to unbind audio"
      return 1
    }
  fi
  
  # Bind to vfio-pci
  echo "$gpu_vd" > /sys/bus/pci/drivers/vfio-pci/new_id 2>/dev/null || {
    print -u2 "Failed to bind GPU to vfio-pci"
    return 1
  }
  
  echo "$aud_vd" > /sys/bus/pci/drivers/vfio-pci/new_id 2>/dev/null || {
    print -u2 "Failed to bind audio to vfio-pci"
    return 1
  }
  
  print "VFIO binding completed successfully"
}

function unbind_vfio {
  local gpu_vd aud_vd
  
  gpu_vd=$(get_pci_ids "$gpu") || return 1
  aud_vd=$(get_pci_ids "$aud") || return 1
  
  # Remove from vfio-pci
  echo "$gpu_vd" | sudo tee "/sys/bus/pci/drivers/vfio-pci/remove_id" >/dev/null || {
    print -u2 "Failed to remove GPU from vfio-pci"
    return 1
  }
  
  echo "$aud_vd" | sudo tee "/sys/bus/pci/drivers/vfio-pci/remove_id" >/dev/null || {
    print -u2 "Failed to remove audio from vfio-pci"
    return 1
  }
  
  # Remove devices
  echo 1 | sudo tee "/sys/bus/pci/devices/$gpu/remove" >/dev/null || {
    print -u2 "Failed to remove GPU"
    return 1
  }
  
  echo 1 | sudo tee "/sys/bus/pci/devices/$aud/remove" >/dev/null || {
    print -u2 "Failed to remove audio"
    return 1
  }
  
  # Rescan PCI bus
  echo 1 | sudo tee "/sys/bus/pci/rescan" >/dev/null || {
    print -u2 "Failed to rescan PCI bus"
    return 1
  }
  
  print "VFIO unbinding completed successfully"
}







# Christitus specific
# Edit this .bashrc file
alias ebrc='edit ~/.bashrc'
alias ezrc='edit ~/.zshrc'

# Show help for this .bashrc file
# alias hlp='less ~/.bashrc_help'

# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias apt-get='sudo apt-get'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias vi='nvim'
alias svi='sudo vi'
alias vis='nvim "+set si"'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# cd into the old directory
alias bd='cd "$OLDPWD"'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias la='ls -Alh'                # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh'               # sort by extension
alias lk='ls -lSrh'               # sort by size
alias lc='ls -lcrh'               # sort by change time
alias lu='ls -lurh'               # sort by access time
alias lr='ls -lRh'                # recursive ls
alias lt='ls -ltrh'               # sort by date
alias lm='ls -alh |more'          # pipe through 'more'
alias lw='ls -xAh'                # wide listing format
alias ll='ls -Fls'                # long listing format
alias labc='ls -lap'              #alphabetical sort
alias lf="ls -l | egrep -v '^d'"  # files only
alias ldir="ls -l | egrep '^d'"   # directories only

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Show open ports
alias openports='netstat -nape --inet'

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
alias sha1='openssl sha1'

alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'

