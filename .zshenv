#path
export PATH="$HOME/.local/bin:$PATH"

# cleanup
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_STATE_HOME="$HOME"/.local/state
export XDG_DATA_DIR=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export STACK_ROOT="$XDG_DATA_HOME"/stack
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export ZDOTDIR=$HOME/.config/zsh
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export FFMPEG_DATADIR="$XDG_CONFIG_HOME"/ffmpeg
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export TEXMFHOME=$XDG_DATA_HOME/texmf
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
# export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# export KUBECONFIG="$XDG_CONFIG_HOME/kube"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export EDITOR="nvim"
export PAGER="less"
export VISUAL="nvim"
export BROWSER="firefox"
. "/home/smai/.local/share/cargo/env"
export FZF_DEFAULT_COMMAND="find ."
export TERMINAL=/usr/bin/alacritty
export GTK_THEME=Adwaita:dark
export MANPAGER='nvim +Man!'

export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export LC_CTYPE=en_US.UTF-8

export XDEB_OPT_DEPS=true
export XDEB_OPT_SYNC=true
export XDEB_OPT_WARN_CONFLICT=true
export XDEB_OPT_FIX_CONFLICT=true

export PATH="$PATH:/home/smai/programming/flutter/bin"
