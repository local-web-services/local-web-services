package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.*;
import static org.junit.jupiter.api.Assumptions.assumeTrue;

import io.cucumber.java.en.And;
import io.cucumber.java.en.When;
import io.localwebservices.lws.CdkDiscovery;
import io.localwebservices.lws.LwsSession;
import io.localwebservices.lws.SessionSpec;
import java.net.URL;
import java.nio.file.Path;

public class DiscoverySteps {

  private final WorldContext world;

  public DiscoverySteps(WorldContext world) {
    this.world = world;
  }

  @When("I create a session from the {string} CDK directory")
  public void iCreateASessionFromTheCdkDirectory(String cdkDir) throws Exception {
    // Use the CDK fixture bundled in the SDK test resources
    URL fixtureUrl = getClass().getClassLoader().getResource("testdata/cdk-fixture");
    if (fixtureUrl == null) {
      // Pending — no fixture available in this module yet
      assumeTrue(false, "Not yet implemented");
    }
    Path fixtureDir = Path.of(fixtureUrl.toURI());
    SessionSpec spec = CdkDiscovery.discover(fixtureDir);
    world.session = LwsSession.createInProcess(spec);
  }

  @And("the resources declared in the CDK stack are available")
  public void theResourcesDeclaredInTheCdkStackAreAvailable() {
    assumeTrue(false, "Not yet implemented");
  }

  @When("I create a session from the {string} HCL directory")
  public void iCreateASessionFromTheHclDirectory(String hclDir) throws Exception {
    assumeTrue(false, "Not yet implemented");
  }

  @And("the resources declared in the HCL are available")
  public void theResourcesDeclaredInTheHclAreAvailable() {
    assumeTrue(false, "Not yet implemented");
  }
}
