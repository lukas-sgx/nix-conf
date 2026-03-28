#!/usr/bin/sh

#exegol install
python3 -m venv ~/exegol-venv
source ~/.exegol-venv/bin/activate
pip install exegol
deactivate

exegol install free

#kind install
