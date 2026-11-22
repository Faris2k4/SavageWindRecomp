#!/bin/sh
set -eu

PROFILE="${1:-}"
case "$PROFILE" in
    1.5x|2x|5x|10x|infinite) ;;
    *) echo "Usage: $0 1.5x|2x|5x|10x|infinite" >&2; exit 2 ;;
esac

if [ -n "${SAVAGEWIND_DATA_ROOT:-}" ]; then
    DATA_ROOT="$SAVAGEWIND_DATA_ROOT"
elif [ -f "$XDG_DATA_HOME/savagewind/savagewind.ini" ]; then
    DATA_ROOT="$XDG_DATA_HOME/savagewind"
elif [ -f "$HOME/.local/share/savagewind/savagewind.ini" ]; then
    DATA_ROOT="$HOME/.local/share/savagewind"
else
    DATA_ROOT="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
fi

INI="$DATA_ROOT/savagewind.ini"
SOURCE="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)/profiles/$PROFILE.ini"
[ -f "$INI" ] || { echo "savagewind.ini not found at $INI" >&2; exit 1; }

cp "$INI" "$INI.durability-mod.bak"
grep -v -E '^[[:space:]]*(weapon_wear|no_weapon_wear)[[:space:]]*=' "$INI" > "$INI.tmp"
cat "$SOURCE" >> "$INI.tmp"
mv "$INI.tmp" "$INI"
echo "Applied $PROFILE durability profile to $INI"
