---
name: econome-tokens-fr
description: Règles pour économiser un maximum de tokens sur n'importe quel projet. À appliquer dès le début de toute tâche de code, de recherche, de débogage ou de vérification (lire du code, lancer des commandes ou des tests, prendre des captures, répondre), et quand l'utilisateur dit « économise les tokens », « moins de tokens », « sois bref », « mode économe » ou que le contexte devient long.
---

# Économe : un maximum de travail pour un minimum de tokens

Le gros du coût vient de **ce qui entre dans le contexte** (fichiers lus, sorties de commandes, images), puis de ce qui est écrit. Tout ce qui est lu reste payé à chaque tour suivant.

## 1. Lire juste ce qu'il faut

1. **Chercher avant de lire** : `Grep` avec un motif précis et un `glob` (`*.ts`, `*.py`…), d'abord en `files_with_matches`, puis `content` avec `-C 3` et `head_limit`.
2. **Voir la structure avant le contenu** : `bash ~/.claude/skills/econome-tokens-fr/scripts/plan.sh <fichier> [motif]` donne classes, fonctions et constantes avec leur n° de ligne. `plan.sh <dossier>` donne la taille de chaque fichier source (pour repérer les gros).
3. **Lire une plage** : `Read` avec `offset`/`limit` (de la fonction voulue à la suivante). Lire en entier seulement un petit fichier (< 300 lignes) ou un fichier qu'on réécrit.
4. **Ne jamais relire** un fichier déjà lu ou qu'on vient de modifier : `Edit` échoue de lui-même si le texte a changé.
5. **Ne jamais ouvrir** : fichiers générés ou minifiés, `package-lock.json`, `*.lock`, `dist/`, `build/`, `node_modules/`, `.git/`, caches, binaires, gros JSON/CSV de données (lire les 20 premières lignes avec `head` si besoin), images non demandées.
6. Docs et README longs : `plan.sh` (titres), puis la seule section utile.

## 2. Sorties de commandes courtes

- Toujours borner : `| tail -30`, `| head -50`, `| grep -E "error|fail|warn"`, `--quiet`, `-q`, `--silent`.
- Tests : n'afficher que les échecs et le résumé (`pytest -q --tb=short`, `npm test --silent 2>&1 | tail -40`, `go test ./... 2>&1 | grep -E "FAIL|ok"`). Relancer seulement le test qui échoue, pas toute la suite.
- Builds et installations : `2>&1 | tail -20`. Ne jamais afficher une installation complète.
- git : `git status --short`, `git diff --stat` avant un `git diff` ciblé (`git diff -- fichier`), `git log --oneline -10`.
- Logs : `grep` sur le motif, `tail`, jamais le fichier entier.
- `ls -R` ou `find` sans filtre : interdits sur un gros dossier ; utiliser `Glob` ou `plan.sh <dossier>`.

## 3. Vérifier sans gaspiller

- Une image coûte environ (largeur × hauteur) / 750 tokens : réduire les captures (fenêtre ou viewport plus petit, ou `zoom` sur une région) et n'en prendre qu'aux étapes clés.
- Navigateur : préférer `get_page_text`, `find` ou `read_page` (filtre `interactive`) à une capture.
- Regrouper plusieurs modifications avant de relancer l'appli ou la suite de tests. Logique pure : les tests suffisent, pas besoin de lancer l'appli.

## 4. Outils et agents

- Appels indépendants dans le même message (plusieurs `Grep`/`Read` en parallèle).
- Pas de sous-agent pour une recherche simple : il repart de zéro et relit tout. Un agent `Explore` seulement pour un balayage large dont seule la conclusion compte (ses lectures ne remplissent pas ce contexte).
- Pour une modification répétitive sur beaucoup de fichiers : un script (`sed`, petit script) plutôt que des dizaines d'`Edit`.
- Scripts jetables dans le scratchpad, pas dans le projet.
- Ne pas charger de skill ou d'outil différé qui ne sert pas à la tâche.

## 5. Répondre court

- La réponse d'abord, puis le pourquoi en une phrase, puis la suite éventuelle.
- Pas de préambule (« Je vais… », « Bien sûr »), pas de reformulation de la demande, pas de récapitulatif final, pas de formule de politesse.
- Code dans le chat : seulement les lignes changées + 1-2 lignes de contexte, jamais le fichier entier (le diff le montre déjà).
- Entre les appels d'outils : rien, ou une ligne par étape importante.
- Pas de tableau ni de liste décorative quand une phrase suffit.
- Exceptions, en phrases complètes : avertissement de sécurité, action irréversible, question posée à l'utilisateur, utilisateur qui ne comprend pas. Code, commentaires, commits et doc gardent leur style normal.

## 6. Contexte long

- Mémoire, CLAUDE.md et skills chargés à chaque session : les garder courts. Détails dans des fichiers de référence lus à la demande ; mettre à jour un fichier existant plutôt qu'en créer un.
- Changer de tâche : proposer `/clear` (nouvelle tâche sans lien) ou `/compact` (même tâche, contexte chargé). `/context` montre ce qui occupe le contexte.
- Ne pas répéter une recherche déjà faite dans la conversation : réutiliser le résultat.
