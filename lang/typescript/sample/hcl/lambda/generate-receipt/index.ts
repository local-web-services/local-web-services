import { S3Client, PutObjectCommand } from '@aws-sdk/client-s3';

const s3 = new S3Client({});

export const handler = async (event: any) => {
  const orderId = event.orderId || 'unknown';
  const key = `receipts/${orderId}.json`;

  const receipt = {
    orderId,
    generatedAt: new Date().toISOString(),
    items: event.items || [],
    total: event.total || 0,
    status: 'RECEIPT_GENERATED',
  };

  await s3.send(new PutObjectCommand({
    Bucket: process.env.BUCKET_NAME,
    Key: key,
    Body: JSON.stringify(receipt, null, 2),
    ContentType: 'application/json',
  }));

  return { orderId, receiptKey: key };
};
