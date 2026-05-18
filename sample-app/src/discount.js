export function applyDiscount(total, percent) {
  if (percent < 0) {
    throw new Error("Discount percent must be >= 0");
  }

  if (percent > 100) {
    throw new Error("Discount percent must be <= 100");
  }

  if (percent === 0) {
    return total;
  }

  const discounted = total * (1 - percent / 100);
  return Number(discounted.toFixed(2));
}
