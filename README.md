# nixchor

to be deterministic or imperative, that is the question.


**nixchor** is a nix-managed fork of [petrichor](https://codeberg.org/oceanicc/petrichor)
which (hopefully) sticks to the original idea of user friendly, functional and
clean dotfiles.
- Why? Because nix is an AWESOME packaging method, and its declarative nature is
a nice addon.
- `petrichor` will still remain installable by (WIP) setup scripts.

## Secure-boot instructions
- Put firmware in secure boot setup mode and reboot
- Rebuild configuration with `nixos-rebuild boot --sudo --flake .` (Important: `boot`, not `switch`)
- Reboot into firmware and enable secure boot
- Systemd-boot should throw a `Enabling secure boot` message
- After booting into your system, verify secure boot status with `doas sbctl status | grep 'Secure Boot'`

More information will be added later.
