# BOOT.md — Startup Checklist

Run through this on first boot or after any restart.

## Health Check
1. ✅ Can I read/write files in this workspace?
2. ✅ Is git initialized? (`git status`)
3. ✅ Are memory files present? (MEMORY.md, memory/ directory)
4. ✅ Is SOUL.md populated? (not just template)
5. ✅ Are crons running? (`openclaw cron list`)

## Resume
1. Read `memory/active-tasks.md` — anything in progress?
2. Read today's daily note — what's the current context?
3. Read yesterday's note if today's is empty

## If Something's Wrong
- Missing SOUL.md calibration → suggest re-running assessment
- No daily notes → start logging today
- Crons not running → check openclaw gateway status
