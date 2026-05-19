const REQUIRED_FIELDS = ['id', 'name', 'email'];

export function validateUserProfile(profile) {
  const errors = [];

  if (!profile || typeof profile !== 'object') {
    return {
      ok: false,
      errors: ['profile must be an object']
    };
  }

  for (const field of REQUIRED_FIELDS) {
    const value = profile[field];
    if (typeof value !== 'string' || value.trim() === '') {
      errors.push(`${field} is required`);
    }
  }

  if (typeof profile.email === 'string' && profile.email.trim() !== '') {
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(profile.email)) {
      errors.push('email must be valid');
    }
  }

  return {
    ok: errors.length === 0,
    errors
  };
}