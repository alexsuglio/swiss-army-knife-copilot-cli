import test from 'node:test';
import assert from 'node:assert/strict';

import { validateUserProfile } from '../src/scenario_3_validator.js';

test('returns ok for a valid profile', () => {
  const result = validateUserProfile({
    id: '123',
    name: 'Alex',
    email: 'alex@example.com'
  });

  assert.deepEqual(result, { ok: true, errors: [] });
});

test('reports all missing required fields', () => {
  const result = validateUserProfile({});

  assert.deepEqual(result, {
    ok: false,
    errors: ['id is required', 'name is required', 'email is required']
  });
});

test('rejects invalid email format', () => {
  const result = validateUserProfile({
    id: '123',
    name: 'Alex',
    email: 'not-an-email'
  });

  assert.deepEqual(result, {
    ok: false,
    errors: ['email must be valid']
  });
});

test('rejects whitespace-only values', () => {
  const result = validateUserProfile({
    id: '  ',
    name: 'Alex',
    email: '   '
  });

  assert.deepEqual(result, {
    ok: false,
    errors: ['id is required', 'email is required']
  });
});

test('reports non-object input', () => {
  const result = validateUserProfile(null);

  assert.deepEqual(result, {
    ok: false,
    errors: ['profile must be an object']
  });
});

test('accepts trimmed-looking valid strings without modifying them', () => {
  const result = validateUserProfile({
    id: '001',
    name: 'Alex Suglio',
    email: 'alex@company.dev'
  });

  assert.equal(result.ok, true);
  assert.deepEqual(result.errors, []);
});

test('can report both required-field and email-format errors', () => {
  const result = validateUserProfile({
    id: '123',
    name: '',
    email: 'bad@'
  });

  assert.deepEqual(result, {
    ok: false,
    errors: ['name is required', 'email must be valid']
  });
});
