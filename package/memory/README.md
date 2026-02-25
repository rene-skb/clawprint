# Memory System — How It Works

Your agent uses a 3-layer memory system. Each layer serves a different purpose.

---

## Layer 1: Daily Notes (`memory/YYYY-MM-DD.md`)

Raw logs of what happened each day. Your agent creates these automatically.

**Contains:** Decisions made, tasks completed, things discussed, errors hit, context needed tomorrow.

**Lifecycle:** Created daily. Reviewed during nightly consolidation. Important bits get promoted to MEMORY.md or entity files.

---

## Layer 2: Entity Files (`memory/entities/`)

Quick-lookup files for specific people, projects, companies, or concepts.

**Contains:** Overview, current status, key facts, next steps.

**Example:** `memory/entities/stripe.md` might have the company overview, your interview status, key contacts, and prep materials location.

**When to create:** Any time a person, project, or company comes up repeatedly. If your agent is repeating the same context about something, it needs an entity file.

**Template:**
```markdown
# [Entity Name]

## Overview
[What is this? One paragraph.]

## Status
[Current state — active, waiting, done, blocked]

## Key Facts
- [Important details]

## Next Steps
- [ ] [What's next]
```

---

## Layer 3: Long-Term Memory (`MEMORY.md`)

Curated wisdom. The distilled essence of everything worth remembering long-term.

**Contains:** Who you are, who your human is, your dynamic, key decisions, active goals, lessons learned.

**Lifecycle:** Updated during nightly consolidation. Your agent reviews daily notes and promotes significant events, decisions, and lessons. Outdated info gets removed.

---

## Nightly Consolidation

Every night (default 2am), your agent:

### Phase 1 — NREM (Consolidation)
1. Reviews all conversations from the day
2. Extracts decisions, facts, preferences, and lessons
3. Updates daily note, entity files, and MEMORY.md
4. Flags stale references and outdated entities
5. Promotes repeated lessons into general principles

### Phase 2 — REM (Abstraction)
1. Checks for contradictions across memory files
2. Looks for patterns that could become skills or principles
3. Reports contradictions (never auto-fixes core identity files)

### Phase 3 — Commit
1. Commits all changes to git
2. Logs what was updated

---

## Rules

- **SOUL.md, AGENTS.md, USER.md, IDENTITY.md** = genome files. Never auto-modified during consolidation. Report issues only.
- **Memory files** = epigenome. Can be freely updated during consolidation.
- **Daily notes** are append-only during the day. Consolidation can add summaries but shouldn't delete raw entries.

---

*Your agent manages all of this. You don't need to touch these files unless you want to.*
