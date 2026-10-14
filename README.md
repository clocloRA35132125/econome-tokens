# econome-tokens

**[English](#english) · [Français](#français)**

## English

A skill for Claude Code (and other compatible agents) that **saves as many tokens as possible** on any project:

- read only the useful part of a file, with `scripts/plan.sh`, which outlines a file with line numbers (about 8× less text than the whole file);
- test, build, git and log output trimmed to what matters;
- few, small screenshots;
- no needless sub-agents;
- short replies, no preamble or recap;
- long-context hygiene (`/clear`, `/compact`, `/context`).

### Install

```bash
npx -y skills add clocloRA35132125/econome-tokens --skill econome-tokens --agent claude-code
```

Or by hand: copy `skills/econome-tokens/` into `~/.claude/skills/`.

To apply the rules in every session, add this line to `~/.claude/CLAUDE.md`:

```
Always apply the econome-tokens skill.
```

## Français

Un skill pour Claude Code (et autres agents compatibles) qui **économise un maximum de tokens** sur n'importe quel projet :

- lire seulement la partie utile d'un fichier, avec `scripts/plan.sh`, qui donne le plan d'un fichier avec les numéros de ligne (environ 8 fois moins de texte que le fichier entier) ;
- sorties de tests, builds, git et logs coupées à l'essentiel ;
- captures d'écran rares et réduites ;
- pas de sous-agents inutiles ;
- réponses courtes, sans préambule ni récapitulatif ;
- bonne gestion d'un contexte long (`/clear`, `/compact`, `/context`).

### Installation

```bash
npx -y skills add clocloRA35132125/econome-tokens --skill econome-tokens-fr --agent claude-code
```

Ou à la main : copier `skills/econome-tokens-fr/` dans `~/.claude/skills/`.

Pour que les règles s'appliquent à chaque session, ajouter cette ligne dans `~/.claude/CLAUDE.md` :

```
Applique toujours le skill econome-tokens-fr.
```

## License / Licence

MIT
