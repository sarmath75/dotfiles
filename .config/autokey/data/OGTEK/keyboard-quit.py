import logging
import re
import time

logging.basicConfig(level=logging.WARNING)

if re.match('.*(Emacs|konsole)', window.get_active_class()):
    keyboard.send_keys('<ctrl>+g')
    time.sleep(0.050)
    keyboard.send_keys('<ctrl>+g')
    # keyboard.send_keys('<escape>')
else:
    keyboard.send_keys('<escape>')
