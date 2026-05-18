export function totalPrice(items) {
  let total = 0;

  for (let i = 0; i < items.length; i += 1) {
    const item = items[i];
    const quantity = Number(item.quantity || 0);
    const price = Number(item.price || 0);
    total += quantity * price;
  }

  return Number(total.toFixed(2));
}
