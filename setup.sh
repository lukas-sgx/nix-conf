/etc/profiles/per-user/lukas/bin/fish

#shell install
tide configure --auto \
        --style=Rainbow \
        --prompt_colors='True color' \
        --show_time='24-hour format' \
        --rainbow_prompt_separators=Round \
        --powerline_prompt_heads=Round \
        --powerline_prompt_tails=Round \
        --powerline_prompt_style='Two lines, character' \
        --prompt_connection=Disconnected \
        --powerline_right_prompt_frame=No \
        --prompt_spacing=Sparse \
        --icons='Many icons' \
        --transient=No

#exegol install
python3 -m venv ~/exegol-venv
~/exegol-venv/bin/pip install exegol