package com.example.orders;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.SQSEvent;
import com.fasterxml.jackson.databind.ObjectMapper;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.UpdateItemRequest;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.PublishRequest;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.GetParameterRequest;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;

import java.time.Instant;
import java.util.*;

public class ProcessOrderHandler implements RequestHandler<Object, Map<String, Object>> {
    private final DynamoDbClient ddb = DynamoDbClient.create();
    private final SnsClient sns = SnsClient.create();
    private final SsmClient ssm = SsmClient.create();
    private final SecretsManagerClient sm = SecretsManagerClient.create();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public Map<String, Object> handleRequest(Object input, Context context) {
        try {
            // Handle both SQS event and direct invocation
            List<Map<String, Object>> records = new ArrayList<>();

            String inputJson = mapper.writeValueAsString(input);
            Map<String, Object> inputMap = mapper.readValue(inputJson, Map.class);

            if (inputMap.containsKey("Records")) {
                List<Map<String, Object>> rawRecords = (List<Map<String, Object>>) inputMap.get("Records");
                records.addAll(rawRecords);
            } else {
                Map<String, Object> r = new HashMap<>();
                r.put("body", inputJson);
                records.add(r);
            }

            String maxItemsVal = ssm.getParameter(GetParameterRequest.builder()
                .name(System.getenv().getOrDefault("MAX_ITEMS_PARAM", "/orders/config/max-items"))
                .build()).parameter().value();
            int maxItems = Integer.parseInt(maxItemsVal);

            String secretStr = sm.getSecretValue(GetSecretValueRequest.builder()
                .secretId(System.getenv().getOrDefault("NOTIFICATION_SECRET_ARN", "orders/notification-api-key"))
                .build()).secretString();
            String notificationKey = (String) mapper.readValue(secretStr, Map.class).getOrDefault("apiKey", "default");

            List<Map<String, Object>> results = new ArrayList<>();

            for (Map<String, Object> record : records) {
                String body = (String) record.get("body");
                Map<String, Object> order = mapper.readValue(body, Map.class);
                String orderId = (String) order.get("orderId");
                if (orderId == null) continue;

                ddb.updateItem(UpdateItemRequest.builder()
                    .tableName(System.getenv("TABLE_NAME"))
                    .key(Map.of("orderId", AttributeValue.fromS(orderId)))
                    .updateExpression("SET #status = :status")
                    .expressionAttributeNames(Map.of("#status", "status"))
                    .expressionAttributeValues(Map.of(":status", AttributeValue.fromS("PROCESSED")))
                    .build());

                Map<String, Object> notification = Map.of(
                    "orderId", orderId,
                    "status", "PROCESSED",
                    "timestamp", Instant.now().toString(),
                    "maxItems", maxItems,
                    "notificationKey", notificationKey.substring(0, Math.min(4, notificationKey.length())) + "****"
                );

                sns.publish(PublishRequest.builder()
                    .topicArn(System.getenv("TOPIC_ARN"))
                    .subject("Order " + orderId + " processed")
                    .message(mapper.writeValueAsString(notification))
                    .build());

                results.add(Map.of("orderId", orderId, "status", "PROCESSED"));
            }

            return Map.of("processed", results.size(), "results", results);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
