package com.example.orders;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPEvent;
import com.amazonaws.services.lambda.runtime.events.APIGatewayV2HTTPResponse;
import com.fasterxml.jackson.databind.ObjectMapper;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;

import java.util.Map;

public class GetOrderHandler implements RequestHandler<APIGatewayV2HTTPEvent, APIGatewayV2HTTPResponse> {
    private final DynamoDbClient ddb = DynamoDbClient.create();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public APIGatewayV2HTTPResponse handleRequest(APIGatewayV2HTTPEvent event, Context context) {
        try {
            Map<String, String> pathParams = event.getPathParameters();
            String orderId = pathParams != null ? pathParams.get("id") : null;

            if (orderId == null) {
                return APIGatewayV2HTTPResponse.builder()
                    .withStatusCode(400)
                    .withHeaders(Map.of("Content-Type", "application/json"))
                    .withBody("{\"error\":\"Missing orderId\"}")
                    .build();
            }

            String tableName = System.getenv("TABLE_NAME");

            GetItemResponse result = ddb.getItem(GetItemRequest.builder()
                .tableName(tableName)
                .key(Map.of("orderId", AttributeValue.fromS(orderId)))
                .build());

            if (!result.hasItem()) {
                return APIGatewayV2HTTPResponse.builder()
                    .withStatusCode(404)
                    .withHeaders(Map.of("Content-Type", "application/json"))
                    .withBody("{\"error\":\"Order not found\"}")
                    .build();
            }

            Map<String, AttributeValue> item = result.item();
            Map<String, Object> order = Map.of(
                "orderId", item.get("orderId").s(),
                "customerName", item.get("customerName").s(),
                "items", mapper.readValue(item.get("items").s(), java.util.List.class),
                "total", Double.parseDouble(item.get("total").n()),
                "status", item.get("status").s(),
                "createdAt", item.get("createdAt").s()
            );

            return APIGatewayV2HTTPResponse.builder()
                .withStatusCode(200)
                .withHeaders(Map.of("Content-Type", "application/json"))
                .withBody(mapper.writeValueAsString(order))
                .build();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
