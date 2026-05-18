import test from "node:test";
import assert from "node:assert/strict";
import { parseCsv } from "../src/csvLegacyParser.js";

test("parseCsv parses basic rows", () => {
  const csv = "id,name\n1,Ari\n2,Sam";
  assert.deepEqual(parseCsv(csv), [
    ["id", "name"],
    ["1", "Ari"],
    ["2", "Sam"]
  ]);
});

test("parseCsv skips empty lines", () => {
  const csv = "id,name\n\n1,Ari\n";
  assert.deepEqual(parseCsv(csv), [
    ["id", "name"],
    ["1", "Ari"]
  ]);
});
