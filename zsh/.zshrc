# 環境変数など
if [ -f ${ZDOTDIR}/.zsh_main ]; then
    source ${ZDOTDIR}/.zsh_main
fi

# zsh特有のオプションの設定
if [ -f ${ZDOTDIR}/.zsh_option ]; then
    source ${ZDOTDIR}/.zsh_option
fi

# エイリアスなど
if [ -f ${ZDOTDIR}/.zsh_alias ]; then
    source ${ZDOTDIR}/.zsh_alias
fi

######################################
# oh-my-zsh                          #
######################################

if [ -d ~/.oh-my-zsh ]; then
    # インストールディレクトリ
    export ZSH=${HOME}/.oh-my-zsh
    # テーマ
    ZSH_THEME="agnoster"
    # プラグイン
    plugins=(git zsh-syntax-highlighting)
    source $ZSH/oh-my-zsh.sh
fi

######################################
# Plugins                            #
######################################

# pyenvの状態をプロンプトに表示する
if [ -d ${ZDOTDIR}/plugins/zsh-python-prompt ]; then
    source ${ZDOTDIR}/plugins/zsh-python-prompt/zshrc.zsh
fi

######################################
# user command                       #
######################################

# Peco
bindkey '^]' peco-src

function peco-src() {
    local src=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        BUFFER="cd $src"
        zle accept-line
    fi
    zle -R -c
}
zle -N peco-src
