package io.localwebservices.lws.steps;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.SessionSpec;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class IamSteps {

    private final WorldContext world;

    public IamSteps(WorldContext world) {
        this.world = world;
    }

    @Given("IAM is in enforce mode with identity {string} allowed all {string} actions")
    public void iamIsInEnforceModeWithIdentityAllowedAllActions(String identity, String actionPattern) throws Exception {
        world.session.iam()
                .mode("enforce")
                .defaultIdentity(identity)
                .identity(identity)
                    .allow(List.of(actionPattern), "*")
                    .apply()
                .apply();
    }

    @Given("IAM is in enforce mode with identity {string} and no permissions")
    public void iamIsInEnforceModeWithIdentityAndNoPermissions(String identity) throws Exception {
        world.session.iam()
                .mode("enforce")
                .defaultIdentity(identity)
                .identity(identity)
                    .apply()
                .apply();
    }

    @Given("a running session with IAM enforce mode active")
    public void aRunningSessionWithIamEnforceModeActive() throws Exception {
        world.session = LwsSession.createInProcess(SessionSpec.empty());
        world.session.iam()
                .mode("enforce")
                .defaultIdentity("test-user")
                .identity("test-user")
                    .apply()
                .apply();
    }

    @When("I set IAM mode to {string}")
    public void iSetIamModeTo(String mode) throws Exception {
        world.session.iam().mode(mode).apply();
    }

    @Then("an IAM access denied error is returned")
    public void anIamAccessDeniedErrorIsReturned() {
        assertFalse(world.lastSuccess, "expected an IAM access denied error but call succeeded");
        assertNotNull(world.lastError, "expected an error to be recorded");
        String errorMsg = world.lastError.toString();
        boolean isAccessDenied = errorMsg.contains("AccessDenied")
                || errorMsg.contains("AccessDeniedException")
                || errorMsg.contains("NotAuthorized")
                || errorMsg.contains("403");
        assertTrue(isAccessDenied,
                "expected IAM access denied error but got: " + errorMsg);
    }
}
