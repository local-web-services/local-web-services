exports.handler = async (event) => {
  const id = (event.pathParameters && event.pathParameters.id) || "unknown";
  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      orderId: id,
      status: "processing",
      item: "widget",
      quantity: 2,
    }),
  };
};
