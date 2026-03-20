package com.example.orders;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.PutItemRequest;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

public class CreateOrderHandler implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {
    private final DynamoDbClient ddb = DynamoDbClient.create();
    private final SqsClient sqs = SqsClient.create();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent event, Context context) {
        try {
            Map<String, Object> body = mapper.readValue(
                event.getBody() != null ? event.getBody() : "{}", Map.class);

            String orderId = UUID.randomUUID().toString();
            String now = Instant.now().toString();
            String tableName = System.getenv("TABLE_NAME");
            String queueUrl = System.getenv("QUEUE_URL");

            Map<String, AttributeValue> item = new HashMap<>();
            item.put("orderId", AttributeValue.fromS(orderId));
            item.put("customerName", AttributeValue.fromS(
                body.getOrDefault("customerName", "Unknown").toString()));
            item.put("items", AttributeValue.fromS(
                mapper.writeValueAsString(body.getOrDefault("items", java.util.List.of()))));
            item.put("total", AttributeValue.fromN(
                body.getOrDefault("total", 0).toString()));
            item.put("status", AttributeValue.fromS("CREATED"));
            item.put("createdAt", AttributeValue.fromS(now));

            ddb.putItem(PutItemRequest.builder()
                .tableName(tableName)
                .item(item)
                .build());

            Map<String, Object> msg = new HashMap<>(body);
            msg.put("orderId", orderId);
            sqs.sendMessage(SendMessageRequest.builder()
                .queueUrl(queueUrl)
                .messageBody(mapper.writeValueAsString(msg))
                .build());

            Map<String, Object> responseBody = Map.of(
                "orderId", orderId,
                "status", "CREATED",
                "createdAt", now
            );

            return APIGatewayV2HTTPResponse.builder()
                .withStatusCode(201)
                .withHeaders(Map.of("Content-Type", "application/json"))
                .withBody(mapper.writeValueAsString(responseBody))
                .build();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
