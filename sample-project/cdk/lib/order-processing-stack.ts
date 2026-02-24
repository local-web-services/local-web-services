import * as cdk from 'aws-cdk-lib';
import * as dynamodb from 'aws-cdk-lib/aws-dynamodb';
import * as sqs from 'aws-cdk-lib/aws-sqs';
import * as s3 from 'aws-cdk-lib/aws-s3';
import * as sns from 'aws-cdk-lib/aws-sns';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as lambdaEvents from 'aws-cdk-lib/aws-lambda-event-sources';
import * as apigwv2 from 'aws-cdk-lib/aws-apigatewayv2';
import * as apigwv2Integrations from 'aws-cdk-lib/aws-apigatewayv2-integrations';
import * as sfn from 'aws-cdk-lib/aws-stepfunctions';
import * as tasks from 'aws-cdk-lib/aws-stepfunctions-tasks';
import * as ssm from 'aws-cdk-lib/aws-ssm';
import * as secretsmanager from 'aws-cdk-lib/aws-secretsmanager';
import { Construct } from 'constructs';

export class OrderProcessingStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // DynamoDB Table
    const ordersTable = new dynamodb.Table(this, 'OrdersTable', {
      tableName: 'Orders',
      partitionKey: { name: 'orderId', type: dynamodb.AttributeType.STRING },
      removalPolicy: cdk.RemovalPolicy.DESTROY,
    });

    // SQS Dead Letter Queue
    const orderDlq = new sqs.Queue(this, 'OrderDLQ', {
      queueName: 'order-dlq',
    });

    // SQS Queue
    const orderQueue = new sqs.Queue(this, 'OrderQueue', {
      queueName: 'order-queue',
      deadLetterQueue: {
        queue: orderDlq,
        maxReceiveCount: 3,
      },
    });

    // S3 Bucket
    const receiptsBucket = new s3.Bucket(this, 'ReceiptsBucket', {
      bucketName: `order-receipts-${this.account}-${this.region}`,
      removalPolicy: cdk.RemovalPolicy.DESTROY,
      autoDeleteObjects: true,
    });

    // SNS Topic
    const notificationTopic = new sns.Topic(this, 'OrderNotifications', {
      topicName: 'order-notifications',
    });

    // SSM Parameter Store
    const appConfigParam = new ssm.StringParameter(this, 'AppConfigParam', {
      parameterName: '/orders/config/max-items',
      stringValue: '100',
      description: 'Maximum items per order',
    });

    // Secrets Manager
    const notificationApiKey = new secretsmanager.Secret(this, 'NotificationApiKey', {
      secretName: 'orders/notification-api-key',
      description: 'API key for the notification service',
      generateSecretString: {
        secretStringTemplate: JSON.stringify({ apiKey: 'local-dev-key-12345' }),
        generateStringKey: 'generated',
      },
    });

    // Lambda Functions
    const createOrderFn = new lambda.Function(this, 'CreateOrderFunction', {
      functionName: 'CreateOrderFunction',
      runtime: lambda.Runtime.NODEJS_20_X,
      handler: 'index.handler',
      code: lambda.Code.fromAsset('lambda/create-order'),
      environment: {
        TABLE_NAME: ordersTable.tableName,
        QUEUE_URL: orderQueue.queueUrl,
      },
    });

    const getOrderFn = new lambda.Function(this, 'GetOrderFunction', {
      functionName: 'GetOrderFunction',
      runtime: lambda.Runtime.NODEJS_20_X,
      handler: 'index.handler',
      code: lambda.Code.fromAsset('lambda/get-order'),
      environment: {
        TABLE_NAME: ordersTable.tableName,
      },
    });

    const processOrderFn = new lambda.Function(this, 'ProcessOrderFunction', {
      functionName: 'ProcessOrderFunction',
      runtime: lambda.Runtime.NODEJS_20_X,
      handler: 'index.handler',
      code: lambda.Code.fromAsset('lambda/process-order'),
      environment: {
        TABLE_NAME: ordersTable.tableName,
        TOPIC_ARN: notificationTopic.topicArn,
        BUCKET_NAME: receiptsBucket.bucketName,
        MAX_ITEMS_PARAM: appConfigParam.parameterName,
        NOTIFICATION_SECRET_ARN: notificationApiKey.secretArn,
      },
    });

    const generateReceiptFn = new lambda.Function(this, 'GenerateReceiptFunction', {
      functionName: 'GenerateReceiptFunction',
      runtime: lambda.Runtime.NODEJS_20_X,
      handler: 'index.handler',
      code: lambda.Code.fromAsset('lambda/generate-receipt'),
      environment: {
        BUCKET_NAME: receiptsBucket.bucketName,
      },
    });

    // IAM Grants
    ordersTable.grantReadWriteData(createOrderFn);
    ordersTable.grantReadData(getOrderFn);
    ordersTable.grantReadWriteData(processOrderFn);
    orderQueue.grantSendMessages(createOrderFn);
    notificationTopic.grantPublish(processOrderFn);
    receiptsBucket.grantWrite(processOrderFn);
    receiptsBucket.grantWrite(generateReceiptFn);
    appConfigParam.grantRead(processOrderFn);
    notificationApiKey.grantRead(processOrderFn);

    // SQS Event Source for ProcessOrderFunction
    processOrderFn.addEventSource(new lambdaEvents.SqsEventSource(orderQueue, {
      batchSize: 10,
    }));

    // Step Functions State Machine
    const validateOrder = new sfn.Pass(this, 'ValidateOrder', {
      result: sfn.Result.fromObject({ validated: true }),
      resultPath: '$.validation',
    });

    const processPayment = new sfn.Pass(this, 'ProcessPayment', {
      result: sfn.Result.fromObject({ paymentStatus: 'SUCCESS' }),
      resultPath: '$.payment',
    });

    const generateReceipt = new tasks.LambdaInvoke(this, 'GenerateReceipt', {
      lambdaFunction: generateReceiptFn,
      outputPath: '$.Payload',
    });

    const notifyCustomer = new tasks.LambdaInvoke(this, 'NotifyCustomer', {
      lambdaFunction: processOrderFn,
      outputPath: '$.Payload',
    });

    const orderComplete = new sfn.Succeed(this, 'OrderComplete');

    const definition = validateOrder
      .next(processPayment)
      .next(generateReceipt)
      .next(notifyCustomer)
      .next(orderComplete);

    new sfn.StateMachine(this, 'OrderWorkflow', {
      stateMachineName: 'OrderWorkflow',
      definitionBody: sfn.DefinitionBody.fromChainable(definition),
      timeout: cdk.Duration.minutes(5),
    });

    // HTTP API Gateway
    const httpApi = new apigwv2.HttpApi(this, 'OrdersApi', {
      apiName: 'OrdersApi',
    });

    httpApi.addRoutes({
      path: '/orders',
      methods: [apigwv2.HttpMethod.POST],
      integration: new apigwv2Integrations.HttpLambdaIntegration('CreateOrderIntegration', createOrderFn),
    });

    httpApi.addRoutes({
      path: '/orders/{id}',
      methods: [apigwv2.HttpMethod.GET],
      integration: new apigwv2Integrations.HttpLambdaIntegration('GetOrderIntegration', getOrderFn),
    });

    // Outputs
    new cdk.CfnOutput(this, 'ApiUrl', {
      value: httpApi.url || '',
      description: 'HTTP API Gateway URL',
    });

    new cdk.CfnOutput(this, 'QueueUrl', {
      value: orderQueue.queueUrl,
      description: 'Order Queue URL',
    });

    new cdk.CfnOutput(this, 'TopicArn', {
      value: notificationTopic.topicArn,
      description: 'Notification Topic ARN',
    });
  }
}
