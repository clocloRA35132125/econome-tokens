---
name: econome-tokens
description: Rules to save as many tokens as possible on any project. Apply from the start of every coding, research, debugging or verification task (reading code, running commands or tests, taking screenshots, replying), and when the user says "save tokens", "fewer tokens", "be brief", "token saver mode", or the context is getting long.
---

# Econome: maximum work for minimum tokens

Most of the cost comes from **what enters the context** (files read, command output, images), then from what is written. Everything read is paid again on every following turn.

## 1. Read only what you need

1. **Search before reading**: `Grep` with a precise pattern and a `glob` (`*.ts`, `*.py`…), first as `files_with_matches`, then `content` with `-C 3` and `head_limit`.
2. **See the structure before the content**: `bash ~/.claude/skills/econome-tokens/scripts/plan.sh <file> [pattern]` lists classes, functions and constants with line numbers. `plan.sh <folder>` shows the size of each source file (to spot the big ones).
3. **Read a range**: `Read` with `offset`/`limit` (from the wanted function to the next one). Read a whole file only if it is small (< 300 lines) or you are rewriting it.
4. **Never re-read** a file you already read or just edited: `Edit` fails by itself if the text changed.
5. **Never open**: generated or minified files, `package-lock.json`, `*.lock`, `dist/`, `build/`, `node_modules/`, `.git/`, caches, binaries, large JSON/CSV data (use `head -20` if needed), images nobody asked for.
6. Long docs and READMEs: `plan.sh` (headings), then only the useful section.

## 2. Keep command output short

- Always bound it: `| tail -30`, `| head -50`, `| grep -E "error|fail|warn"`, `--quiet`, `-q`, `--silent`.
- Tests: show only failures and the summary (`pytest -q --tb=short`, `npm test --silent 2>&1 | tail -40`, `go test ./... 2>&1 | grep -E "FAIL|ok"`). Re-run only the failing test, not the whole suite.
- Builds and installs: `2>&1 | tail -20`. Never print a full install log.
- git: `git status --short`, `git diff --stat` before a targeted `git diff -- file`, `git log --oneline -10`.
- Logs: `grep` for the pattern, `tail`, never the whole file.
- Unfiltered `ls -R` or `find` on a big folder: forbidden; use `Glob` or `plan.sh <folder>`.

## 3. Verify without waste

- An image costs about (width × height) / 750 tokens: shrink screenshots (smaller window or viewport, or `zoom` on a region) and take them only at key steps.
- Browser: prefer `get_page_text`, `find` or `read_page` (`interactive` filter) over a screenshot.
- Batch several changes before relaunching the app or the test suite. Pure logic: tests are enough, no need to launch the app.

## 4. Tools and agents

- Independent calls in the same message (several `Grep`/`Read` in parallel).
- No sub-agent for a simple search: it starts from zero and re-reads everything. Use an `Explore` agent only for a wide sweep where only the conclusion matters (its reads do not fill this context).
- For a repetitive change across many files: one script (`sed`, small script) instead of dozens of `Edit` calls.
- Throwaway scripts go in the scratchpad, not in the project.
- Do not load skills or deferred tools the task does not need.

## 5. Reply short

- Reply in the user's language.
- Answer first, then the why in one sentence, then the next step if any.
- No preamble ("I'll…", "Sure"), no restating the request, no final recap, no pleasantries.
- Code in chat: only the changed lines + 1-2 lines of context, never the whole file (the diff already shows it).
- Between tool calls: nothing, or one line per important step.
- No decorative table or list when one sentence is enough.
- Exceptions, in full sentences: security warning, irreversible action, a question to the user, a confused user. Code, comments, commits and docs keep their normal style.

## 6. Long context

- Memory, CLAUDE.md and skills are loaded every session: keep them short. Put details in reference files read on demand; update an existing file instead of creating a new one.
- Switching tasks: suggest `/clear` (unrelated new task) or `/compact` (same task, heavy context). `/context` shows what fills the context.
- Do not repeat a search already done in the conversation: reuse its result.
