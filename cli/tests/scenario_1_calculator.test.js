import test from 'node:test';
import assert from 'node:assert/strict';

import { totalPrice } from '../src/scenario_1_calculator.js';

test('computes the total for multiple line items', () => {
  const total = totalPrice([
    { quantity: 2, price: 5 },
    { quantity: 1, price: 3.5 }
  ]);

  assert.equal(total, 13.5);
});

test('returns 0 for an empty cart', () => {
  assert.equal(totalPrice([]), 0);
});

test('treats missing quantity as 0', () => {
  const total = totalPrice([
    { price: 12.5 },
    { quantity: 2, price: 4 }
  ]);

  assert.equal(total, 8);
});

test('treats missing price as 0', () => {
  const total = totalPrice([
    { quantity: 3 },
    { quantity: 2, price: 4.25 }
  ]);

  assert.equal(total, 8.5);
});

test('rounds floating point totals to 2 decimals', () => {
  const total = totalPrice([
    { quantity: 1, price: 0.1 },
    { quantity: 1, price: 0.2 }
  ]);

  assert.equal(total, 0.3);
});

test('handles larger totals cleanly', () => {
  const total = totalPrice([
    { quantity: 25, price: 19.99 },
    { quantity: 10, price: 2.5 }
  ]);

  assert.equal(total, 524.75);
});
