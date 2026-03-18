package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;

import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.sns.SnsClient;

public class CommonSteps {

  private final WorldContext world;

  public CommonSteps(WorldContext world) {
    this.world = world;
  }

  @Then("the command will succeed")
  public void theCommandWillSucceed() {
    assertTrue(world.lastSuccess, "Expected success but got failure: " + world.lastOutput);
  }

  @Then("the command will fail")
  public void theCommandWillFail() {
    assertFalse(world.lastSuccess, "Expected failure but command succeeded");
  }

  @Then("the output will contain {string}")
  public void theOutputWillContain(String expected) {
    String actual = String.valueOf(world.lastOutput);
    assertTrue(
        actual.contains(expected),
        "Expected output to contain \"" + expected + "\" but got: " + actual);
  }

  @Then("the output will contain an IAM access denied error")
  public void theOutputWillContainIamAccessDeniedError() {
    String actual = String.valueOf(world.lastOutput);
    boolean hasAccessDenied =
        actual.contains("AccessDeniedException")
            || actual.contains("AccessDenied")
            || actual.contains("access denied")
            || actual.contains("NotAuthorizedException")
            || (world.lastSuccess == false
                && (actual.contains("403") || actual.contains("statusCode=403")));
    assertTrue(hasAccessDenied, "Expected IAM access denied error but got: " + actual);
  }

  @Then("the output will not contain an IAM access denied error")
  public void theOutputWillNotContainIamAccessDeniedError() {
    String actual = String.valueOf(world.lastOutput);
    boolean hasAccessDenied =
        actual.contains("AccessDeniedException") || actual.contains("AccessDenied");
    assertFalse(hasAccessDenied, "Expected no IAM access denied error but got: " + actual);
  }

  @Then("the output will contain a JSON chaos error")
  public void theOutputWillContainJsonChaosError() {
    String actual = String.valueOf(world.lastOutput);
    boolean hasChaos =
        actual.contains("__type")
            || actual.contains("InternalFailure")
            || actual.contains("ServiceUnavailable")
            || actual.contains("chaos")
            || !world.lastSuccess;
    assertTrue(hasChaos, "Expected JSON chaos error but got: " + actual);
  }

  @Then("the output will contain an XML chaos error")
  public void theOutputWillContainXmlChaosError() {
    String actual = String.valueOf(world.lastOutput);
    boolean hasChaos =
        actual.contains("ErrorResponse")
            || actual.contains("Error")
            || actual.contains("InternalError")
            || actual.contains("ServiceUnavailable")
            || !world.lastSuccess;
    assertTrue(hasChaos, "Expected XML chaos error but got: " + actual);
  }

  @Then("the output will contain an S3 XML chaos error")
  public void theOutputWillContainS3XmlChaosError() {
    String actual = String.valueOf(world.lastOutput);
    boolean hasChaos =
        actual.contains("Error")
            || actual.contains("InternalError")
            || actual.contains("ServiceUnavailable")
            || !world.lastSuccess;
    assertTrue(hasChaos, "Expected S3 XML chaos error but got: " + actual);
  }

  @Then("the call will have taken at least {int} milliseconds")
  public void theCallWillHaveTakenAtLeastMilliseconds(int minMs) {
    assertTrue(
        world.timedElapsedMs >= minMs,
        "Expected call to take at least " + minMs + "ms but took " + world.timedElapsedMs + "ms");
  }

  @When("I list tags for resource {string}")
  public void iListTagsForResource(String resourceArn) {
    // Dispatch to the appropriate service based on ARN
    if (resourceArn.startsWith("arn:aws:events:")) {
      try (EventBridgeClient client = world.eventbridgeClient()) {
        world.setSuccess(client.listTagsForResource(r -> r.resourceARN(resourceArn)));
      } catch (Exception e) {
        world.setFailure(e);
      }
    } else {
      // Default: SNS (or treat as topic name/arn)
      String arn =
          resourceArn.startsWith("arn:")
              ? resourceArn
              : "arn:aws:sns:us-east-1:000000000000:" + resourceArn;
      try (SnsClient client = world.snsClient()) {
        world.setSuccess(client.listTagsForResource(r -> r.resourceArn(arn)));
      } catch (Exception e) {
        world.setFailure(e);
      }
    }
  }

  @Then("the output will not contain {string}")
  public void theOutputWillNotContain(String expected) {
    String actual = String.valueOf(world.lastOutput);
    assertFalse(
        actual.contains(expected),
        "Expected output to not contain \"" + expected + "\" but got: " + actual);
  }
}
