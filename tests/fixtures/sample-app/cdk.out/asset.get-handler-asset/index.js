exports.getItem = async (event) => {
  const id = (event.pathParameters && event.pathParameters.id) || "unknown";
  return {
    statusCode: 200,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ id: id, name: "fetched-item" }),
  };
};
