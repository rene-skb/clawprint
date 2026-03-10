# Clawprint — Setup Guide

Welcome. By the end of this, your agent will know how you think.

---

## What You're Setting Up

1. **Deep Self Assessment** — A guided personality conversation (~25 min)
2. **Behavioral Calibration** — Your agent writes its own rules for working with you

---

## Prerequisites

- **OpenClaw** running with a connected channel (Telegram recommended)
- **An API key** for your model provider (Anthropic recommended)
- **A terminal** you're comfortable with
- **~45 minutes** total (setup + assessment)

---

## Step 1: Copy Files

Copy the contents of this package into your OpenClaw workspace:

```bash
cp -r * ~/your-openclaw-workspace/
```

This gives you:
```
your-workspace/
├── AGENTS.md          # How your agent operates
├── SOUL.md            # Gets written during assessment
├── USER.md            # Template — fill in about yourself
├── IDENTITY.md        # Your agent's identity
├── SETUP.md           # This file
└── deep-self/
    ├── GUIDE.md        # Assessment facilitator guide
    ├── SESSION-SINGLE.md  # All 20 questions
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

> "Let's do the Deep Self assessment. Read deep-self/GUIDE.md and start the session."

Your agent will guide you through 20 questions covering:
- **How you think and decide** (Big Five personality traits)
- **What drives you** (Enneagram type and motivations)
- **Where you thrive** (Holland Code and work style)

**Tips:**
- Answer honestly, not how you think you "should" answer
- Tangents are fine — they're often more revealing than direct answers
- You'll learn things about yourself. That's the point.
- Takes about 25 minutes

---

## Step 4: Calibration

After completing the assessment, tell your agent:

> "Read deep-self/CALIBRATION.md and write my SOUL.md calibration."

Your agent will:
1. Synthesize your assessment results into a personality profile
2. Generate behavioral calibration rules (when to push, when to listen, how to give feedback)
3. Write them into SOUL.md
4. Show you the result for approval

**Review it carefully.** This is how your agent will treat you from now on. If something feels off, say so — it's meant to be tuned.

---

## What Happens Next

Your agent now:
- **Knows you** — personality, communication style, decision patterns
- **Adapts** — pushes when you need pushing, listens when you need space
- **Gets it right** — feedback, brainstorming, motivation all calibrated to you

The difference is immediate. Your next conversation will feel different.

---

## Customizing

Everything is markdown files in your workspace. Change anything:
- Edit SOUL.md to adjust how your agent communicates
- Add to USER.md as your life changes
- Re-run the assessment anytime you feel like it's drifted

You own it completely. Make it yours.

---

## Troubleshooting

**Agent seems generic after setup:**
Check that SOUL.md has the calibration section. Re-run the calibration step if needed.

**Assessment feels shallow:**
Give longer answers. The assessment quality scales directly with how much you share. One-word answers produce one-dimensional profiles.

---

*Built by Scott Bell · clawprint.dev · For OpenClaw*
