# nixchor

to be deterministic or imperative, that is the question.

**nixchor** is a [finix](https://github.com/finix-community/finix)-based fork of
[petrichor](https://codeberg.org/oceanicc/petrichor) which (hopefully) sticks to
the original idea of user friendly, functional and clean dotfiles.

- Why? Because nix is an AWESOME packaging method, and its declarative nature is
  a nice addon.
- Why finix? One of the biggest weaknesses of `nixos` has always been it's
  imperative module imports. Finix solves that by leaving everything opt-out,
  and providing abstractions for common modules such as `firewalls` and `inits`.
- `petrichor` will still remain installable by (WIP) setup scripts.

> [!NOTE]
> looking for a vanilla `nixos` configuration? check out [nixos](../nixos),
> but please don't use it, it's not maintained anymore.

---

## Info

| nixchor   | utils                                                   |
| --------- | ------------------------------------------------------- |
| init      | finit / dinit (user services)                           |
| boot      | limine (opt: secure-boot)                               |
| coreutils | chimerautils                                            |
| network   | iwd (opt: dhcpcd)                                       |
| cron      | fcron                                                   |
| logger    | sysklogd                                                |
| session   | elogind / seatd (WIP)                                   |
| device    | eudev / mdevd (WIP)                                     |
| greeter   | tuigreet                                                |
| container | docker (WIP)                                            |

> [!NOTE]
> Session manager follows your device manager.
> `eudev` --> `elogind` (or) `mdev` --> `seatd`.
> In order to switch stacks, simply switch your device manager.

---

## Prerequisites

For `misato` (my homelabs):
- Tailscale auth key: `/etc/tailscale-key`
- Duckdns token: `/etc/duckdns-token`

---

## Installation

Unfortunately `finix` doesn't have a native installer right now, so you'll have
to bootstrap it from a `nixos` image. However it's a fairly straightforward
method to install finix (with a flake-based setup such as mine) by following
the instructions given on their docs -
[installation](https://finix-community.github.io/finix/installation.html).

---

## Secure-boot instructions

- Reboot into firmware and clear the Secure Boot keys ("Reset to Setup Mode" /
  "Clear all keys", not "restore factory defaults"), then boot back into Finix
- Confirm `doas sbctl status | grep 'Setup Mode'` says `Enabled`
- Rebuild with `nixos-rebuild boot --sudo --flake .` (Important: `boot`, not
  `switch`). Limine's install hook generates the keys, enrolls them
  (`autoEnrollKeys`) and signs `BOOTX64.EFI` in this single run, so Setup Mode
  must already be active. This only happens when no keys exist yet: if an
  earlier attempt left `/var/lib/sbctl` behind, `doas rm -rf /var/lib/sbctl`
  first
- Before rebooting, check `doas sbctl status` shows `Setup Mode: Disabled`
  (PK enrolled) and `doas sbctl verify` lists Limine's `BOOTX64.EFI` as signed
- Reboot into firmware and enable secure boot (separate toggle from Setup Mode)
- After booting into your system, verify secure boot status with `doas sbctl
  status | grep 'Secure Boot'`

---

## TODO

Some experiments I haven't gotten to yet:

- [ ] try [generic-services](https://github.com/parzivale/finix/tree/generic-services)
      with `dinit` or `sinit`
- [ ] try [hjem](https://hjem.feel-co.org) for pure-nix dotfiles
- [ ] configure [sops](https://github.com/mic92/sops-nix) for secrets management
- [ ] custom kernel
- [ ] flesh out `mdevd + seatd` stack for `nixey`
- [ ] switch from `elogind` to `sessiond + zzz`
- [ ] try out `keventd` and `gardendevd`
- [ ] explore overlays made by the [finix community](https://discord.gg/nVe5Zkaypg)
- [x] package `chimerautils` to replace `busybox`
- [ ] restructure repo to allow for drop-in config switches
- [ ] add a river config aiming to be super minimal
