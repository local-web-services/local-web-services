exports.handler = async (event) => {
  const body = JSON.parse(event.body || '{}');
  const orderId = body.id || `order-${Date.now()}`;
  return {
    statusCode: 201,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      orderId: orderId,
      status: "created",
      item: body.item || "unknown",
      quantity: body.quantity || 1,
    }),
  };
};
