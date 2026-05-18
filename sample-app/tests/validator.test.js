import test from "node:test";
import assert from "node:assert/strict";
import { validateUserProfile } from "../src/validator.js";

test("validateUserProfile returns ok for valid profile", () => {
  const result = validateUserProfile({
    id: "u_123",
    name: "Ari",
    email: "ari@example.com"
  });

  assert.equal(result.ok, true);
  assert.deepEqual(result.errors, []);
});

test("validateUserProfile reports missing required fields", () => {
  const result = validateUserProfile({ id: "u_123" });
  assert.equal(result.ok, false);
  assert.deepEqual(result.errors, ["name is required", "email is required"]);
});
