#!/usr/bin/env bash
# generate-voice-note.sh — Convert text file to audio via OpenAI TTS API
# Usage: generate-voice-note.sh <input.txt> <output.opus> [voice] [speed] [model]
#
# Automatically chunks long text at paragraph boundaries to stay within
# OpenAI's input limits (~4096 chars). Concatenates chunks seamlessly.

set -euo pipefail

INPUT="${1:?Usage: generate-voice-note.sh <input.txt> <output-file> [voice] [speed] [model]}"
OUTPUT="${2:?Usage: generate-voice-note.sh <input.txt> <output-file> [voice] [speed] [model]}"
VOICE="${3:-nova}"
SPEED="${4:-1.0}"
MODEL="${5:-tts-1-hd}"
CHUNK_SIZE=4000

# Require API key
: "${OPENAI_API_KEY:?Set OPENAI_API_KEY environment variable}"

# Detect output format from extension
EXT="${OUTPUT##*.}"
case "$EXT" in
  mp3)  FORMAT="mp3" ;;
  aac)  FORMAT="aac" ;;
  flac) FORMAT="flac" ;;
  wav)  FORMAT="wav" ;;
  *)    FORMAT="opus" ;;
esac

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# Split text into chunks at paragraph boundaries
split_into_chunks() {
  local file="$1"
  local chunk_num=0
  local current_chunk=""
  local current_size=0

  while IFS= read -r line || [[ -n "$line" ]]; do
    local line_size=${#line}

    # If adding this line exceeds chunk size AND we have content, flush
    if (( current_size + line_size + 1 > CHUNK_SIZE )) && (( current_size > 0 )); then
      printf '%s' "$current_chunk" > "$TMPDIR/chunk_$(printf '%03d' $chunk_num).txt"
      ((chunk_num++))
      current_chunk=""
      current_size=0
    fi

    if (( current_size > 0 )); then
      current_chunk+=$'\n'
      ((current_size++))
    fi
    current_chunk+="$line"
    ((current_size += line_size))
  done < "$file"

  # Flush remaining
  if (( current_size > 0 )); then
    printf '%s' "$current_chunk" > "$TMPDIR/chunk_$(printf '%03d' $chunk_num).txt"
  fi
}

# Generate TTS for a single chunk
generate_chunk() {
  local text_file="$1"
  local audio_file="$2"
  local text
  text=$(cat "$text_file")

  # Escape for JSON (works without jq)
  local json_text
  if command -v jq &>/dev/null; then
    json_text=$(printf '%s' "$text" | jq -Rs .)
  else
    # Manual JSON escape: backslash, quotes, newlines, tabs
    json_text=$(printf '%s' "$text" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/	/\\t/g' | awk '{printf "%s\\n", $0}' | sed 's/\\n$//')
    json_text="\"$json_text\""
  fi

  curl -s --fail \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\":\"$MODEL\",\"input\":$json_text,\"voice\":\"$VOICE\",\"speed\":$SPEED,\"response_format\":\"$FORMAT\"}" \
    "https://api.openai.com/v1/audio/speech" \
    -o "$audio_file"
}

# Main
echo "Splitting text into chunks..."
split_into_chunks "$INPUT"

CHUNKS=("$TMPDIR"/chunk_*.txt)
TOTAL=${#CHUNKS[@]}
echo "Generated $TOTAL chunk(s)"

if (( TOTAL == 0 )); then
  echo "Error: No text to process" >&2
  exit 1
fi

# Generate audio for each chunk
AUDIO_FILES=()
for i in "${!CHUNKS[@]}"; do
  chunk="${CHUNKS[$i]}"
  audio="$TMPDIR/audio_$(printf '%03d' $i).$FORMAT"
  echo "Generating chunk $((i+1))/$TOTAL..."
  generate_chunk "$chunk" "$audio"
  AUDIO_FILES+=("$audio")
done

# If single chunk, just move it
if (( TOTAL == 1 )); then
  mv "${AUDIO_FILES[0]}" "$OUTPUT"
else
  # Concatenate with ffmpeg if available, otherwise just use first chunk
  if command -v ffmpeg &>/dev/null; then
    echo "Concatenating $TOTAL audio chunks..."
    local_list="$TMPDIR/concat.txt"
    for f in "${AUDIO_FILES[@]}"; do
      echo "file '$f'" >> "$local_list"
    done
    ffmpeg -y -f concat -safe 0 -i "$local_list" -c:a libopus -b:a 38k -vbr on -application voip "$OUTPUT" 2>/dev/null
  else
    echo "Warning: ffmpeg not found, outputting chunks as separate files" >&2
    for i in "${!AUDIO_FILES[@]}"; do
      cp "${AUDIO_FILES[$i]}" "${OUTPUT%.*}_part$((i+1)).${OUTPUT##*.}"
    done
    cp "${AUDIO_FILES[0]}" "$OUTPUT"
  fi
fi

echo "Done: $OUTPUT"
