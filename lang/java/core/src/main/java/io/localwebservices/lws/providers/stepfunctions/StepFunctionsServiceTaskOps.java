package io.localwebservices.lws.providers.stepfunctions;

import io.localwebservices.lws.providers.dynamodb.DynamoDbHandler;
import io.localwebservices.lws.providers.eventbridge.EventBridgeHandler;
import io.localwebservices.lws.providers.s3.S3Handler;
import io.localwebservices.lws.providers.secretsmanager.SecretsManagerHandler;
import io.localwebservices.lws.providers.sns.SnsHandler;
import io.localwebservices.lws.providers.sqs.SqsHandler;
import io.localwebservices.lws.providers.ssm.SsmHandler;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Handles service task bridge execution for Step Functions. Dispatches Task state resource ARNs to
 * the appropriate downstream service handler.
 */
class StepFunctionsServiceTaskOps {

  private DynamoDbHandler dynamoDbHandler;
  private SqsHandler sqsHandler;
  private SnsHandler snsHandler;
  private S3Handler s3Handler;
  private SecretsManagerHandler secretsManagerHandler;
  private SsmHandler ssmHandler;
  private EventBridgeHandler eventBridgeHandler;

  void setDynamoDbHandler(DynamoDbHandler dynamoDbHandler) {
    this.dynamoDbHandler = dynamoDbHandler;
  }

  void setSqsHandler(SqsHandler sqsHandler) {
    this.sqsHandler = sqsHandler;
  }

  void setSnsHandler(SnsHandler snsHandler) {
    this.snsHandler = snsHandler;
  }

  void setS3Handler(S3Handler s3Handler) {
    this.s3Handler = s3Handler;
  }

  void setSecretsManagerHandler(SecretsManagerHandler secretsManagerHandler) {
    this.secretsManagerHandler = secretsManagerHandler;
  }

  void setSsmHandler(SsmHandler ssmHandler) {
    this.ssmHandler = ssmHandler;
  }

  void setEventBridgeHandler(EventBridgeHandler eventBridgeHandler) {
    this.eventBridgeHandler = eventBridgeHandler;
  }

  /**
   * Executes a service integration task identified by its resource ARN. The params map contains the
   * task's Parameters field from the state machine definition. Returns the task output map, or null
   * if the ARN is not a recognised service integration.
   */
  @SuppressWarnings("unchecked")
  Map<String, Object> executeServiceTask(String resourceArn, Map<String, Object> params) {
    if (resourceArn == null) {
      return null;
    }
    if ("arn:aws:states:::dynamodb:putItem".equals(resourceArn)) {
      if (dynamoDbHandler == null) return new LinkedHashMap<>();
      return dynamoDbHandler.executePutItem(params);
    }
    if ("arn:aws:states:::dynamodb:getItem".equals(resourceArn)) {
      if (dynamoDbHandler == null) return new LinkedHashMap<>();
      return dynamoDbHandler.executeGetItem(params);
    }
    if ("arn:aws:states:::sqs:sendMessage".equals(resourceArn)) {
      if (sqsHandler == null) return new LinkedHashMap<>();
      return sqsHandler.executeSendMessage(params);
    }
    if ("arn:aws:states:::sns:publish".equals(resourceArn)) {
      if (snsHandler == null) return new LinkedHashMap<>();
      return snsHandler.executePublish(params);
    }
    if ("arn:aws:states:::s3:getObject".equals(resourceArn)) {
      if (s3Handler == null) return new LinkedHashMap<>();
      return s3Handler.executeGetObject(params);
    }
    if ("arn:aws:states:::s3:putObject".equals(resourceArn)) {
      if (s3Handler == null) return new LinkedHashMap<>();
      return s3Handler.executePutObject(params);
    }
    if ("arn:aws:states:::secretsmanager:getSecretValue".equals(resourceArn)) {
      if (secretsManagerHandler == null) return new LinkedHashMap<>();
      return secretsManagerHandler.executeGetSecretValue(params);
    }
    if ("arn:aws:states:::ssm:getParameter".equals(resourceArn)) {
      if (ssmHandler == null) return new LinkedHashMap<>();
      return ssmHandler.executeGetParameter(params);
    }
    if ("arn:aws:states:::events:putEvents".equals(resourceArn)) {
      if (eventBridgeHandler == null) return new LinkedHashMap<>();
      return eventBridgeHandler.executePutEvents(params);
    }
    return null;
  }
}
