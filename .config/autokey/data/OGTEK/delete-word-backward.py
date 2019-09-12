import logging
import re

logging.basicConfig(level=logging.WARNING)

if re.match('.*(Emacs|konsole)', window.get_active_class()):
    keyboard.send_keys('<alt>+<backspace>')
else:
    keyboard.send_keys('<ctrl>+<backspace>')
