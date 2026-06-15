export function buildReleaseNotes(entries) {
  if (!Array.isArray(entries) || entries.length === 0) {
    return 'No release notes yet.';
  }

  const lines = entries
    .filter((entry) => typeof entry?.title === 'string' && entry.title.trim() !== '')
    .map((entry, index) => {
      const title = entry.title.trim();
      const highlight = typeof entry?.highlight === 'string' ? entry.highlight.trim() : '';

      if (highlight) {
        return `${index + 1}. ${title} — ${highlight}`;
      }

      return `${index + 1}. ${title}`;
    });

  if (lines.length === 0) {
    return 'No release notes yet.';
  }

  return lines.join('\n');
}
