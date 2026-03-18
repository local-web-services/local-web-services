package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.*;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.*;

public class SqsSteps {

  private final WorldContext world;

  public SqsSteps(WorldContext world) {
    this.world = world;
  }

  // --- Given ---

  @Given("a queue {string} was created")
  public void aQueueWasCreated(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      client.createQueue(r -> r.queueName(queueName));
    }
  }

  @Given("a message {string} was sent to queue {string}")
  public void aMessageWasSentToQueue(String messageBody, String queueName) {
    try (SqsClient client = world.sqsClient()) {
      client.sendMessage(r -> r.queueUrl(world.sqsQueueUrl(queueName)).messageBody(messageBody));
    }
  }

  @Given("a message was received from queue {string}")
  public void aMessageWasReceivedFromQueue(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .maxNumberOfMessages(1)
                      .waitTimeSeconds(0));
      world.lastReceiptHandle =
          result.messages().isEmpty() ? null : result.messages().get(0).receiptHandle();
    }
  }

  @Given("queue {string} was tagged with {string}")
  public void queueWasTaggedWith(String queueName, String tagsJson) throws Exception {
    Map<String, String> tags =
        new com.fasterxml.jackson.databind.ObjectMapper().readValue(tagsJson, Map.class);
    try (SqsClient client = world.sqsClient()) {
      client.tagQueue(r -> r.queueUrl(world.sqsQueueUrl(queueName)).tags(tags));
    }
  }

  // --- When ---

  @When("I create a queue named {string}")
  public void iCreateAQueueNamed(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.createQueue(r -> r.queueName(queueName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete the queue {string}")
  public void iDeleteTheQueue(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.deleteQueue(r -> r.queueUrl(world.sqsQueueUrl(queueName))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list queues")
  public void iListQueues() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.listQueues());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I send a message {string} to queue {string}")
  public void iSendAMessageToQueue(String messageBody, String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.sendMessage(
              r -> r.queueUrl(world.sqsQueueUrl(queueName)).messageBody(messageBody)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I send a message batch with entries {string} to queue {string}")
  public void iSendAMessageBatchWithEntriesToQueue(String entriesJson, String queueName)
      throws Exception {
    List<Map<String, String>> entries =
        new com.fasterxml.jackson.databind.ObjectMapper().readValue(entriesJson, List.class);
    List<SendMessageBatchRequestEntry> batchEntries = new ArrayList<>();
    for (Map<String, String> e : entries) {
      batchEntries.add(
          SendMessageBatchRequestEntry.builder()
              .id(e.get("Id"))
              .messageBody(e.get("MessageBody"))
              .build());
    }
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.sendMessageBatch(
              r -> r.queueUrl(world.sqsQueueUrl(queueName)).entries(batchEntries)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I receive a message from queue {string}")
  public void iReceiveAMessageFromQueue(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .maxNumberOfMessages(1)
                      .waitTimeSeconds(0));
      world.setSuccess(result);
      world.lastReceiptHandle =
          result.messages().isEmpty() ? null : result.messages().get(0).receiptHandle();
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete the received message from queue {string}")
  public void iDeleteTheReceivedMessageFromQueue(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.deleteMessage(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName)).receiptHandle(world.lastReceiptHandle)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete messages in batch for the received message in queue {string}")
  public void iDeleteMessagesInBatchForTheReceivedMessageInQueue(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.deleteMessageBatch(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .entries(
                          DeleteMessageBatchRequestEntry.builder()
                              .id("1")
                              .receiptHandle(world.lastReceiptHandle)
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I purge queue {string}")
  public void iPurgeQueue(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.purgeQueue(r -> r.queueUrl(world.sqsQueueUrl(queueName))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get queue attributes for {string}")
  public void iGetQueueAttributesFor(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r -> r.queueUrl(world.sqsQueueUrl(queueName)).attributeNamesWithStrings("All"));
      world.setSuccess(Map.of("GetQueueAttributesResponse", result));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I set queue attributes {string} on queue {string}")
  public void iSetQueueAttributesOnQueue(String attrsJson, String queueName) throws Exception {
    Map<String, String> attrs =
        new com.fasterxml.jackson.databind.ObjectMapper().readValue(attrsJson, Map.class);
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.setQueueAttributes(
              r -> r.queueUrl(world.sqsQueueUrl(queueName)).attributesWithStrings(attrs)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get the queue URL for {string}")
  public void iGetTheQueueUrlFor(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.getQueueUrl(r -> r.queueName(queueName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I tag queue {string} with tags {string}")
  public void iTagQueueWithTags(String queueName, String tagsJson) throws Exception {
    Map<String, String> tags =
        new com.fasterxml.jackson.databind.ObjectMapper().readValue(tagsJson, Map.class);
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.tagQueue(r -> r.queueUrl(world.sqsQueueUrl(queueName)).tags(tags)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I untag queue {string} with tag keys {string}")
  public void iUntagQueueWithTagKeys(String queueName, String tagKeysJson) throws Exception {
    List<String> tagKeys =
        new com.fasterxml.jackson.databind.ObjectMapper().readValue(tagKeysJson, List.class);
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.untagQueue(r -> r.queueUrl(world.sqsQueueUrl(queueName)).tagKeys(tagKeys)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list queue tags for {string}")
  public void iListQueueTagsFor(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.listQueueTags(r -> r.queueUrl(world.sqsQueueUrl(queueName))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I change the visibility timeout to {string} for the received message in queue {string}")
  public void iChangeTheVisibilityTimeoutToForTheReceivedMessageInQueue(
      String timeout, String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.changeMessageVisibility(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .receiptHandle(world.lastReceiptHandle)
                      .visibilityTimeout(Integer.parseInt(timeout))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When(
      "I change message visibility in batch with timeout {string} for the received message in queue {string}")
  public void iChangeMessageVisibilityInBatchWithTimeoutForTheReceivedMessageInQueue(
      String timeout, String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.changeMessageVisibilityBatch(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .entries(
                          ChangeMessageVisibilityBatchRequestEntry.builder()
                              .id("1")
                              .receiptHandle(world.lastReceiptHandle)
                              .visibilityTimeout(Integer.parseInt(timeout))
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list dead letter source queues for {string}")
  public void iListDeadLetterSourceQueuesFor(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(
          client.listDeadLetterSourceQueues(r -> r.queueUrl(world.sqsQueueUrl(queueName))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list SQS queues with timing")
  public void iListSQSQueuesWithTiming() {
    try (SqsClient client = world.sqsClient()) {
      long start = System.currentTimeMillis();
      ListQueuesResponse result = client.listQueues();
      world.timedElapsedMs = System.currentTimeMillis() - start;
      world.timedSuccess = true;
      world.timedOutput = result;
    } catch (Exception e) {
      world.timedSuccess = false;
      world.timedOutput = e;
      world.timedElapsedMs = 0;
    }
  }

  @When("I list SQS queues")
  public void iListSQSQueues() {
    try (SqsClient client = world.sqsClient()) {
      world.setSuccess(client.listQueues());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  // --- Then ---

  @Then("the queue {string} will appear in the queue list")
  public void theQueueWillAppearInTheQueueList(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      ListQueuesResponse result = client.listQueues();
      boolean found = result.queueUrls().stream().anyMatch(url -> url.contains(queueName));
      assertTrue(
          found, "Expected queue \"" + queueName + "\" in list but got: " + result.queueUrls());
    }
  }

  @Then("the queue {string} will not appear in the queue list")
  public void theQueueWillNotAppearInTheQueueList(String queueName) {
    try (SqsClient client = world.sqsClient()) {
      ListQueuesResponse result = client.listQueues();
      boolean found = result.queueUrls().stream().anyMatch(url -> url.contains(queueName));
      assertFalse(found, "Expected queue \"" + queueName + "\" to not be in list");
    }
  }

  @Then("the output will contain queue {string}")
  public void theOutputWillContainQueue(String queueName) {
    String actual = String.valueOf(world.lastOutput);
    assertTrue(
        actual.contains(queueName),
        "Expected output to contain queue \"" + queueName + "\" but got: " + actual);
  }

  @Then("the output will contain a message with body {string}")
  public void theOutputWillContainAMessageWithBody(String expectedBody) {
    String actual = String.valueOf(world.lastOutput);
    assertTrue(
        actual.contains(expectedBody),
        "Expected output to contain message body \"" + expectedBody + "\" but got: " + actual);
  }

  @Then("queue {string} will contain a message with body {string}")
  public void queueWillContainAMessageWithBody(String queueName, String expectedBody) {
    try (SqsClient client = world.sqsClient()) {
      ReceiveMessageResponse result =
          client.receiveMessage(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .maxNumberOfMessages(10)
                      .waitTimeSeconds(0));
      boolean found = result.messages().stream().anyMatch(m -> expectedBody.equals(m.body()));
      assertTrue(found, "Expected queue to have message \"" + expectedBody + "\"");
    }
  }

  @Then("queue {string} will have approximate message count {string}")
  public void queueWillHaveApproximateMessageCount(String queueName, String expectedCount) {
    try (SqsClient client = world.sqsClient()) {
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r ->
                  r.queueUrl(world.sqsQueueUrl(queueName))
                      .attributeNamesWithStrings("ApproximateNumberOfMessages"));
      String actual = result.attributesAsStrings().getOrDefault("ApproximateNumberOfMessages", "0");
      assertEquals(expectedCount, actual);
    }
  }

  @Then("queue {string} will have attribute {string} equal to {string}")
  public void queueWillHaveAttributeEqualTo(
      String queueName, String attrName, String expectedValue) {
    try (SqsClient client = world.sqsClient()) {
      GetQueueAttributesResponse result =
          client.getQueueAttributes(
              r -> r.queueUrl(world.sqsQueueUrl(queueName)).attributeNamesWithStrings("All"));
      String actual = result.attributesAsStrings().get(attrName);
      assertEquals(expectedValue, actual);
    }
  }

  @Then("queue {string} will have tag {string} with value {string}")
  public void queueWillHaveTagWithValue(String queueName, String tagKey, String expectedValue) {
    try (SqsClient client = world.sqsClient()) {
      ListQueueTagsResponse result =
          client.listQueueTags(r -> r.queueUrl(world.sqsQueueUrl(queueName)));
      String actual = result.tags().get(tagKey);
      assertEquals(expectedValue, actual);
    }
  }

  @Then("queue {string} will not have tag {string}")
  public void queueWillNotHaveTag(String queueName, String tagKey) {
    try (SqsClient client = world.sqsClient()) {
      ListQueueTagsResponse result =
          client.listQueueTags(r -> r.queueUrl(world.sqsQueueUrl(queueName)));
      String value = result.tags().get(tagKey);
      assertNull(value, "Expected tag \"" + tagKey + "\" to not exist but got: " + value);
    }
  }
}
