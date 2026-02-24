const { DynamoDBClient, PutItemCommand } = require('@aws-sdk/client-dynamodb');
const { SQSClient, SendMessageCommand } = require('@aws-sdk/client-sqs');
const { randomUUID } = require('crypto');

const ddb = new DynamoDBClient({});
const sqs = new SQSClient({});

exports.handler = async (event) => {
  const body = JSON.parse(event.body || '{}');
  const orderId = randomUUID();
  const now = new Date().toISOString();

  const item = {
    orderId: { S: orderId },
    customerName: { S: body.customerName || 'Unknown' },
    items: { S: JSON.stringify(body.items || []) },
    total: { N: String(body.total || 0) },
    status: { S: 'CREATED' },
    createdAt: { S: now },
  };

  await ddb.send(new PutItemCommand({
    TableName: process.env.TABLE_NAME,
    Item: item,
  }));

  await sqs.send(new SendMessageCommand({
    QueueUrl: process.env.QUEUE_URL,
    MessageBody: JSON.stringify({ orderId, ...body }),
  }));

  return {
    statusCode: 201,
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ orderId, status: 'CREATED', createdAt: now }),
  };
};
