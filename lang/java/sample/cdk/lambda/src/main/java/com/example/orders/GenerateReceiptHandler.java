package com.example.orders;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.fasterxml.jackson.databind.ObjectMapper;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.time.Instant;
import java.util.Map;

public class GenerateReceiptHandler implements RequestHandler<Map<String, Object>, Map<String, Object>> {
    private final S3Client s3 = S3Client.create();
    private final ObjectMapper mapper = new ObjectMapper();

    @Override
    public Map<String, Object> handleRequest(Map<String, Object> event, Context context) {
        try {
            String orderId = event.getOrDefault("orderId", "unknown").toString();
            String key = "receipts/" + orderId + ".json";

            Map<String, Object> receipt = Map.of(
                "orderId", orderId,
                "generatedAt", Instant.now().toString(),
                "items", event.getOrDefault("items", java.util.List.of()),
                "total", event.getOrDefault("total", 0),
                "status", "RECEIPT_GENERATED"
            );

            String receiptJson = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(receipt);

            s3.putObject(
                PutObjectRequest.builder()
                    .bucket(System.getenv("BUCKET_NAME"))
                    .key(key)
                    .contentType("application/json")
                    .build(),
                RequestBody.fromString(receiptJson)
            );

            return Map.of("orderId", orderId, "receiptKey", key);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
