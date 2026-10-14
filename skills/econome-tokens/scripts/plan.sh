#!/usr/bin/env bash
# Plan d'un fichier ou d'un dossier, pour ne lire que la partie utile.
# Usage : bash ~/.claude/skills/econome-tokens/scripts/plan.sh <fichier|dossier> [motif]
#
#   plan.sh src/app.ts          classes, fonctions, constantes + n° de ligne
#   plan.sh src/app.ts login    seulement les lignes du plan contenant « login »
#   plan.sh src                 lignes, Ko et nombre de fonctions de chaque fichier source
#
# Ensuite : Read avec offset/limit sur la plage voulue (élément suivant = fin de plage).

set -u
cible="${1:?fichier ou dossier requis}"
motif="${2:-}"

EXCLUS='/(node_modules|\.git|\.godot|dist|build|out|target|vendor|\.venv|venv|__pycache__|\.next|coverage)/'
SRC='\.(py|js|mjs|cjs|ts|tsx|jsx|gd|gdshader|go|rs|java|kt|cs|c|h|cpp|hpp|php|rb|swift|lua|vue|svelte|sh|md)$'
FN='^\s*((export |pub |public |private |protected |static |async |override )*(def|func|fn|function|class|struct|interface|enum|impl|trait|type)\b|(export )?const [A-Za-z_$]+ = (async )?(\(|function))'

if [ -d "$cible" ]; then
	find "$cible" -type f 2>/dev/null | grep -Ev "$EXCLUS" | grep -E "$SRC" | sort | while read -r f; do
		printf '%6d l %5d Ko %4d fn  %s\n' "$(wc -l < "$f")" "$(( $(wc -c < "$f") / 1024 ))" \
			"$(grep -cE "$FN" "$f")" "$f"
	done | head -300
	exit 0
fi

echo "# $cible ($(wc -l < "$cible") lignes, $(( $(wc -c < "$cible") / 1024 )) Ko)"
case "$cible" in
	*.md)  re='^#{1,4} ' ;;
	*.gd)  re='^(class_name|extends|signal|enum|const|static func|func|class) ' ;;
	*.json|*.yaml|*.yml|*.toml) re='^[^[:space:]]|^  [^[:space:]-]' ;;
	*)     re="$FN"'|^(const|let|var|export default|module\.exports|#define|import|from|use|package) ' ;;
esac
if [ -n "$motif" ]; then
	grep -nE "$re" "$cible" | grep -i -- "$motif"
else
	grep -nE "$re" "$cible" | grep -vE '^[0-9]+:\s*(import|from|use) ' | cut -c1-140 | head -400
fi
