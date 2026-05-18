export function validateUserProfile(profile) {
  const errors = [];

  if (!profile || typeof profile !== "object") {
    return { ok: false, errors: ["profile must be an object"] };
  }

  if (!profile.id) {
    errors.push("id is required");
  }

  if (!profile.name) {
    errors.push("name is required");
  }

  if (!profile.email) {
    errors.push("email is required");
  }

  return {
    ok: errors.length === 0,
    errors
  };
}
