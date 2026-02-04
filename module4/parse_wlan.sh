if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <input_file>"
  exit 1
fi

INPUT="$1"
OUTPUT="output.txt"

if [ ! -f "$INPUT" ]; then
  echo "Input file not found"
  exit 1
fi

> "$OUTPUT"

while IFS= read -r line; do
  if echo "$line" | grep -q '"frame.time"'; then
    echo "$line" >> "$OUTPUT"
  fi

  if echo "$line" | grep -q '"wlan.fc.type"'; then
    echo "$line" >> "$OUTPUT"
  fi

  if echo "$line" | grep -q '"wlan.fc.subtype"'; then
    echo "$line" >> "$OUTPUT"
  fi
done < "$INPUT"

echo "Output written to $OUTPUT"
