package io.localwebservices.lws.steps;

import io.cucumber.java.After;
import io.cucumber.java.Before;

public class WorldHooks {

    private final WorldContext world;

    public WorldHooks(WorldContext world) {
        this.world = world;
    }

    @Before
    public void resetBeforeScenario() {
        // Each scenario gets a fresh WorldContext (PicoContainer creates a new instance per scenario).
        // Nothing to do here — session is created by Given steps.
    }

    @After
    public void cleanupAfterScenario() throws Exception {
        if (world.logCapture != null) {
            try { world.logCapture.stop(); } catch (Exception ignored) {}
            world.logCapture = null;
        }
        if (world.session != null) {
            try { world.session.close(); } catch (Exception ignored) {}
            world.session = null;
        }
    }
}
