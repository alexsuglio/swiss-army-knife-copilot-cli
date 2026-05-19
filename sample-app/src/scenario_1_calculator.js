export function totalPrice(items) {
  let total = 0;

  for (const item of items) {
    const quantity = item?.quantity ?? 0;
    const price = item?.price ?? 0;
    total += quantity * price;
  }

  return Number(total.toFixed(2));
}