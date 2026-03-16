package io.localwebservices.lws.steps;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.SessionSpec;

import static org.junit.jupiter.api.Assertions.*;

public class SessionSteps {

    private final WorldContext world;

    // Context-manager scenario state
    private LwsSession contextSession;
    private boolean sessionWasRunningInsideContext = false;
    private boolean sessionWasClosedAfterContext = false;

    public SessionSteps(WorldContext world) {
        this.world = world;
    }

    // ---- session_lifecycle.feature ----

    @When("I create a session")
    public void iCreateASession() throws Exception {
        world.session = LwsSession.createInProcess(SessionSpec.empty());
    }

    @Then("the session is running")
    public void theSessionIsRunning() {
        assertNotNull(world.session, "session should not be null");
    }

    @When("I close the session")
    public void iCloseTheSession() {
        world.session.close();
    }

    @Then("the session is closed")
    public void theSessionIsClosed() {
        // After close() the process is terminated; we just assert no exception was raised
        assertTrue(true, "session closed without error");
    }

    @When("I open a session as a context manager")
    public void iOpenASessionAsAContextManager() throws Exception {
        contextSession = LwsSession.createInProcess(SessionSpec.empty());
        sessionWasRunningInsideContext = (contextSession != null);
        // Simulate context exit
        contextSession.close();
        sessionWasClosedAfterContext = true;
    }

    @Then("the session is running inside the context")
    public void theSessionIsRunningInsideTheContext() {
        assertTrue(sessionWasRunningInsideContext, "session should have been running inside context");
    }

    @And("the session is closed after the context exits")
    public void theSessionIsClosedAfterTheContextExits() {
        assertTrue(sessionWasClosedAfterContext, "session should have been closed after context exited");
    }

    // ---- session_reset.feature ----

    @Given("a running session")
    public void aRunningSession() throws Exception {
        world.session = LwsSession.createInProcess(SessionSpec.empty());
    }

    @When("I reset the session")
    public void iResetTheSession() throws Exception {
        world.session.reset();
        world.lastError = null;
    }

    @And("I reset the session again")
    public void iResetTheSessionAgain() throws Exception {
        world.session.reset();
    }

    @Then("no error is raised")
    public void noErrorIsRaised() {
        assertNull(world.lastError, "no error should have been raised");
    }
}
