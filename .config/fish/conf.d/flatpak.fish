# Replaces flatpak's /usr/share/fish/vendor_conf.d/flatpak.fish: fish skips a
# vendor conf.d file when this directory has one of the same name. That file
# runs `flatpak --installations`, about 0.1 s, in every fish, scripts
# included, only to add flatpak's directories to XDG_DATA_DIRS. The login
# session (/etc/profile.d/flatpak.sh, systemd's 60-flatpak generator) has
# normally done that already, so run it only when it has not.
#
# XDG_DATA_DIRS is still one colon-separated string here: fish only splits
# variables ending in PATH, and the vendor file makes it a path variable.
set -l data_dirs
if set -q XDG_DATA_DIRS; and test -n "$XDG_DATA_DIRS"
    set data_dirs (string split : -- $XDG_DATA_DIRS)
end

set -l data_home
if set -q XDG_DATA_HOME; and test -n "$XDG_DATA_HOME"
    set data_home $XDG_DATA_HOME
else
    set data_home $HOME/.local/share
end

if contains /var/lib/flatpak/exports/share $data_dirs
    and contains $data_home/flatpak/exports/share $data_dirs
    # As the vendor file does, so fish sees a list either way
    set -x --path XDG_DATA_DIRS $XDG_DATA_DIRS
else if test -r /usr/share/fish/vendor_conf.d/flatpak.fish
    source /usr/share/fish/vendor_conf.d/flatpak.fish
end
