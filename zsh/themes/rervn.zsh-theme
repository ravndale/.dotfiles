#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# ReRVN - A minimal and beautiful theme for oh-my-zsh
#
# Based on the custom Zsh-prompt named Pure.
#
# Pure prompt is the custom Zsh-prompt of the same name by Sindre Sorhus. A huge
# thanks goes out to him for designing the fantastic Pure prompt in the first
# place! I'd also like to thank Julien Nicoulaud for his "nicoulaj" theme from
# which I've borrowed both some ideas and some actual code. You can find out
# more about both of these fantastic two people here:
#
# Ravendale
#   GitHub:   https://github.com/ravndale
#   Twitter:  https://twitter.com/ravndale
#
# Sindre Sorhus
#   GitHub:   https://github.com/sindresorhus
#   Twitter:  https://twitter.com/sindresorhus
#
# Julien Nicoulaud
#   GitHub:   https://github.com/nicoulaj
#   Twitter:  https://twitter.com/nicoulaj

#
# ------------------------------------------------------------------------------

# Set required options
#
setopt prompt_subst

# Display information about the current repository
#
repo_information() {
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    
    local repo_branch
    local repo_last_commit
    local repo_stat

    # Get git repo branch
    if git branch --show-current &>/dev/null; then
        repo_branch=$(git branch --show-current)
        
        if git show-ref --verify --quiet refs/remotes/origin/$branch; then
            local local_count=$(git rev-list --count HEAD)
            local remote_count=$(git rev-list --count origin/$repo_branch)
            
            if [[ $local_count -gt $remote_count ]]; then
                repo_stat=" ahead by $((local_count - remote_count))"
            elif [[ $local_count -lt $remote_count ]]; then
                repo_stat=" behind by $((remote_count - local_count))"
            else
                repo_stat=" up-to-date"
            fi
        fi

    else
        repo_branch="detached"
    fi

    if git log -1 &>/dev/null; then;
        local hash=$(git log -1 --format=%H)
        repo_last_commit="$hash"
    else
        repo_last_commit="no history"
    fi

    echo "(%F{blue}$repo_branch$repo_stat/$repo_last_commit%f)"
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=$(date +%s%N)
    local start=${cmd_timestamp:-$stop}
    local elapsed=$(( (stop - start) / 1000000 ))
    if [ $elapsed -gt 0 ]; then
        if (( elapsed < 100 )); then
            echo "%fit took %F{yellow}~${elapsed}%fms %F{green}(fast as fuck)%f"
        elif (( elapsed < 500 )); then
            echo "%fit took %F{yellow}~${elapsed}%fms %F{blue}(fast)%f"
        elif (( elapsed < 1000 )); then
            echo "%fit took %F{yellow}~${elapsed}%fms %F{yellow}(meh)%f"
        elif (( elapsed < 5000 )); then
            echo "%fit took %F{yellow}~${elapsed}%fms %F{8}(slow)%f"
        else
            echo "%fit took %F{yellow}~${elapsed}%fms %F{8}(snail speed)%f"
        fi
    fi
}

# Get the initial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=$(date +%s%N)
}

# Output additional information about paths, repos and exec time
#
precmd() {
    setopt localoptions nopromptsubst
    print -P "\n  %B%F{red}%n %fat %c$(repo_information) %F{yellow}$(cmd_exec_time)%f%b"
    unset cmd_timestamp #Reset cmd exec time.
}

# Define prompts
#
PROMPT="%(?.%F{green}.%F{red}) %# %f  %f"        # Display a red prompt char on failure
RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"              # Display username if connected via SSH
