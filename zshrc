# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

# Enable Powerlevel10k instant prompt. Should stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
source /home/anonimo/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Manual configuration

PATH=/root/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

# Manual aliases
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias cat='batcat'
alias luceson="xset led on"
alias lucesoff="xset led off"
alias operadores_bash='cat /arch/.operadores_bash.txt'
alias miip='echo; for miip in $(cat /etc/hosts  | grep localhost | awk "NR==1" | cut -d " " -f "1-1"); do echo -e "\e[33m[]\e[0mIP : \e[4;35m$miip\e[0m";done ; echo'
alias minicraft='echo -e "\n\e[37m[*]\e[0m\e[32mIniciando.\e[0m\n" && java -jar /root/tlauncher/TLauncher-2.86.jar 2>/dev/null >/dev/null && sudo exit'
alias soundhdmi="pavucontrol"
alias screenhdmi="arandr"
alias cat="batcat"
alias toor="~/.local/share/applications/start-tor-browser.desktop"
alias subemeesto=githubSendCommit
alias c=compilerC
alias ngrok='~/.ngrok/ngrok'
alias headscripting="/bin/cat /home/anonimo/.scripting/head.shell | xclip -sel clip"
alias googletor='~/.tor-browser_es-ES/start-tor-browser.desktop'
alias cerrar="ps | grep zsh | awk 'NF{print $1}' FS=' '  | xargs kill -9"
alias initserver="clear ; sudo jekyll serve --watch --port 80"
function githubSendCommit(){

	echo -e "\e[34m Subiendo esto\e[0m"
	echo "bash /.accesTokenGithub.sh" | xargs sudo 
	git add /home/anonimo/.page/h4cker-0.github.io
	git commit -m "Actualizacion1"
	git push -u origin
	
}


function compilerC(){
	nameFile=$1
	g++ $nameFile
	./a.out ; echo 
	
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Aliases apache

alias apachestart='systemctl start httpd.service'
alias apachestop='systemctl stop httpd.service'
alias apachestatus='systemctl status httpd.service'
alias apacherestar='systemctl restart httpd.service'
alias apachefolder='echo -e "\n\e[35m[*]Ruta :\e[0m\e[4;34m /srv/http/\n" && echo "/srv/http/"  | xclip -sel clip -rmlastnl '



# Plugins


source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/zsh-sudo/sudo.plugin.zsh


# Functions
function mkt(){
	mkdir {nmap,content,exploits,scripts}
}

# Extract nmap information
function extractPorts(){
	ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
	ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
	echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
	echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
	echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
	echo $ports | tr -d '\n' | xclip -sel clip
	echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
	cat extractPorts.tmp; rm extractPorts.tmp
}

# Set 'man' colors
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
function fzf-lovely(){

	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
 	                echo {} is a binary file ||
	                 (bat --style=numbers --color=always {} ||
	                  highlight -O ansi -l {} ||
	                  coderay {} ||
	                  rougify {} ||
	                  cat {}) 2> /dev/null | head -500'

	else
	        fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
	                         echo {} is a binary file ||
	                         (bat --style=numbers --color=always {} ||
	                          highlight -O ansi -l {} ||
	                          coderay {} ||
	                          rougify {} ||
	                          cat {}) 2> /dev/null | head -500'
	fi
}

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

# Finalize Powerlevel10k instant prompt. Should stay at the bottom of ~/.zshrc.
(( ! ${+functions[p10k-instant-prompt-finalize]} )) || p10k-instant-prompt-finalize

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line 
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
#source ~/.powerlevel10k/.powerlevel10k.zsh-theme
#source ~/powerlevel10k/.powerlevel10k.zsh-theme
source ~/powerlevel10k/powerlevel10k.zsh-theme
