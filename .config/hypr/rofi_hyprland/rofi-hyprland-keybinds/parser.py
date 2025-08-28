#!/usr/bin/python3
from sys import argv
from os.path import expanduser

try:
    path = argv[1]
except IndexError:
    path = expanduser('~/.config/hypr/hyprland.conf')

with open(path, 'r') as config:
    for line in config:
        line = line.strip()
        if line.startswith('bind ='):
            # Example: bind = $mod, SHIFT, t, exec, kitty
            parts = [p.strip() for p in line.split('=', 1)[1].split(',')]

            if len(parts) < 2:
                continue

            # find where action starts (exec/workspace/movewindow/etc.)
            action_start = None
            for i, p in enumerate(parts):
                if p in ("exec", "workspace", "movewindow", "movefocus", "killactive"):
                    action_start = i
                    break

            if action_start is None:
                # fallback: assume last item is action
                action_start = len(parts) - 1

            # keys are everything before the action
            keys = '+'.join(parts[:action_start])

            # action is everything from action_start onward
            action_parts = parts[action_start:]
            if action_parts and action_parts[0] == "exec":
                action_parts = action_parts[1:]
            action = ' '.join(action_parts)

            # handle comments
            if '#' in action:
                action = action.split('#',1)[1].strip()

            # clean up $mod → mod
            keys = keys.replace('$','').lower()

            print(f"{keys}: {action}")

