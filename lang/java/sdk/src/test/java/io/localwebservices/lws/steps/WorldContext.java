package io.localwebservices.lws.steps;

import io.localwebservices.lws.LogCapture;
import io.localwebservices.lws.LwsSession;
import java.util.List;

/**
 * Shared Cucumber world state for one scenario. A new instance is created per scenario
 * (PicoContainer DI).
 */
public class WorldContext {

  // Active session for the current scenario
  public LwsSession session;

  // Last call result
  public boolean lastSuccess = false;
  public Object lastOutput = null;
  public Throwable lastError = null;

  // Log capture
  public LogCapture logCapture;

  // Received SQS messages
  public List<software.amazon.awssdk.services.sqs.model.Message> lastMessages;
  public int lastMessageCount = 0;

  // Cross-service state
  public String lastTopicArn;
  public String lastStateMachineArn;
  public String lastExecutionArn;

  // SQS spec state — receipt handle for in-flight message operations
  public String sqsReceiptHandle;

  // Active SQS queue name — set by SQS spec steps; null means use the default cross-service queue.
  public String sqsActiveQueueName;

  // S3api multipart upload state — set when an S3 multipart upload is created for s3api scenarios.
  public String s3UploadId;
  public String s3UploadBucket;

  // Cognito IDP spec state
  public String cognitoPoolId;
  public String cognitoUsername;
  public String cognitoGroupName;

  public void setSuccess(Object output) {
    lastSuccess = true;
    lastOutput = output;
    lastError = null;
  }

  public void setFailure(Throwable error) {
    lastSuccess = false;
    lastOutput = error;
    lastError = error;
  }
}
