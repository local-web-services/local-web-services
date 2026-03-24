package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import software.amazon.awssdk.services.dynamodb.model.AttributeDefinition;
import software.amazon.awssdk.services.dynamodb.model.BillingMode;
import software.amazon.awssdk.services.dynamodb.model.KeySchemaElement;
import software.amazon.awssdk.services.dynamodb.model.KeyType;
import software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.secretsmanager.model.CreateSecretRequest;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.StateMachineType;
import software.amazon.awssdk.services.sns.model.CreateTopicRequest;
import software.amazon.awssdk.services.sqs.model.CreateQueueRequest;
import software.amazon.awssdk.services.ssm.model.ParameterType;
import software.amazon.awssdk.services.ssm.model.PutParameterRequest;

/** Package-private helper that provisions AWS resources into a running local session. */
class ResourceProvisioner {

  static final Map<String, Integer> SERVICE_OFFSETS;

  static {
    SERVICE_OFFSETS = new LinkedHashMap<>();
    SERVICE_OFFSETS.put("dynamodb", 1);
    SERVICE_OFFSETS.put("sqs", 2);
    SERVICE_OFFSETS.put("s3", 3);
    SERVICE_OFFSETS.put("sns", 4);
    SERVICE_OFFSETS.put("eventbridge", 5);
    SERVICE_OFFSETS.put("stepfunctions", 6);
    SERVICE_OFFSETS.put("cognito-idp", 7);
    SERVICE_OFFSETS.put("lambda", 8);
    SERVICE_OFFSETS.put("apigateway", 9);
    SERVICE_OFFSETS.put("rds", 10);
    SERVICE_OFFSETS.put("docdb", 11);
    SERVICE_OFFSETS.put("ssm", 12);
    SERVICE_OFFSETS.put("secretsmanager", 13);
    SERVICE_OFFSETS.put("elasticache", 14);
    SERVICE_OFFSETS.put("neptune", 15);
    SERVICE_OFFSETS.put("memorydb", 16);
    SERVICE_OFFSETS.put("glacier", 17);
    SERVICE_OFFSETS.put("elasticsearch", 18);
    SERVICE_OFFSETS.put("opensearch", 19);
    SERVICE_OFFSETS.put("s3tables", 20);
    SERVICE_OFFSETS.put("organizations", 50);
  }

  static void provision(LwsSession session, SessionSpec spec) {
    if (!spec.getTables().isEmpty()) {
      try (var ddb = session.dynamoDbClient()) {
        for (TableSpec t : spec.getTables()) {
          List<KeySchemaElement> keySchema = new ArrayList<>();
          List<AttributeDefinition> attrDefs = new ArrayList<>();
          keySchema.add(
              KeySchemaElement.builder()
                  .attributeName(t.getPartitionKey())
                  .keyType(KeyType.HASH)
                  .build());
          attrDefs.add(
              AttributeDefinition.builder()
                  .attributeName(t.getPartitionKey())
                  .attributeType(ScalarAttributeType.S)
                  .build());
          if (t.getSortKey() != null) {
            keySchema.add(
                KeySchemaElement.builder()
                    .attributeName(t.getSortKey())
                    .keyType(KeyType.RANGE)
                    .build());
            attrDefs.add(
                AttributeDefinition.builder()
                    .attributeName(t.getSortKey())
                    .attributeType(ScalarAttributeType.S)
                    .build());
          }
          ddb.createTable(
              r ->
                  r.tableName(t.getName())
                      .keySchema(keySchema)
                      .attributeDefinitions(attrDefs)
                      .billingMode(BillingMode.PAY_PER_REQUEST));
        }
      }
    }

    if (!spec.getQueues().isEmpty()) {
      try (var sqsc = session.sqsClient()) {
        for (String q : spec.getQueues()) {
          sqsc.createQueue(CreateQueueRequest.builder().queueName(q).build());
        }
      }
    }

    if (!spec.getBuckets().isEmpty()) {
      try (var s3c = session.s3Client()) {
        for (String b : spec.getBuckets()) {
          s3c.createBucket(CreateBucketRequest.builder().bucket(b).build());
        }
      }
    }

    if (!spec.getTopics().isEmpty()) {
      try (var snsc = session.snsClient()) {
        for (String t : spec.getTopics()) {
          snsc.createTopic(CreateTopicRequest.builder().name(t).build());
        }
      }
    }

    if (!spec.getStateMachines().isEmpty()) {
      try (SfnClient sfn = session.sfnClient()) {
        for (StateMachineSpec sm : spec.getStateMachines()) {
          String roleArn =
              sm.getRoleArn() != null
                  ? sm.getRoleArn()
                  : "arn:aws:iam::000000000000:role/StepFunctionsRole";
          sfn.createStateMachine(
              r ->
                  r.name(sm.getName())
                      .definition(sm.getDefinition())
                      .roleArn(roleArn)
                      .type(StateMachineType.STANDARD));
        }
      }
    }

    if (!spec.getParameters().isEmpty()) {
      try (var ssmc = session.ssmClient()) {
        for (String p : spec.getParameters()) {
          ssmc.putParameter(
              PutParameterRequest.builder()
                  .name(p)
                  .value("")
                  .type(ParameterType.STRING)
                  .overwrite(false)
                  .build());
        }
      }
    }

    if (!spec.getSecrets().isEmpty()) {
      try (var smc = session.secretsManagerClient()) {
        for (String sec : spec.getSecrets()) {
          smc.createSecret(CreateSecretRequest.builder().name(sec).secretString("").build());
        }
      }
    }
  }

  static void awaitReady(Process process, int basePort) throws Exception {
    final int maxRetries = 3;
    HttpClient httpClient = HttpClient.newBuilder().connectTimeout(Duration.ofSeconds(2)).build();
    URI statusUri = URI.create("http://127.0.0.1:" + basePort + "/_ldk/status");
    Exception lastError = null;
    for (int retry = 0; retry <= maxRetries; retry++) {
      for (int attempt = 0; attempt < 60; attempt++) {
        if (!process.isAlive()) {
          throw new RuntimeException("ldk dev process exited unexpectedly");
        }
        try {
          HttpRequest request =
              HttpRequest.newBuilder(statusUri).GET().timeout(Duration.ofSeconds(2)).build();
          HttpResponse<String> response =
              httpClient.send(request, HttpResponse.BodyHandlers.ofString());
          if (response.statusCode() < 400 && response.body().contains("\"running\":true")) {
            return;
          }
          lastError =
              new RuntimeException("status endpoint returned HTTP " + response.statusCode());
        } catch (Exception e) {
          lastError = e;
        }
        Thread.sleep(500);
      }
      if (retry < maxRetries) {
        System.out.printf(
            "[lws] ldk dev not ready after 30 s, retrying in 15 s... (%d/%d)%n",
            retry + 1, maxRetries);
        Thread.sleep(15_000);
      }
    }
    String reason = lastError != null ? ": " + lastError.getMessage() : "";
    throw new RuntimeException(
        "ldk dev did not become ready after " + maxRetries + " retries" + reason);
  }

  private ResourceProvisioner() {}
}
