# econome-tokens

Skill pour Claude Code (et autres agents compatibles) qui **économise un maximum de tokens** sur n'importe quel projet :

- lire seulement la partie utile d'un fichier, avec `scripts/plan.sh` qui donne le plan d'un fichier avec les numéros de ligne (environ 8 fois moins de texte que le fichier entier) ;
- sorties de tests, builds, git et logs coupées à l'essentiel ;
- captures d'écran rares et réduites ;
- pas de sous-agents inutiles ;
- réponses courtes, sans préambule ni récapitulatif ;
- bonne gestion d'un contexte long (`/clear`, `/compact`, `/context`).

## Installation

```bash
npx -y skills add clocloRA35132125/econome-tokens --skill econome-tokens --agent claude-code
```

Ou à la main : copier `skills/econome-tokens/` dans `~/.claude/skills/`.

Pour que les règles s'appliquent à chaque session, ajouter cette ligne dans `~/.claude/CLAUDE.md` :

```
Applique toujours le skill econome-tokens.
```

## Licence

MIT
