# nixchor

to be deterministic or imperative, that is the question.

**nixchor** is a nix-managed fork of
[petrichor](https://codeberg.org/oceanicc/petrichor) which (hopefully) sticks to
the original idea of user friendly, functional and clean dotfiles.

- Why? Because nix is an AWESOME packaging method, and its declarative nature is
  a nice addon.
- `petrichor` will still remain installable by (WIP) setup scripts.

## Prerequisites
- Tailscale auth key: `/etc/tailscale-key`
- Duckdns token: `/etc/duckdns-token`

## Secure-boot instructions

- Reboot into firmware and clear the Secure Boot keys ("Reset to Setup Mode" /
  "Clear all keys", not "restore factory defaults"), then boot back into NixOS
- Confirm `doas sbctl status | grep 'Setup Mode'` says `Enabled`
- Rebuild with `nixos-rebuild boot --sudo --flake .` (Important: `boot`, not
  `switch`). Limine's install hook generates the keys, enrolls them
  (`autoEnrollKeys`) and signs `BOOTX64.EFI` in this single run, so Setup Mode
  must already be active. This only happens when no keys exist yet: if an
  earlier attempt left `/var/lib/sbctl` behind, `doas rm -rf /var/lib/sbctl`
  first
- Before rebooting, ensure `doas sbctl status` shows `Setup Mode: Disabled`
  (PK enrolled) and `doas sbctl verify` lists Limine's `BOOTX64.EFI` as signed
- Reboot into firmware and enable secure boot
- After booting into your system, verify secure boot status with `doas sbctl
  status | grep 'Secure Boot'`

More information will be added later.
