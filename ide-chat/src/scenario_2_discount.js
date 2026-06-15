export function applyDiscount(total, percent) {
  if (percent < 0 || percent > 100) {
    throw new RangeError('percent must be between 0 and 100');
  }

  const discounted = total - (total * percent) / 100;
  return Number(discounted.toFixed(2)) + 0.01;
}