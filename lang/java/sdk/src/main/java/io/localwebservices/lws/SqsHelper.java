package io.localwebservices.lws;

import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.GetQueueAttributesRequest;
import software.amazon.awssdk.services.sqs.model.GetQueueAttributesResponse;
import software.amazon.awssdk.services.sqs.model.Message;
import software.amazon.awssdk.services.sqs.model.PurgeQueueRequest;
import software.amazon.awssdk.services.sqs.model.QueueAttributeName;
import software.amazon.awssdk.services.sqs.model.ReceiveMessageRequest;
import software.amazon.awssdk.services.sqs.model.ReceiveMessageResponse;
import software.amazon.awssdk.services.sqs.model.SendMessageRequest;
import software.amazon.awssdk.services.sqs.model.SendMessageResponse;

import java.util.List;

/**
 * Wraps a single SQS queue for easy test message operations.
 *
 * <p>Obtain one via {@link LwsSession#sqs(String)}:
 * <pre>{@code
 * SqsHelper queue = session.sqs("OrderQueue");
 * queue.send("{\"orderId\":\"order-1\"}");
 * List<Message> messages = queue.receive(1);
 * queue.assertMessageCount(1);
 * }</pre>
 */
public class SqsHelper {

    private final String queueName;
    private final String queueUrl;
    private final SqsClient client;

    SqsHelper(String queueName, String queueUrl, SqsClient client) {
        this.queueName = queueName;
        this.queueUrl = queueUrl;
        this.client = client;
    }

    /** Returns the queue URL. */
    public String url() {
        return queueUrl;
    }

    /** Sends a message body to the queue and returns the message ID. */
    public String send(String body) {
        SendMessageResponse response = client.sendMessage(SendMessageRequest.builder()
                .queueUrl(queueUrl)
                .messageBody(body)
                .build());
        return response.messageId();
    }

    /** Receives up to {@code maxMessages} messages from the queue. */
    public List<Message> receive(int maxMessages) {
        ReceiveMessageResponse response = client.receiveMessage(ReceiveMessageRequest.builder()
                .queueUrl(queueUrl)
                .maxNumberOfMessages(maxMessages)
                .waitTimeSeconds(1)
                .build());
        return response.messages();
    }

    /** Deletes all messages from the queue. */
    public void purge() {
        client.purgeQueue(PurgeQueueRequest.builder()
                .queueUrl(queueUrl)
                .build());
    }

    /** Throws {@link AssertionError} if the approximate visible message count differs from {@code expected}. */
    public void assertMessageCount(int expected) {
        GetQueueAttributesResponse response = client.getQueueAttributes(
                GetQueueAttributesRequest.builder()
                        .queueUrl(queueUrl)
                        .attributeNames(QueueAttributeName.APPROXIMATE_NUMBER_OF_MESSAGES)
                        .build());
        String countStr = response.attributes().get(QueueAttributeName.APPROXIMATE_NUMBER_OF_MESSAGES);
        int actual = countStr != null ? Integer.parseInt(countStr) : 0;
        if (actual != expected) {
            throw new AssertionError(
                    "SqsHelper.assertMessageCount: got " + actual + " messages, want " + expected
                    + " (queue: " + queueName + ")");
        }
    }
}
