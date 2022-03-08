# Sunrise theme for oh-my-zsh
# Intended to be used with Solarized: https://ethanschoonover.com/solarized

# Color shortcuts
R=$fg_no_bold[red]
BOLD_R=$fg_no_bold[red]
G=$fg_no_bold[green]
BOLD_G=$fg_bold[green]
M=$fg_no_bold[magenta]
BOLD_M=$fg_bold[magenta]
Y=$fg_no_bold[yellow]
BOLD_Y=$fg_bold[yellow]
B=$fg_no_bold[blue]
BOLD_B=$fg_bold[blue]
Orange=$fg_no_bold[blue]
RESET=$reset_color
START_COLOR=3
END_COLOR=5


if [ "$USER" = "root" ]; then
    PROMPTCOLOR="%{$R%}" PROMPTPREFIX="! ▬";
else
    PROMPTCOLOR="" PROMPTPREFIX="%B%F{4}●%B%F{5}";
fi

local return_code="%(?..%{$R%}%? ↵%{$RESET%})"

# Get the status of the working tree (copied and modified from git.zsh)
custom_git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  # Non-staged
  NON_STAGE=""
  if $(echo "$INDEX" | grep '^?? ' &> /dev/null); then
    NON_STAGE="$ZSH_THEME_GIT_PROMPT_UNTRACKED$NON_STAGE"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    NON_STAGE="$ZSH_THEME_GIT_PROMPT_UNMERGED$NON_STAGE"
  fi
  if $(echo "$INDEX" | grep '^ D ' &> /dev/null); then
    NON_STAGE="$ZSH_THEME_GIT_PROMPT_DELETED$NON_STAGE"
  fi
  if $(echo "$INDEX" | grep '^.M ' &> /dev/null); then
    NON_STAGE="$ZSH_THEME_GIT_PROMPT_MODIFIED$NON_STAGE"
  elif $(echo "$INDEX" | grep '^AM ' &> /dev/null); then
    NON_STAGE="$ZSH_THEME_GIT_PROMPT_MODIFIED$NON_STAGE"
  elif $(echo "$INDEX" | grep '^ T ' &> /dev/null); then
    NON_STAGE="$ZSH_THEME_GIT_PROMPT_MODIFIED$NON_STAGE"
  fi
  # Staged
  STAGE=""
  if $(echo "$INDEX" | grep '^D  ' &> /dev/null); then
    STAGE="$ZSH_THEME_GIT_PROMPT_STAGED_DELETED$STAGE"
  fi
  if $(echo "$INDEX" | grep '^R' &> /dev/null); then
    STAGE="$ZSH_THEME_GIT_PROMPT_STAGED_RENAMED$STAGE"
  fi
  if $(echo "$INDEX" | grep '^M' &> /dev/null); then
    STAGE="$ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED$STAGE"
  fi
  if $(echo "$INDEX" | grep '^A' &> /dev/null); then
    STAGE="$ZSH_THEME_GIT_PROMPT_STAGED_ADDED$STAGE"
  fi

  
  if [[ ${#NON_STAGE} > 0 && ${#STAGE} > 0 ]]; then
    STATUS="${STAGE} ${NON_STAGE}"
  else
    STATUS="${STAGE}${NON_STAGE}"
  fi

  if $(echo -n "$STATUS" | grep '.*' &> /dev/null); then
    STATUS="$ZSH_THEME_GIT_STATUS_PREFIX$STATUS"
  fi

  echo $STATUS
}

# get the name of the branch we are on (copied and modified from git.zsh)
function custom_git_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_prompt_ahead)$(custom_git_prompt_status)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

get_date() {
    echo $(date +'%H:%M:%S')
}

# %B sets bold text
PROMPT='%B%F{$START_COLOR}$PROMPTPREFIX %2~ $(custom_git_prompt)%{$M%}%B%b%f%{$reset_color%} ' # »
RPS1='${return_code} %F{$END_COLOR}■ %F{243}$(get_date)%f%{$reset_color%}'

#  
ZSH_THEME_GIT_PROMPT_PREFIX="%B%{$BOLD_G%}" # 
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$BOLD_G%}%{$RESET%} " # ›  

#ZSH_THEME_GIT_PROMPT_DIRTY="%{$BOLD_R%} ✗"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$BOLD_R%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$BOLD_B%} "

ZSH_THEME_GIT_PROMPT_AHEAD="%B%{$BOLD_G%}" # ➔"


ZSH_THEME_GIT_STATUS_PREFIX=" "

# Staged
ZSH_THEME_GIT_PROMPT_STAGED_ADDED="%{$BOLD_Y%}[a]" #
ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED="%{$BOLD_Y%}[m]"
ZSH_THEME_GIT_PROMPT_STAGED_RENAMED="%{$BOLD_Y%}[r]"
ZSH_THEME_GIT_PROMPT_STAGED_DELETED="%{$BOLD_Y%}[d]"

# Not-staged   
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$BOLD_R%}+" # ?
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$BOLD_R%}" # ~
ZSH_THEME_GIT_PROMPT_DELETED="%{$BOLD_R%}-" # !
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$R%}u" # U
