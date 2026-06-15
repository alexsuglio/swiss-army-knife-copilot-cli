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
