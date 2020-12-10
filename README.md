```
 ▄▄                            ▄▄▄▄▄▄       ██
 ██                            ██▀▀▀▀█▄     ▀▀
 ██▄████▄   ▄█████▄  ██▄███▄   ██    ██   ████
 ██▀   ██   ▀ ▄▄▄██  ██▀  ▀██  ██████▀      ██
 ██    ██  ▄██▀▀▀██  ██    ██  ██           ██
 ██    ██  ██▄▄▄███  ███▄▄██▀  ██        ▄▄▄██▄▄▄
 ▀▀    ▀▀   ▀▀▀▀ ▀▀  ██ ▀▀▀    ▀▀        ▀▀▀▀▀▀▀▀
                     ██
```

# Raspberry Pi kiosk playbook

This repository contains an Ansible playbook used to set up a Raspberry Pi
kiosk showing a full-screen webpage in Firefox ESR.

## Setup instructions

See [INSTALLING](INSTALLING.md).

## Remote Access (on the Sticky network)

`ssh -p 2200 pi@stickykamer.mynetgear.com`

## Remote Access (outside the Sticky network)

1. Log in via SSH at solisid@gemini.science.uu.nl and add your ssh key to the server.
2. Add this to your `~/.ssh/config`:

```
Host gemini.science.uu.nl
User solisnummer

Host tunnel-radio
User pi
Hostname stickykamer.mynetgear.com
Port 2200
ProxyJump gemini.science.uu.nl
```

`ssh -p 2200 pi@tunnel-radio`
