import test from "node:test";
import assert from "node:assert/strict";
import { applyDiscount } from "../src/discount.js";

test("applyDiscount applies regular percentage", () => {
  assert.equal(applyDiscount(100, 10), 90);
});

test("applyDiscount returns original total for 0 percent", () => {
  assert.equal(applyDiscount(42, 0), 42);
});

test("applyDiscount with 100 percent should return 0", () => {
  assert.equal(applyDiscount(25, 100), 0);
});
