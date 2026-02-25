# Cron Templates

Copy these into your OpenClaw cron configuration. Adjust times, prompts, and schedules to fit your rhythm.

All times use your local timezone. Set your timezone in OpenClaw config first.

---

## Nightly Memory Consolidation (Required)

The most important cron. Your agent reviews the day and updates its memory.

```
Name: memory-consolidation
Schedule: cron — "0 2 * * *" (2:00 AM daily)
Session: isolated
Model: Your strongest model (Opus recommended)
Timeout: 900 seconds

Prompt:
"You are running the nightly memory consolidation cycle. Read memory/README.md for the full protocol.

Phase 1 — NREM (Consolidation):
1. Read today's daily note (memory/YYYY-MM-DD.md)
2. Review any conversations from today
3. Extract: decisions made, facts learned, preferences expressed, lessons caught, tasks completed/started
4. Update the daily note with anything missing
5. Create or update entity files (memory/entities/) for people, projects, or companies mentioned
6. Update MEMORY.md with significant events worth keeping long-term
7. Update memory/active-tasks.md with current state
8. Flag any stale references or outdated entities
9. If 3+ similar lessons exist in lessons.md, promote to a general principle

Phase 2 — REM (Abstraction):
1. Check for contradictions between SOUL.md, USER.md, AGENTS.md, and memory files. REPORT contradictions but do NOT auto-fix genome files (SOUL.md, AGENTS.md, USER.md, IDENTITY.md).
2. Look for repeated patterns in daily notes that could become skills or principles.

Phase 3 — Commit:
1. Git add and commit all changes with message: 'nightly consolidation YYYY-MM-DD'
2. Log a brief summary of what was updated.

Be thorough. This is your long-term memory — accuracy matters more than speed."
```

---

## Morning Letter (Optional — Recommended)

A personal daily briefing delivered to your messaging channel.

```
Name: morning-letter
Schedule: cron — "0 6 * * *" (6:00 AM daily)
Session: isolated
Model: Your preferred model
Timeout: 300 seconds

Prompt:
"Write and send a morning letter to the user. This is a personal daily briefing — warm, concise, useful.

Include:
1. A brief greeting appropriate to the day/time
2. Any research findings from the overnight research agent (check recent research session output)
3. A relevant article or essay recommendation (check memory files for interests)
4. Any upcoming calendar events or reminders
5. A brief motivational or interesting note

Keep it under 300 words. Deliver it as a natural message, not a formatted report. This should feel like a letter from a thoughtful friend, not a dashboard."
```

---

## Essay Voice Note (Optional)

Finds an essay matching your interests, converts to audio, sends as voice notes.

```
Name: daily-essay
Schedule: cron — "30 5 * * *" (5:30 AM — before morning letter)
Session: isolated
Model: Your preferred model
Timeout: 600 seconds

Prompt:
"Find an essay that matches the user's personality and interests (read USER.md and MEMORY.md for context). Convert it to voice notes using the essay-voice-note skill. Send the audio as voice notes, then send a brief summary of why this essay matters for them as a separate voice note.

Check memory/essay-history.md to avoid duplicates. Log the essay you chose."
```

**Requires:** essay-voice-note skill installed, TTS configured in OpenClaw.

---

## Research Agent (Optional)

A sub-agent that scans overnight for things you care about.

```
Name: nightly-research
Schedule: cron — "0 0 * * *" (midnight)
Session: isolated
Agent: researcher (or create a sub-agent)
Model: Strong model recommended for web content (prompt injection resistance)
Timeout: 600 seconds

Prompt:
"Run the nightly research scan. Check:
1. [Your industry] news and developments
2. [Specific companies or topics you're tracking]
3. Job postings matching [your criteria] (if job searching)
4. Interesting essays or articles related to [your interests]

Find one 'good news' item — something positive happening in the world.

Save findings to a structured report. Keep it scannable — headlines with brief context, URLs included. This feeds into the morning letter."
```

**Customize:** Replace bracketed items with your actual interests, industry, and tracking targets.

---

## Reminders & Check-ins (Optional)

### Daily Mantra / Intention
```
Name: morning-mantra
Schedule: cron — "0 10 * * *" (10:00 AM)
Session: main (systemEvent)
Prompt: "Morning reminder: [Your personal mantra or intention]"
```

### Stretch / Movement Break
```
Name: stretch-break
Schedule: every — 7200000ms (every 2 hours)
Session: main (systemEvent)
Prompt: "Gentle reminder: Stand up, stretch, roll your shoulders. Quick 2-minute break."
```

### Self-Review
```
Name: self-review
Schedule: cron — "0 22 * * *" (10:00 PM)
Session: isolated
Prompt: "Quick self-review. Ask yourself:
1. What went well today?
2. What would I do differently?
3. Any repetitive pattern today that could become a skill?
Log anything meaningful to memory/lessons.md. If nothing stands out, move on."
```

---

## Setting Up Crons in OpenClaw

### Via CLI
```bash
openclaw cron add --name "memory-consolidation" --schedule "0 2 * * *" ...
```

### Via Config
Add to your `openclaw.json` under the crons section. See OpenClaw docs for exact format: https://docs.openclaw.ai

### Verify
```bash
openclaw cron list
```

---

## Tips

- **Start with consolidation only.** Add others once you're comfortable.
- **Morning letter needs a research agent** to be most useful. Set both up together.
- **Cron times are suggestions.** Adjust to your schedule and timezone.
- **Monitor the first few runs.** Check output to make sure prompts are producing good results, then adjust.
- **Isolated sessions** run independently and don't pollute your main conversation history.
