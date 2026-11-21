import {
  SQSClient,
  SendMessageCommand,
  ReceiveMessageCommand,
  DeleteMessageCommand,
} from "@aws-sdk/client-sqs";

/**
 * @param {{ orderId: string }} order
 * @param {string} queueUrl
 * @param {SQSClient} [client]
 * @returns {Promise<string>}
 */
export async function enqueueOrder(order, queueUrl, client) {
  const sqs = client ?? new SQSClient({ region: "us-east-1" });
  const response = await sqs.send(
    new SendMessageCommand({
      QueueUrl: queueUrl,
      MessageBody: JSON.stringify(order),
    }),
  );
  if (!response.MessageId) {
    throw new Error("SQS did not return a MessageId");
  }
  return response.MessageId;
}

/**
 * @param {string} queueUrl
 * @param {SQSClient} [client]
 * @returns {Promise<{ orderId: string } | null>}
 */
export async function processNextOrder(queueUrl, client) {
  const sqs = client ?? new SQSClient({ region: "us-east-1" });
  const response = await sqs.send(
    new ReceiveMessageCommand({
      QueueUrl: queueUrl,
      MaxNumberOfMessages: 1,
      WaitTimeSeconds: 0,
    }),
  );
  const message = response.Messages?.[0];
  if (!message?.Body || !message.ReceiptHandle) {
    return null;
  }
  await sqs.send(
    new DeleteMessageCommand({
      QueueUrl: queueUrl,
      ReceiptHandle: message.ReceiptHandle,
    }),
  );
  return JSON.parse(message.Body);
}
