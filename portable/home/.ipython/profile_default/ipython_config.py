# Set line editing mode to vi-mode.
c.TerminalInteractiveShell.editing_mode = 'vi'

# Set default color scheme to native.
c.TerminalInteractiveShell.highlighting_style = 'native'

# Load and enable the autoreload extension.
c.InteractiveShellApp.extensions = ['autoreload']
c.InteractiveShellApp.exec_lines = [
    '%autoreload 2',
    'print("\\n\\x1b[31mWarning:\\x1b[0m disable autoreload in ipython_config.py to improve performance.")'
]
