exports.handler = async (event) => {
  const records = event.Records || [];
  const results = records.map((r) => {
    const body = JSON.parse(r.body || '{}');
    return { orderId: body.orderId, status: "processed" };
  });
  return { processed: results.length, results: results };
};
