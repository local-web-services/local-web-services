package io.localwebservices.lws.steps;

import io.cucumber.java.Before;
import io.cucumber.java.BeforeAll;

public class WorldHooks {

    private final WorldContext world;

    public WorldHooks(WorldContext world) {
        this.world = world;
    }

    @BeforeAll
    public static void startServer() throws Exception {
        WorldContext.ensureServerStarted();
    }

    @Before
    public void resetBetweenScenarios() throws Exception {
        world.reset();
        // Clear result state
        world.lastSuccess = false;
        world.lastOutput = null;
        world.lastError = null;
        world.lastReceiptHandle = null;
        world.lastQueueUrl = null;
        world.lastUploadId = null;
        world.lastBucket = null;
        world.lastKey = null;
        world.lastETag = null;
        world.lastExecutionArn = null;
        world.lastStateMachineArn = null;
        world.lastSubscriptionArn = null;
        world.lastTopicArn = null;
    }
}
