# Clawprint — Setup Guide

Welcome. By the end of tonight, your agent will know how you think.

---

## What You're Setting Up

1. **Deep Self Assessment** — A guided personality conversation (~45 min)
2. **Behavioral Calibration** — Your agent writes its own rules for working with you
3. **3-Layer Memory** — Daily notes, entity files, long-term memory
4. **Nightly Consolidation** — Your agent reviews each day and updates its memory while you sleep
5. **Morning Letter** — A personal daily briefing delivered to Telegram
6. **Essay Voice Notes** — Articles matched to your interests, converted to audio
7. **Research Agent** — A sub-agent that scans overnight for things you care about
8. **Cron Starter Pack** — Reminders, check-ins, and daily rhythms

---

## Prerequisites

- **OpenClaw** running with a connected channel (Telegram recommended)
- **An API key** for your model provider (Anthropic recommended)
- **A terminal** you're comfortable with
- **~2 hours** for setup + assessment

---

## Step 1: Copy Files

Copy the contents of this package into your OpenClaw workspace:

```bash
cp -r package/* ~/your-openclaw-workspace/
```

This gives you:
```
your-workspace/
├── AGENTS.md          # How your agent operates
├── SOUL.md            # Gets written during assessment
├── USER.md            # Template — fill in about yourself
├── IDENTITY.md        # Your agent's identity
├── BOOT.md            # Startup health checklist
├── HEARTBEAT.md       # Periodic check template
├── memory/
│   ├── README.md      # How the 3-layer memory works
│   ├── active-tasks.md
│   ├── lessons.md
│   └── entities/      # Quick-lookup files for people/projects
├── skills/
│   └── essay-voice-note/
├── crons/
│   └── templates.md   # Copy-paste cron configs
└── deep-self/
    ├── GUIDE.md        # Assessment facilitator guide
    ├── SESSION-1.md    # Session 1 questions
    ├── SESSION-2.md    # Session 2 questions  
    ├── SESSION-3.md    # Session 3 questions
    └── CALIBRATION.md  # How to encode results into SOUL.md
```

---

## Step 2: Fill In USER.md

Open `USER.md` and fill in the basics about yourself:
- Name, timezone, pronouns
- What you do, what you're working on
- Communication preferences
- Interests and context your agent should know

Be honest and specific. This is the foundation your agent builds on. The more context you give, the better the calibration works.

---

## Step 3: Run the Deep Self Assessment

This is the core of Clawprint. Tell your agent:

> "Let's do the Deep Self assessment. Read deep-self/GUIDE.md and start Session 1."

Your agent will guide you through three conversational sessions:

| Session | Focus | Time |
|---------|-------|------|
| **1** | How you think and decide (Big Five traits) | ~20 min |
| **2** | What drives you (Enneagram + motivations) | ~15 min |
| **3** | Where you thrive (Holland Code + Zone of Genius) | ~15 min |

**Tips:**
- Answer honestly, not how you think you "should" answer
- Tangents are fine — they're often more revealing than direct answers
- You'll learn things about yourself. That's the point.
- You can do all three in one sitting or spread across days

---

## Step 4: Calibration

After completing all three sessions, tell your agent:

> "Read deep-self/CALIBRATION.md and write my SOUL.md calibration."

Your agent will:
1. Synthesize your assessment results into a personality profile
2. Generate behavioral calibration rules (when to push, when to listen, how to give feedback)
3. Write them into SOUL.md
4. Show you the result for approval

**Review it carefully.** This is how your agent will treat you from now on. If something feels off, say so — it's meant to be tuned.

---

## Step 5: Set Up Memory Consolidation

Add the nightly consolidation cron job to your OpenClaw config. This runs at 2am and:
- Reviews all conversations from the day
- Extracts decisions, facts, and lessons
- Updates memory files
- Commits changes to git

See `crons/templates.md` for the exact config to paste into your OpenClaw settings.

---

## Step 6: Set Up Morning Letter (Optional)

The morning letter sends you a personal briefing each morning. Configure:
- What time to deliver (default: 6am)
- What topics matter to you
- Whether to include essay voice notes

See `crons/templates.md` for the morning letter cron config.

---

## Step 7: Set Up Research Agent (Optional)

The research agent is a separate sub-agent that runs overnight, scanning for:
- News in your field
- Job postings (if you're looking)
- Articles matching your interests
- Whatever you configure

See `crons/templates.md` for research agent setup.

---

## What Happens Next

Your agent now:
- **Knows you** — personality, communication style, decision patterns
- **Remembers** — every conversation gets consolidated into persistent memory
- **Shows up** — morning briefings, voice notes, proactive research
- **Gets better** — nightly consolidation means it's sharper every day

The first morning after setup, you'll get your first letter. That's when it clicks.

---

## Customizing

Everything is markdown files in your workspace. Change anything:
- Edit SOUL.md to adjust how your agent communicates
- Change cron schedules to match your rhythm
- Add entity files for people and projects you work with
- Modify the research agent's focus areas

You own it completely. Make it yours.

---

## Troubleshooting

**Agent seems generic after setup:**
Check that SOUL.md has the calibration section. Re-run the calibration step if needed.

**Morning letter not arriving:**
Verify your cron is enabled (`openclaw cron list`). Check that your Telegram channel is connected.

**Memory not consolidating:**
Check the overnight cron output. Make sure git is initialized in your workspace.

**Assessment feels shallow:**
Give longer answers. The assessment quality scales directly with how much you share. One-word answers produce one-dimensional profiles.

---

*Built by Scott Bell · clawprint.dev · For OpenClaw*
