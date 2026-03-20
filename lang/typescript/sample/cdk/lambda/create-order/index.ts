import { DynamoDBClient, PutItemCommand } from '@aws-sdk/client-dynamodb';
import { SQSClient, SendMessageCommand } from '@aws-sdk/client-sqs';
import { randomUUID } from 'crypto';

const ddb = new DynamoDBClient({});
const sqs = new SQSClient({});

export const handler = async (event: any) => {
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
