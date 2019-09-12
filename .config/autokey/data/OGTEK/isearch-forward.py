import logging
import re

logging.basicConfig(level=logging.WARNING)

if re.match('.*(Chromium-browser)', window.get_active_class()):
    keyboard.send_keys('<ctrl>+f')
else:
    keyboard.send_keys('<ctrl>+s')
