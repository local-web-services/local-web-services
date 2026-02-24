package io.localwebservices.lws;

import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;
import software.amazon.awssdk.services.dynamodb.model.DeleteItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemRequest;
import software.amazon.awssdk.services.dynamodb.model.GetItemResponse;
import software.amazon.awssdk.services.dynamodb.model.PutItemRequest;
import software.amazon.awssdk.services.dynamodb.model.ScanRequest;
import software.amazon.awssdk.services.dynamodb.model.ScanResponse;

import java.util.List;
import java.util.Map;

/**
 * Wraps a single DynamoDB table for easy test seeding and assertions.
 *
 * <p>Obtain one via {@link LwsSession#dynamoDb(String)}:
 * <pre>{@code
 * DynamoDbHelper ddb = session.dynamoDb("Orders");
 * ddb.put(Map.of("orderId", AttributeValue.fromS("order-1")));
 * ddb.assertItemExists(Map.of("orderId", AttributeValue.fromS("order-1")));
 * ddb.assertItemCount(1);
 * }</pre>
 */
public class DynamoDbHelper {

    private final String tableName;
    private final DynamoDbClient client;

    DynamoDbHelper(String tableName, DynamoDbClient client) {
        this.tableName = tableName;
        this.client = client;
    }

    /** Writes an item to the table. */
    public void put(Map<String, AttributeValue> item) {
        client.putItem(PutItemRequest.builder()
                .tableName(tableName)
                .item(item)
                .build());
    }

    /**
     * Retrieves an item by its primary key.
     * Returns an empty map if the item does not exist.
     */
    public Map<String, AttributeValue> get(Map<String, AttributeValue> key) {
        GetItemResponse response = client.getItem(GetItemRequest.builder()
                .tableName(tableName)
                .key(key)
                .build());
        return response.item();
    }

    /** Removes an item by its primary key. */
    public void delete(Map<String, AttributeValue> key) {
        client.deleteItem(DeleteItemRequest.builder()
                .tableName(tableName)
                .key(key)
                .build());
    }

    /** Returns all items in the table. */
    public List<Map<String, AttributeValue>> scan() {
        ScanResponse response = client.scan(ScanRequest.builder()
                .tableName(tableName)
                .build());
        return response.items();
    }

    /**
     * Throws {@link AssertionError} if no item with the given key exists in the table.
     * Returns the item attributes on success.
     */
    public Map<String, AttributeValue> assertItemExists(Map<String, AttributeValue> key) {
        Map<String, AttributeValue> item = get(key);
        if (item == null || item.isEmpty()) {
            throw new AssertionError("DynamoDbHelper.assertItemExists: no item found in table '" + tableName + "'");
        }
        return item;
    }

    /** Throws {@link AssertionError} if the total item count differs from {@code expected}. */
    public void assertItemCount(int expected) {
        List<Map<String, AttributeValue>> items = scan();
        int actual = items.size();
        if (actual != expected) {
            throw new AssertionError(
                    "DynamoDbHelper.assertItemCount: got " + actual + " items, want " + expected);
        }
    }
}
