{ ... }:

{
    programs.bash = {
	    enable = true;
	    initExtra = ''fastfetch'';
        bashrcExtra = ''
            export PS1="\[\033[38;5;4m\]\u@\h \w \$ \[\033[0m\]"
        '';
    };
}
