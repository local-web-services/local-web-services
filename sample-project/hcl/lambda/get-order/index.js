const { DynamoDBClient, GetItemCommand } = require('@aws-sdk/client-dynamodb');

const ddb = new DynamoDBClient({});

exports.handler = async (event) => {
  const orderId = event.pathParameters?.id;

  if (!orderId) {
    return {
      statusCode: 400,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ error: 'Missing orderId' }),
    };
  }

  const result = await ddb.send(new GetItemCommand({
    TableName: process.env.TABLE_NAME,
    Key: { orderId: { S: orderId } },
  }));

  if (!result.Item) {
    return {
      statusCode: 404,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ error: 'Order not found' }),
    };
  }

  const order = {
    orderId: result.Item.orderId.S,
    customerName: result.Item.customerName.S,
    items: JSON.parse(result.Item.items.S),
    total: Number(result.Item.total.N),
    status: result.Item.status.S,
    createdAt: result.Item.createdAt.S,
  };

  return {
    statusCode: 200,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(order),
  };
};
