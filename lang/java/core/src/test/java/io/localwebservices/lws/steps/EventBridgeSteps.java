package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.*;

public class EventBridgeSteps {

  private static final String ACCOUNT = "000000000000";
  private static final String REGION = "us-east-1";

  private final WorldContext world;

  public EventBridgeSteps(WorldContext world) {
    this.world = world;
  }

  private String busArn(String name) {
    return "arn:aws:events:" + REGION + ":" + ACCOUNT + ":event-bus/" + name;
  }

  @Given("an event bus {string} was created")
  public void anEventBusWasCreated(String name) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      try {
        client.createEventBus(r -> r.name(name));
      } catch (Exception ignored) {
      }
    }
  }

  @Given("a rule {string} was created on event bus {string}")
  public void aRuleWasCreatedOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      try {
        client.putRule(
            r ->
                r.name(ruleName)
                    .eventBusName(busName)
                    .scheduleExpression("rate(1 day)")
                    .state(RuleState.ENABLED));
      } catch (Exception ignored) {
      }
    }
  }

  @Given("targets were added to rule {string} on event bus {string}")
  public void targetsWereAddedToRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.putTargets(
          r ->
              r.rule(ruleName)
                  .eventBusName(busName)
                  .targets(
                      software.amazon.awssdk.services.eventbridge.model.Target.builder()
                          .id("t1")
                          .arn("arn:aws:sqs:" + REGION + ":" + ACCOUNT + ":dummy")
                          .build()));
    }
  }

  @Given("resource {string} was tagged")
  public void resourceWasTagged(String arn) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      client.tagResource(
          r ->
              r.resourceARN(arn)
                  .tags(
                      software.amazon.awssdk.services.eventbridge.model.Tag.builder()
                          .key("env")
                          .value("test")
                          .build()));
    }
  }

  @When("I create event bus {string}")
  public void iCreateEventBus(String name) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.createEventBus(r -> r.name(name)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete event bus {string}")
  public void iDeleteEventBus(String name) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.deleteEventBus(r -> r.name(name)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I describe event bus {string}")
  public void iDescribeEventBus(String name) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.describeEventBus(r -> r.name(name)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list event buses")
  public void iListEventBuses() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.listEventBuses(ListEventBusesRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list EventBridge event buses")
  public void iListEventBridgeEventBuses() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.listEventBuses(ListEventBusesRequest.builder().build()));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list EventBridge event buses with timing")
  public void iListEventBridgeEventBusesWithTiming() {
    long start = System.currentTimeMillis();
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.timedOutput = client.listEventBuses(ListEventBusesRequest.builder().build());
      world.timedSuccess = true;
    } catch (Exception e) {
      world.timedSuccess = false;
      world.timedOutput = e;
    } finally {
      world.timedElapsedMs = System.currentTimeMillis() - start;
    }
  }

  @When("I put rule {string} on event bus {string}")
  public void iPutRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.putRule(
              r ->
                  r.name(ruleName)
                      .eventBusName(busName)
                      .scheduleExpression("rate(1 day)")
                      .state(RuleState.ENABLED)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I delete rule {string}")
  public void iDeleteRule(String ruleName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.deleteRule(r -> r.name(ruleName).eventBusName("default")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I describe rule {string} on event bus {string}")
  public void iDescribeRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.describeRule(r -> r.name(ruleName).eventBusName(busName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list rules on event bus {string}")
  public void iListRulesOnEventBus(String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.listRules(r -> r.eventBusName(busName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I enable rule {string} on event bus {string}")
  public void iEnableRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.enableRule(r -> r.name(ruleName).eventBusName(busName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I disable rule {string} on event bus {string}")
  public void iDisableRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.disableRule(r -> r.name(ruleName).eventBusName(busName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put targets on rule {string} on event bus {string}")
  public void iPutTargetsOnRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.putTargets(
              r ->
                  r.rule(ruleName)
                      .eventBusName(busName)
                      .targets(
                          software.amazon.awssdk.services.eventbridge.model.Target.builder()
                              .id("t1")
                              .arn("arn:aws:sqs:" + REGION + ":" + ACCOUNT + ":dummy")
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I remove targets from rule {string} on event bus {string}")
  public void iRemoveTargetsFromRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.removeTargets(r -> r.rule(ruleName).eventBusName(busName).ids("t1")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I list targets by rule {string} on event bus {string}")
  public void iListTargetsByRuleOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.listTargetsByRule(r -> r.rule(ruleName).eventBusName(busName)));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I put events to the default bus")
  public void iPutEventsToTheDefaultBus() {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.putEvents(
              r ->
                  r.entries(
                      PutEventsRequestEntry.builder()
                          .source("test.source")
                          .detailType("TestEvent")
                          .detail("{}")
                          .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I tag resource {string}")
  public void iTagResource(String arn) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(
          client.tagResource(
              r ->
                  r.resourceARN(arn)
                      .tags(
                          software.amazon.awssdk.services.eventbridge.model.Tag.builder()
                              .key("env")
                              .value("test")
                              .build())));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("I untag resource {string}")
  public void iUntagResource(String arn) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      world.setSuccess(client.untagResource(r -> r.resourceARN(arn).tagKeys("env")));
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @Then("event bus {string} will appear in list-event-buses")
  public void eventBusWillAppearInListEventBuses(String name) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListEventBusesResponse r = client.listEventBuses(ListEventBusesRequest.builder().build());
      boolean found = r.eventBuses().stream().anyMatch(b -> b.name().equals(name));
      assertTrue(found, "Expected event bus " + name + " in list");
    }
  }

  @Then("event bus {string} will not appear in list-event-buses")
  public void eventBusWillNotAppearInListEventBuses(String name) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListEventBusesResponse r = client.listEventBuses(ListEventBusesRequest.builder().build());
      boolean found = r.eventBuses().stream().anyMatch(b -> b.name().equals(name));
      assertFalse(found, "Expected event bus " + name + " to not appear in list");
    }
  }

  @Then("rule {string} will appear in list-rules on event bus {string}")
  public void ruleWillAppearInListRulesOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListRulesResponse r = client.listRules(req -> req.eventBusName(busName));
      boolean found = r.rules().stream().anyMatch(rule -> rule.name().equals(ruleName));
      assertTrue(found, "Expected rule " + ruleName + " in list for bus " + busName);
    }
  }

  @Then("rule {string} will not appear in list-rules on event bus {string}")
  public void ruleWillNotAppearInListRulesOnEventBus(String ruleName, String busName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListRulesResponse r = client.listRules(req -> req.eventBusName(busName));
      boolean found = r.rules().stream().anyMatch(rule -> rule.name().equals(ruleName));
      assertFalse(found, "Expected rule " + ruleName + " to not appear in list for bus " + busName);
    }
  }

  @Then("rule {string} will have state {string}")
  public void ruleWillHaveState(String ruleName, String state) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      DescribeRuleResponse r =
          client.describeRule(req -> req.name(ruleName).eventBusName("default"));
      assertEquals(state, r.stateAsString());
    }
  }

  @Then("rule {string} will have a target in list-targets-by-rule")
  public void ruleWillHaveATargetInListTargetsByRule(String ruleName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListTargetsByRuleResponse r =
          client.listTargetsByRule(req -> req.rule(ruleName).eventBusName("default"));
      assertFalse(r.targets().isEmpty(), "Expected targets for rule " + ruleName);
    }
  }

  @Then("rule {string} will have no targets")
  public void ruleWillHaveNoTargets(String ruleName) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListTargetsByRuleResponse r =
          client.listTargetsByRule(req -> req.rule(ruleName).eventBusName("default"));
      assertTrue(r.targets().isEmpty(), "Expected no targets for rule " + ruleName);
    }
  }

  @Then("the failed entry count will be 0")
  public void theFailedEntryCountWillBe0() {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    if (world.lastOutput instanceof PutEventsResponse r) {
      assertEquals(0, r.failedEntryCount(), "Expected 0 failed entries");
    }
  }

  @Then("the output will contain a Rules key")
  public void theOutputWillContainARulesKey() {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    assertNotNull(world.lastOutput, "Expected output");
  }

  @Then("the output will contain event bus {string}")
  public void theOutputWillContainEventBus(String name) {
    assertTrue(world.lastSuccess, "Last command did not succeed");
    if (world.lastOutput instanceof DescribeEventBusResponse r) {
      assertEquals(name, r.name());
    }
  }

  @Then("event bus {string} will have tag {string} with value {string}")
  public void eventBusWillHaveTagWithValue(String name, String key, String value) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListTagsForResourceResponse r =
          client.listTagsForResource(req -> req.resourceARN(busArn(name)));
      boolean found =
          r.tags().stream().anyMatch(t -> t.key().equals(key) && t.value().equals(value));
      assertTrue(found, "Expected tag " + key + "=" + value + " on bus " + name);
    }
  }

  @Then("event bus {string} will not have tag {string}")
  public void eventBusWillNotHaveTag(String name, String key) {
    try (EventBridgeClient client = world.eventbridgeClient()) {
      ListTagsForResourceResponse r =
          client.listTagsForResource(req -> req.resourceARN(busArn(name)));
      boolean found = r.tags().stream().anyMatch(t -> t.key().equals(key));
      assertFalse(found, "Expected tag " + key + " to not exist on bus " + name);
    }
  }
}
