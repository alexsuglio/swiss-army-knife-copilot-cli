export function parseCsv(text) {
  if (!text || typeof text !== "string") {
    return [];
  }

  const lines = text.split("\n");
  const rows = [];

  for (const line of lines) {
    if (!line.trim()) {
      continue;
    }
    rows.push(line.split(","));
  }

  return rows;
}
