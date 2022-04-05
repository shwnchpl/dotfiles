# tg configuration file.

import os

def get_pass(key):
    # Retrieve a key from the password store.
    return os.popen('pass show {} | head -n 1'.format(key)).read().strip()

PHONE = get_pass('personal/telegram-phone')
NOTIFY_CMD = '/sbin/notify-send "{title}: {msg}"'
DOWNLOAD_DIR = os.path.expanduser("~/downloads/tg")

CHAT_FLAGS = {
    "online": "●",
    "pinned": "P",
    "muted": "M",
    "unread": "U",
    "unseen": "✓",
    "secret": "🔒",
    "seen": "✓✓",
}
MSG_FLAGS = {
    "selected": "*",
    "forwarded": "F",
    "new": "N",
    "unseen": "U",
    "edited": "E",
    "pending": "...",
    "failed": "X",
    "seen": "✓✓",
}
