const { DynamoDBClient, UpdateItemCommand } = require('@aws-sdk/client-dynamodb');
const { SNSClient, PublishCommand } = require('@aws-sdk/client-sns');
const { SSMClient, GetParameterCommand } = require('@aws-sdk/client-ssm');
const { SecretsManagerClient, GetSecretValueCommand } = require('@aws-sdk/client-secrets-manager');

const ddb = new DynamoDBClient({});
const sns = new SNSClient({});
const ssm = new SSMClient({});
const sm = new SecretsManagerClient({});

exports.handler = async (event) => {
  // Handle SQS event (records array) or direct invocation
  const records = event.Records || [{ body: JSON.stringify(event) }];

  // Fetch configuration from SSM Parameter Store
  const maxItemsResp = await ssm.send(new GetParameterCommand({
    Name: process.env.MAX_ITEMS_PARAM || '/orders/config/max-items',
  }));
  const maxItems = parseInt(maxItemsResp.Parameter?.Value || '100', 10);

  // Fetch notification API key from Secrets Manager
  const secretResp = await sm.send(new GetSecretValueCommand({
    SecretId: process.env.NOTIFICATION_SECRET_ARN || 'orders/notification-api-key',
  }));
  const notificationKey = JSON.parse(secretResp.SecretString || '{}').apiKey || 'default';

  const results = [];

  for (const record of records) {
    const order = JSON.parse(record.body || '{}');
    const orderId = order.orderId;

    if (!orderId) continue;

    await ddb.send(new UpdateItemCommand({
      TableName: process.env.TABLE_NAME,
      Key: { orderId: { S: orderId } },
      UpdateExpression: 'SET #status = :status',
      ExpressionAttributeNames: { '#status': 'status' },
      ExpressionAttributeValues: { ':status': { S: 'PROCESSED' } },
    }));

    await sns.send(new PublishCommand({
      TopicArn: process.env.TOPIC_ARN,
      Subject: `Order ${orderId} processed`,
      Message: JSON.stringify({
        orderId,
        status: 'PROCESSED',
        timestamp: new Date().toISOString(),
        maxItems,
        notificationKey: notificationKey.substring(0, 4) + '****',
      }),
    }));

    results.push({ orderId, status: 'PROCESSED' });
  }

  return { processed: results.length, results };
};
