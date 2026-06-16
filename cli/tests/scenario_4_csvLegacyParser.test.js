import test from 'node:test';
import assert from 'node:assert/strict';

import { parseCsv } from '../src/scenario_4_cli_csvLegacyParser.js';

test('parses a simple csv table into records', () => {
  const result = parseCsv('id,name\n1,Alex\n2,Sam');

  assert.deepEqual(result, [
    { id: '1', name: 'Alex' },
    { id: '2', name: 'Sam' }
  ]);
});

test('returns an empty array for empty input', () => {
  assert.deepEqual(parseCsv(''), []);
});

test('ignores blank lines', () => {
  const result = parseCsv('id,name\n\n1,Alex\n\n2,Sam\n');

  assert.deepEqual(result, [
    { id: '1', name: 'Alex' },
    { id: '2', name: 'Sam' }
  ]);
});

test('trims surrounding whitespace in headers and values', () => {
  const result = parseCsv(' id , name \n 1 , Alex ');

  assert.deepEqual(result, [{ id: '1', name: 'Alex' }]);
});

test('skips malformed rows with too few values', () => {
  const result = parseCsv('id,name\n1\n2,Sam');

  assert.deepEqual(result, [{ id: '2', name: 'Sam' }]);
});

test('skips malformed rows with too many values', () => {
  const result = parseCsv('id,name\n1,Alex,Extra\n2,Sam');

  assert.deepEqual(result, [{ id: '2', name: 'Sam' }]);
});

test('returns an empty array when only headers are present', () => {
  assert.deepEqual(parseCsv('id,name'), []);
});

test('supports windows newlines', () => {
  const result = parseCsv('id,name\r\n1,Alex\r\n2,Sam');

  assert.deepEqual(result, [
    { id: '1', name: 'Alex' },
    { id: '2', name: 'Sam' }
  ]);
});

test('returns an empty array for non-string input', () => {
  assert.deepEqual(parseCsv(null), []);
});
