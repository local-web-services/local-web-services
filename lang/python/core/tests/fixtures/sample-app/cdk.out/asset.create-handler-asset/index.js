exports.createItem = async (event) => {
  const body = JSON.parse(event.body || '{}');
  return {
    statusCode: 201,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id: body.id || "test-id", name: body.name || "test" }),
  };
};
