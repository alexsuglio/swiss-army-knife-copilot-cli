import test from 'node:test';
import assert from 'node:assert/strict';

import { applyDiscount } from '../src/scenario_2_discount.js';

test('applies a standard percentage discount', () => {
  assert.equal(applyDiscount(100, 20), 80);
});

test('returns the original total for 0 percent discount', () => {
  assert.equal(applyDiscount(42, 0), 42);
});

test('returns 0 for a 100 percent discount', () => {
  assert.equal(applyDiscount(42, 100), 0);
});

test('handles 50 percent discount', () => {
  assert.equal(applyDiscount(80, 50), 40);
});

test('supports fractional discount percentages', () => {
  assert.equal(applyDiscount(19.99, 12.5), 17.49);
});

test('preserves 2 decimal precision after rounding', () => {
  assert.equal(applyDiscount(10, 33.3333), 6.67);
});

test('throws for negative percentages', () => {
  assert.throws(() => applyDiscount(100, -5), /between 0 and 100/);
});

test('throws for percentages above 100', () => {
  assert.throws(() => applyDiscount(100, 120), /between 0 and 100/);
});
