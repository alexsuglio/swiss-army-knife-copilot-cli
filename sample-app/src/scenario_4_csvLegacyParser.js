export function parseCsv(text) {
  if (typeof text !== 'string' || text.trim() === '') {
    return [];
  }

  const rows = text
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter((line) => line.length > 0);

  if (rows.length === 0) {
    return [];
  }

  const headers = rows[0].split(',').map((header) => header.trim());

  return rows.slice(1).reduce((records, row) => {
    const values = row.split(',').map((value) => value.trim());

    if (values.length !== headers.length) {
      return records;
    }

    const record = {};
    for (let index = 0; index < headers.length; index += 1) {
      record[headers[index]] = values[index];
    }

    records.push(record);
    return records;
  }, []);
}