---
name: essay-voice-note
description: Convert essays and articles into listen-friendly voice notes using OpenAI TTS. Use when asked to turn an article, essay, blog post, or URL into an audio voice note for walking, commuting, or passive listening. Triggers on requests like "make this a voice note," "read this to me," "turn this article into audio," or "essay voice note." Also finds essays automatically based on what you know about your user.
---

# Essay Voice Note

Convert essays and articles into polished, listen-friendly audio voice notes using OpenAI TTS. Can also discover essays automatically based on your user's interests.

## Requirements

- `OPENAI_API_KEY` environment variable set (or available in shell)
- `curl` available in PATH
- `ffmpeg` for multi-chunk concatenation (optional — single chunks work without it)

## Two Modes

### Mode 1: URL or Text → Voice Note
User provides a URL, file path, or raw text. Convert it to audio.

### Mode 2: Find + Generate (no URL given)
User asks for an essay voice note without specifying a source. Use what you know about them to find something great.

**How to find a good essay:**
1. Read your USER.md, MEMORY.md, or whatever context you have about your user — their interests, what they're thinking about, what they're working on
2. Search the web for long-form essays (2,000-8,000 words) that connect to those interests. Prioritize:
   - Thoughtful, original thinking over listicles or news
   - Essays that connect ideas across domains
   - Pieces from strong writers (personal blogs, literary magazines, longform journalism)
   - Content that would spark new thinking, not just inform
3. Fetch the top candidate and skim it. Is it actually good? Would you recommend it to a friend? If not, try the next one.
4. Once you have a strong essay, run it through the pipeline below.

**Search tips:**
- Try `site:ribbonfarm.com`, `site:paulgraham.com`, `site:aeon.co`, `site:longreads.com` for quality longform
- Search for the user's interests + "essay" or "long read"
- Recent isn't always better — great essays from 5 years ago are still great

## Workflow

### 1. Get the essay text

- If given a URL: use `web_fetch` to extract markdown content
- If given a file path: read the file
- If given raw text: use directly

### 2. Edit for listening

Transform the text into something that sounds natural when read aloud:

- Remove markdown formatting, links, image references, footnote markers
- Remove "Subscribe to newsletter" CTAs, author bios, share buttons
- Replace abbreviations with full words on first use
- Convert bullet lists into flowing sentences
- Remove section headers that don't work spoken (keep ones that serve as transitions)
- Keep the author's voice and words intact — edit for format, not content
- Break into logical chunks if the essay exceeds ~3,000 words (TTS handles chunks better)

### 3. Add your summary — this is what makes it special

Always append a personal summary at the end. This is NOT optional — it's the core differentiator. Without it, this is just text-to-speech. With it, it's a curated experience.

- Separate clearly from the essay: `[pause] ... Now, here's why I picked this one for you.`
- Explain WHY this essay is relevant to the user — connect it to what they're working on, thinking about, or struggling with
- Keep it concise (200-400 words) but specific — not generic praise of the essay
- Draw connections the user might not see themselves
- Never interleave commentary with the original essay — author's words first, your thoughts after

### 4. Generate audio

Use `scripts/generate-voice-note.sh` to create the audio file:

```bash
scripts/generate-voice-note.sh <input-text-file> <output-audio-file> [voice] [speed] [model]
```

**Parameters:**
- `input-text-file`: Path to the edited text file (required)
- `output-audio-file`: Path for output audio, e.g. `essay.opus` (required)
- `voice`: OpenAI voice name (default: `nova`)
- `speed`: Playback speed 0.25-4.0 (default: `1.0`)
- `model`: TTS model (default: `tts-1-hd`)

**Chunking:** The script automatically splits text into ~4000-character chunks at paragraph boundaries and concatenates the audio. This avoids OpenAI's input length limits.

**Supported output formats:** `.opus`, `.mp3`, `.aac`, `.flac` (inferred from file extension, defaults to opus)

### 5. Send as a sequence of voice notes

**Keep each voice note under 3 minutes 50 seconds.** Telegram only renders waveform visualizations for voice messages under ~3:50. Longer files get a flat scrubber — worse UX. (Empirically tested Feb 2026 — undocumented Telegram behavior.)

For the essay:
- If the audio is under 3 minutes, send as one voice note
- If longer, split into ~3 minute segments and send as sequential voice notes (Part 1, Part 2, etc.)
- Use the script's chunking to generate separate files rather than one concatenated file

For the summary:
- Always send as its own separate voice note after the essay
- Caption: "☝️ Why I picked this one for you" or similar

On Telegram, sequential voice notes auto-play together — so the experience is seamless. But splitting them means every note gets the waveform, and users can replay any section independently.

## Tips

- **Nova** voice is warm, clear, and confident — good default for essays
- **Chunk at paragraph breaks** to avoid mid-sentence cuts between audio segments
- For very long essays (5000+ words), consider summarizing instead of reading verbatim
- Essays with heavy code blocks, tables, or math don't convert well — summarize those sections
- When finding essays: surprise the user sometimes. Don't always pick the obvious topic — adjacent ideas spark the best thinking.
