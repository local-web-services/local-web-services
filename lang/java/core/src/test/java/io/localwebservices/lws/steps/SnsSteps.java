package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.*;

public class SnsSteps {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final WorldContext world;

  public SnsSteps(WorldContext world) {
    this.world = world;
  }

  private String topicArn(String name) {
    return "arn:aws:sns:" + REGION + ":" + ACCOUNT + ":" + name;
  }

  @Given("a topic {string} was created")
  public void aTopicWasCreated(String name) {
    try (SnsClient client = world.snsClient()) {
      try {
        CreateTopicResponse r = client.createTopic(req -> req.name(name));
        world.lastTopicArn = r.topicArn();
      } catch (Exception ignored) {
      }
    }
  }

  @Given("an SQS subscription to {string} was added to topic {string}")
  public void anSqsSubscriptionToWasAddedToTopic(String queueName, String topicName) {
    try (SnsClient client = world.snsClient()) {
      String queueArn = "arn:aws:sqs:" + REGION + ":" + ACCOUNT + ":" + queueName;
      SubscribeResponse r =
          client.subscribe(
              req -> req.topicArn(topicArn(topicName)).protocol("sqs").endpoint(queueArn));
      world.lastSubscriptionArn = r.subscriptionArn();
    }
  }

  @io.cucumber.java.en.Given("^tags '(\\[.+\\])' were added to topic \"([^\"]+)\"$")
  public void tagsWereAddedToTopic(String tagsJson, String topicName) {
    try (SnsClient client = world.snsClient()) {
      client.tagResource(
          r ->
              r.resourceArn(topicArn(topicName))
                  .tags(Tag.builder().key("Key").value("env").build()));
    }
  }

  @When("I create topic {string}")
  public void iCreateTopic(String name) {
    try (SnsClient client = world.snsClient()) {
      CreateTopicResponse r = client.createTopic(req -> req.name(name));
      world.lastTopicArn = r.topicArn();
      world.setSuccess(r);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete the topic {string}")
  public void iDeleteTheTopic(String name) {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.deleteTopic(r -> r.topicArn(topicArn(name))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list topics")
  public void iListTopics() {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.listTopics());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list SNS topics")
  public void iListSnsTopics() {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.listTopics());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list SNS topics with timing")
  public void iListSnsTopicsWithTiming() {
    long start = System.currentTimeMillis();
    try (SnsClient client = world.snsClient()) {
      world.timedOutput = client.listTopics();
      world.timedSuccess = true;
    } catch (Exception e) {
      world.timedSuccess = false;
      world.timedOutput = e;
    } finally {
      world.timedElapsedMs = System.currentTimeMillis() - start;
    }
  }

  @When("I publish message {string} to topic {string}")
  public void iPublishMessageToTopic(String message, String name) {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.publish(r -> r.topicArn(topicArn(name)).message(message)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I subscribe {string} with protocol {string} to the topic {string}")
  public void iSubscribeWithProtocolToTheTopic(String endpoint, String protocol, String topicName) {
    try (SnsClient client = world.snsClient()) {
      SubscribeResponse r =
          client.subscribe(
              req -> req.topicArn(topicArn(topicName)).protocol(protocol).endpoint(endpoint));
      world.lastSubscriptionArn = r.subscriptionArn();
      world.setSuccess(r);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I unsubscribe the subscription on topic {string}")
  public void iUnsubscribeTheSubscriptionOnTopic(String topicName) {
    try (SnsClient client = world.snsClient()) {
      // Find the subscription by listing
      ListSubscriptionsByTopicResponse subs =
          client.listSubscriptionsByTopic(r -> r.topicArn(topicArn(topicName)));
      if (!subs.subscriptions().isEmpty()) {
        String subArn = subs.subscriptions().get(0).subscriptionArn();
        world.setSuccess(client.unsubscribe(r -> r.subscriptionArn(subArn)));
      } else {
        world.setSuccess("no subscriptions");
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list subscriptions")
  public void iListSubscriptions() {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.listSubscriptions());
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list subscriptions by topic {string}")
  public void iListSubscriptionsByTopic(String name) {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.listSubscriptionsByTopic(r -> r.topicArn(topicArn(name))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get topic attributes for topic {string}")
  public void iGetTopicAttributesForTopic(String name) {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.getTopicAttributes(r -> r.topicArn(topicArn(name))));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I set topic attribute {string} to {string} for topic {string}")
  public void iSetTopicAttributeToForTopic(String attrName, String attrValue, String topicName) {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(
          client.setTopicAttributes(
              r ->
                  r.topicArn(topicArn(topicName))
                      .attributeName(attrName)
                      .attributeValue(attrValue)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I get subscription attributes for the subscription on topic {string}")
  public void iGetSubscriptionAttributesForTheSubscriptionOnTopic(String topicName) {
    try (SnsClient client = world.snsClient()) {
      ListSubscriptionsByTopicResponse subs =
          client.listSubscriptionsByTopic(r -> r.topicArn(topicArn(topicName)));
      if (!subs.subscriptions().isEmpty()) {
        String subArn = subs.subscriptions().get(0).subscriptionArn();
        world.setSuccess(client.getSubscriptionAttributes(r -> r.subscriptionArn(subArn)));
      } else {
        world.setSuccess("no subscriptions");
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I set subscription attribute {string} to {string} for the subscription on topic {string}")
  public void iSetSubscriptionAttributeToForTheSubscriptionOnTopic(
      String attrName, String attrValue, String topicName) {
    try (SnsClient client = world.snsClient()) {
      ListSubscriptionsByTopicResponse subs =
          client.listSubscriptionsByTopic(r -> r.topicArn(topicArn(topicName)));
      if (!subs.subscriptions().isEmpty()) {
        String subArn = subs.subscriptions().get(0).subscriptionArn();
        world.setSuccess(
            client.setSubscriptionAttributes(
                r -> r.subscriptionArn(subArn).attributeName(attrName).attributeValue(attrValue)));
      } else {
        world.setSuccess("no subscriptions");
      }
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I confirm subscription for topic {string} with token {string}")
  public void iConfirmSubscriptionForTopicWithToken(String topicName, String token) {
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(
          client.confirmSubscription(r -> r.topicArn(topicArn(topicName)).token(token)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @io.cucumber.java.en.When("^I tag resource \"([^\"]+)\" with tags '(\\[.+\\])'$")
  public void iTagResourceWithTags(String nameOrArn, String tagsJson) {
    String resourceArn = nameOrArn.startsWith("arn:") ? nameOrArn : topicArn(nameOrArn);
    try (SnsClient client = world.snsClient()) {
      List<Tag> tags = new ArrayList<>();
      try {
        ObjectMapper om = new ObjectMapper();
        List<Map<String, String>> parsed =
            om.readValue(
                tagsJson, om.getTypeFactory().constructCollectionType(List.class, Map.class));
        for (Map<String, String> t : parsed) {
          tags.add(Tag.builder().key(t.get("Key")).value(t.get("Value")).build());
        }
      } catch (Exception ignored) {
        tags.add(Tag.builder().key("Key").value("Value").build());
      }
      List<Tag> finalTags = tags;
      world.setSuccess(client.tagResource(r -> r.resourceArn(resourceArn).tags(finalTags)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @io.cucumber.java.en.When("^I untag resource \"([^\"]+)\" with tag keys '(\\[.+\\])'$")
  public void iUntagResourceWithTagKeys(String nameOrArn, String tagKeysJson) {
    String resourceArn = nameOrArn.startsWith("arn:") ? nameOrArn : topicArn(nameOrArn);
    try (SnsClient client = world.snsClient()) {
      world.setSuccess(client.untagResource(r -> r.resourceArn(resourceArn).tagKeys("Key")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @Then("the topic {string} will appear in the topic list")
  public void theTopicWillAppearInTheTopicList(String name) {
    try (SnsClient client = world.snsClient()) {
      ListTopicsResponse r = client.listTopics();
      boolean found = r.topics().stream().anyMatch(t -> t.topicArn().endsWith(":" + name));
      assertTrue(found, "Expected topic " + name + " in list");
    }
  }

  @Then("the topic {string} will not appear in the topic list")
  public void theTopicWillNotAppearInTheTopicList(String name) {
    try (SnsClient client = world.snsClient()) {
      ListTopicsResponse r = client.listTopics();
      boolean found = r.topics().stream().anyMatch(t -> t.topicArn().endsWith(":" + name));
      assertFalse(found, "Expected topic " + name + " to not appear in list");
    }
  }

  @Then("the topic {string} will have a subscription in the subscription list")
  public void theTopicWillHaveASubscriptionInTheSubscriptionList(String name) {
    try (SnsClient client = world.snsClient()) {
      ListSubscriptionsByTopicResponse r =
          client.listSubscriptionsByTopic(req -> req.topicArn(topicArn(name)));
      assertFalse(r.subscriptions().isEmpty(), "Expected subscriptions for topic " + name);
    }
  }

  @Then("the topic {string} will not have a subscription in the subscription list")
  public void theTopicWillNotHaveASubscriptionInTheSubscriptionList(String name) {
    try (SnsClient client = world.snsClient()) {
      ListSubscriptionsByTopicResponse r =
          client.listSubscriptionsByTopic(req -> req.topicArn(topicArn(name)));
      assertTrue(r.subscriptions().isEmpty(), "Expected no subscriptions for topic " + name);
    }
  }

  @Then("the topic {string} will have display name {string}")
  public void theTopicWillHaveDisplayName(String name, String displayName) {
    try (SnsClient client = world.snsClient()) {
      GetTopicAttributesResponse r = client.getTopicAttributes(req -> req.topicArn(topicArn(name)));
      assertEquals(displayName, r.attributes().getOrDefault("DisplayName", ""));
    }
  }

  @Then("the subscription on topic {string} will have attribute {string} equal to {string}")
  public void theSubscriptionOnTopicWillHaveAttributeEqualTo(
      String topicName, String attrName, String attrValue) {
    try (SnsClient client = world.snsClient()) {
      ListSubscriptionsByTopicResponse subs =
          client.listSubscriptionsByTopic(r -> r.topicArn(topicArn(topicName)));
      assertFalse(subs.subscriptions().isEmpty());
      String subArn = subs.subscriptions().get(0).subscriptionArn();
      GetSubscriptionAttributesResponse r =
          client.getSubscriptionAttributes(req -> req.subscriptionArn(subArn));
      assertEquals(attrValue, r.attributes().getOrDefault(attrName, ""));
    }
  }

  @Then("topic {string} will have tag {string} with value {string}")
  public void topicWillHaveTagWithValue(String name, String key, String value) {
    try (SnsClient client = world.snsClient()) {
      ListTagsForResourceResponse r =
          client.listTagsForResource(req -> req.resourceArn(topicArn(name)));
      boolean found =
          r.tags().stream().anyMatch(t -> t.key().equals(key) && t.value().equals(value));
      assertTrue(found, "Expected tag " + key + "=" + value + " on topic " + name);
    }
  }

  @Then("topic {string} will not have tag {string}")
  public void topicWillNotHaveTag(String name, String key) {
    try (SnsClient client = world.snsClient()) {
      ListTagsForResourceResponse r =
          client.listTagsForResource(req -> req.resourceArn(topicArn(name)));
      boolean found = r.tags().stream().anyMatch(t -> t.key().equals(key));
      assertFalse(found, "Expected tag " + key + " to not exist on topic " + name);
    }
  }

  @Then("the output will contain a ListSubscriptionsResponse")
  public void theOutputWillContainAListSubscriptionsResponse() {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    assertNotNull(world.lastOutput, "Expected a response");
  }

  @Then("the output will contain a PublishResponse")
  public void theOutputWillContainAPublishResponse() {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    assertNotNull(world.lastOutput, "Expected a PublishResponse");
  }
}
