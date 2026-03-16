package io.localwebservices.lws.steps;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.SessionSpec;
import io.localwebservices.lws.StateMachineSpec;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ChaosSteps {

    private static final String PASS_DEFINITION =
            "{\"Comment\":\"test\",\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";

    private final WorldContext world;

    public ChaosSteps(WorldContext world) {
        this.world = world;
    }

    @Given("a running session with {int}% error rate on {string}")
    public void aRunningSessionWith100PercentErrorRateOn(int errorPct, String service) throws Exception {
        world.session = LwsSession.createInProcess(SessionSpec.empty());
        world.session.chaos(service).errorRate(errorPct / 100.0).apply();
    }

    @Given("an OrderProcessor state machine is running")
    public void anOrderProcessorStateMachineIsRunning() throws Exception {
        // Temporarily clear chaos on all services so resource creation succeeds even if chaos is active
        for (String svc : List.of("stepfunctions", "dynamodb", "sqs", "s3", "sns", "ssm", "secretsmanager")) {
            try { world.session.chaos(svc).clear(); } catch (Exception ignored) {}
        }
        // Temporarily disable IAM enforce so resource creation succeeds even if IAM is active
        boolean iamWasEnforced = false;
        try {
            world.session.iam().mode("disabled").apply();
            iamWasEnforced = true;
        } catch (Exception ignored) {}
        // Create the state machine via the SFN client
        try (var sfn = world.session.sfnClient()) {
            sfn.createStateMachine(r -> r
                    .name("OrderProcessor")
                    .definition(PASS_DEFINITION)
                    .roleArn("arn:aws:iam::000000000000:role/StepFunctionsRole")
                    .type(software.amazon.awssdk.services.sfn.model.StateMachineType.STANDARD));
        }
        // Note: the calling test step re-applies its own IAM/chaos settings afterwards
    }

    @When("I set a {int}% error rate on {string}")
    public void iSetAPercentErrorRateOn(int errorPct, String service) throws Exception {
        world.session.chaos(service).errorRate(errorPct / 100.0).apply();
    }

    @When("I clear chaos for {string}")
    public void iClearChaosFor(String service) throws Exception {
        world.session.chaos(service).clear();
    }

    @Then("an AWS error is returned")
    public void anAwsErrorIsReturned() {
        assertFalse(world.lastSuccess, "expected the call to fail with an AWS error");
        assertNotNull(world.lastError, "expected an error to be recorded");
    }

    @Then("the call succeeds")
    public void theCallSucceeds() {
        if (!world.lastSuccess) {
            fail("expected call to succeed but got error: " + world.lastError);
        }
    }
}
