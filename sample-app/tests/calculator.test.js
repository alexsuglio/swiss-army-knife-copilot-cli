import test from "node:test";
import assert from "node:assert/strict";
import { totalPrice } from "../src/calculator.js";

test("totalPrice computes sum of quantity * price", () => {
  const items = [
    { quantity: 2, price: 5.5 },
    { quantity: 1, price: 10 }
  ];

  assert.equal(totalPrice(items), 21);
});

test("totalPrice handles empty input", () => {
  assert.equal(totalPrice([]), 0);
});
