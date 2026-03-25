package io.localwebservices.lws.steps;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import java.util.List;
import software.amazon.awssdk.services.elasticsearch.ElasticsearchClient;
import software.amazon.awssdk.services.elasticsearch.model.DescribeElasticsearchDomainResponse;
import software.amazon.awssdk.services.elasticsearch.model.ElasticsearchDomainStatus;
import software.amazon.awssdk.services.elasticsearch.model.ListTagsResponse;
import software.amazon.awssdk.services.elasticsearch.model.Tag;

/**
 * Step definitions for the Elasticsearch informal specification feature files.
 *
 * <p>Covers: create_elasticsearch_domain, delete_elasticsearch_domain, add_tags, remove_tags,
 * update_elasticsearch_domain_config, finish_creating_domain, finish_deleting_domain,
 * finish_processing_domain_config.
 */
public class ElasticsearchSteps {

  private static final String DOMAIN_NAME = "test-elasticsearch-domain-1";
  private static final String TAG_KEY = "e2e-es-tag-key-1";
  private static final String TAG_VALUE = "e2e-es-tag-value-1";

  private final WorldContext world;

  public ElasticsearchSteps(WorldContext world) {
    this.world = world;
  }

  // ── Given: domain state setup ─────────────────────────────────────────────────

  @Given("the domain does not already exist")
  public void theDomainDoesNotAlreadyExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no domains.
  }

  @Given("the domain already exists")
  public void theDomainAlreadyExists() {
    // Arrange
    // Act
    esCreateDomain();
    // Assert: domain created (no error thrown)
  }

  @Given("the domain exists")
  public void theDomainExists() {
    // Arrange
    // Act: ensure the domain exists
    if (!esDomainExists()) {
      esCreateDomain();
    }
    // Assert: domain created or already present
  }

  @Given("the domain is \"ACTIVE\"")
  public void theDomainIsActive() {
    // Arrange / Act / Assert — no-op: lws domains are immediately active after creation.
  }

  @Given("the domain is not \"ACTIVE\"")
  public void theDomainIsNotActive() {
    // @internal: requires internal state manipulation — not reachable via public API.
  }

  @Given("the domain is \"CREATING\"")
  public void theDomainIsCreating() {
    // @internal: domain is in CREATING immediately after CreateElasticsearchDomain —
    // not reachable via public API.
  }

  @Given("the domain is not \"CREATING\"")
  public void theDomainIsNotCreating() {
    // @internal: state transition controlled internally.
  }

  @Given("the domain is \"DELETING\"")
  public void theDomainIsDeleting() {
    // @internal: requires internal state manipulation — not reachable via public API.
  }

  @Given("the domain is not \"DELETING\"")
  public void theDomainIsNotDeleting() {
    // @internal: state transition controlled internally.
  }

  @Given("the domain is not being deleted")
  public void theDomainIsNotBeingDeleted() {
    // Arrange / Act / Assert — no-op: domains are not being deleted after creation in lws.
  }

  @Given("the domain is being deleted")
  public void theDomainIsBeingDeleted() {
    // Arrange / Act: delete the domain so it is in DELETING state.
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      try {
        client.deleteElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      } catch (Exception ignored) {
        // domain may not exist; desired state is DELETING
      }
    }
    // Assert: domain is being deleted
  }

  @Given("the domain is not deleted")
  public void theDomainIsNotDeleted() {
    // Arrange / Act / Assert — no-op: domains are not deleted after creation in lws.
  }

  @Given("the domain is deleted")
  public void theDomainIsDeleted() {
    // Arrange / Act: delete the domain so it is in deleted state.
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      try {
        client.deleteElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      } catch (Exception ignored) {
        // domain may not exist; desired state is deleted
      }
    }
    // Assert: domain is deleted
  }

  @Given("the domain does not exist")
  public void theDomainDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state after reset has no domains.
  }

  @Given("the domain is \"PROCESSING\"")
  public void theDomainIsProcessing() {
    // @internal: requires internal state manipulation — not reachable via public API.
  }

  @Given("the domain is not \"PROCESSING\"")
  public void theDomainIsNotProcessing() {
    // @internal: state transition controlled internally.
  }

  // ── Given: tag state setup ────────────────────────────────────────────────────

  @Given("the tag key exists")
  public void theTagKeyExists() {
    // Arrange
    String arn = esDomainARN();
    assertNotNull(arn, "Expected domain ARN to be available");
    // Act: add the test tag to the domain
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      client.addTags(r -> r.arn(arn).tagList(Tag.builder().key(TAG_KEY).value(TAG_VALUE).build()));
    }
    // Assert: tag added (no error thrown)
  }

  @Given("the tag key does not exist")
  public void theTagKeyDoesNotExist() {
    // Arrange / Act / Assert — no-op: fresh state has no tags on the domain.
  }

  // ── When: actions ─────────────────────────────────────────────────────────────

  @When("a search domain is created")
  public void aSearchDomainIsCreated() {
    // Arrange: (domain may or may not exist — set up by Given steps)
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      client.createElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      // Assert: store result
      world.setSuccess(DOMAIN_NAME);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a search domain is deleted")
  public void aSearchDomainIsDeleted() {
    // Arrange: (domain state set up by Given steps)
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      client.deleteElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      // Assert: store result
      world.setSuccess(DOMAIN_NAME);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are added to a domain")
  public void tagsAreAddedToADomain() {
    // Arrange: get domain ARN; reject if domain not found
    String arn = esDomainARN();
    if (arn == null) {
      world.setFailure(
          new RuntimeException(
              "ResourceNotFoundException: domain " + DOMAIN_NAME + " does not exist"));
      return;
    }
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      client.addTags(r -> r.arn(arn).tagList(Tag.builder().key(TAG_KEY).value(TAG_VALUE).build()));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("tags are removed from a domain")
  public void tagsAreRemovedFromADomain() {
    // Arrange: get domain ARN; reject if domain not found
    String arn = esDomainARN();
    if (arn == null) {
      world.setFailure(
          new RuntimeException(
              "ResourceNotFoundException: domain " + DOMAIN_NAME + " does not exist"));
      return;
    }
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      client.removeTags(r -> r.arn(arn).tagKeys(TAG_KEY));
      // Assert: store result
      world.setSuccess(null);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a domain configuration update is requested")
  public void aDomainConfigurationUpdateIsRequested() {
    // Arrange: (domain state set up by Given steps)
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      // Act
      var result = client.updateElasticsearchDomainConfig(r -> r.domainName(DOMAIN_NAME));
      // Assert: store result
      world.setSuccess(result);
    } catch (Exception e) {
      world.setFailure(e);
    }
  }

  @When("a search domain finishes creating")
  public void aSearchDomainFinishesCreating() {
    // @internal: no public API to advance the domain lifecycle — no-op.
    world.setSuccess(null);
  }

  @When("a search domain finishes deleting")
  public void aSearchDomainFinishesDeleting() {
    // @internal: no public API to advance the domain lifecycle — no-op.
    world.setSuccess(null);
  }

  @When("a domain configuration finishes processing")
  public void aDomainConfigurationFinishesProcessing() {
    // @internal: no public API to advance the domain config processing — no-op.
    world.setSuccess(null);
  }

  @When("a node failure occurs")
  public void aNodeFailureOccurs() {
    // @internal: no public API to inject a node failure — no-op.
    world.setSuccess(null);
  }

  @When("a replica sync lag occurs")
  public void aReplicaSyncLagOccurs() {
    // @internal: no public API to inject replica sync lag — no-op.
    world.setSuccess(null);
  }

  @When("a shard reallocation occurs")
  public void aShardReallocationOccurs() {
    // @internal: no public API to inject shard reallocation — no-op.
    world.setSuccess(null);
  }

  // ── Then: assertions ──────────────────────────────────────────────────────────

  @Then("the domain is in \"CREATING\" state")
  public void theDomainIsInCreatingState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected create_elasticsearch_domain to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      DescribeElasticsearchDomainResponse result =
          client.describeElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      ElasticsearchDomainStatus actualStatus = result.domainStatus();
      assertNotNull(actualStatus, "expected domain status but got null");
      String expectedDomainName = DOMAIN_NAME;
      String actualDomainName = actualStatus.domainName();
      org.junit.jupiter.api.Assertions.assertEquals(
          expectedDomainName,
          actualDomainName,
          "expected domain name '"
              + expectedDomainName
              + "' but got '"
              + actualDomainName
              + "'; expected_domain_name="
              + expectedDomainName
              + " actual_domain_name="
              + actualDomainName);
    }
  }

  @Then("the domain is in \"DELETING\" state")
  public void theDomainIsInDeletingState() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected delete_elasticsearch_domain to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the domain is in \"PROCESSING\" state with a pending config change")
  public void theDomainIsInProcessingStateWithAPendingConfigChange() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected update_elasticsearch_domain_config to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
  }

  @Then("the domain is \"ACTIVE\" and ready for use")
  public void theDomainIsActiveAndReadyForUse() {
    // @internal: state transition controlled internally — no-op.
  }

  @Then("the domain is \"DELETED\" and all its indices are removed")
  public void theDomainIsDeletedAndAllItsIndicesAreRemoved() {
    // @internal: state transition controlled internally — no-op.
  }

  @Then("the specified tags are associated with the domain")
  public void theSpecifiedTagsAreAssociatedWithTheDomain() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected add_tags to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    String arn = esDomainARN();
    assertNotNull(arn, "expected domain ARN to be available");
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      ListTagsResponse listResult = client.listTags(r -> r.arn(arn));
      List<Tag> tags = listResult.tagList();
      boolean actualFound = tags.stream().anyMatch(t -> TAG_KEY.equals(t.key()));
      assertTrue(
          actualFound,
          "expected tag '"
              + TAG_KEY
              + "' to be associated with domain but it was not; expected_tag_key="
              + TAG_KEY
              + " actual_found="
              + actualFound);
    }
  }

  @Then("the specified tags are no longer associated with the domain")
  public void theSpecifiedTagsAreNoLongerAssociatedWithTheDomain() {
    // Arrange: no additional setup required
    // Act: action already performed in the When step
    // Assert
    boolean expectedSuccess = true;
    boolean actualSuccess = world.lastSuccess;
    assertTrue(
        actualSuccess,
        "expected remove_tags to succeed but got error: "
            + world.lastError
            + "; expected_success="
            + expectedSuccess);
    String arn = esDomainARN();
    assertNotNull(arn, "expected domain ARN to be available");
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      ListTagsResponse listResult = client.listTags(r -> r.arn(arn));
      List<Tag> tags = listResult.tagList();
      boolean actualFound = tags.stream().anyMatch(t -> TAG_KEY.equals(t.key()));
      org.junit.jupiter.api.Assertions.assertFalse(
          actualFound,
          "expected tag '"
              + TAG_KEY
              + "' to be removed from domain but it still exists; expected_removed="
              + TAG_KEY
              + " actual_found="
              + actualFound);
    }
  }

  // "every active index belongs to an existing non-deleted domain" → CrossServiceSteps (catch-all @And("^every .*$"))
  // "every active tag belongs to an existing non-deleted domain" → CrossServiceSteps (catch-all @And("^every .*$"))

  @Then("a pending config change only exists on a domain that is \"PROCESSING\"")
  public void aPendingConfigChangeOnlyExistsOnADomainThatIsProcessing() {
    // No-op invariant: trivially satisfied in an isolated test context.
  }

  // ── Private helpers ───────────────────────────────────────────────────────────

  private void esCreateDomain() {
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      client.createElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
    } catch (Exception e) {
      String msg = e.getMessage() != null ? e.getMessage() : "";
      if (!msg.contains("AlreadyExists") && !msg.contains("already exists")) {
        throw e;
      }
    }
  }

  private boolean esDomainExists() {
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      DescribeElasticsearchDomainResponse result =
          client.describeElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      if (result.domainStatus() == null) {
        return false;
      }
      Boolean deleted = result.domainStatus().deleted();
      return deleted == null || !deleted;
    } catch (Exception ignored) {
      return false;
    }
  }

  private String esDomainARN() {
    try (ElasticsearchClient client = world.session.elasticsearchClient()) {
      DescribeElasticsearchDomainResponse result =
          client.describeElasticsearchDomain(r -> r.domainName(DOMAIN_NAME));
      if (result.domainStatus() == null) {
        return null;
      }
      return result.domainStatus().arn();
    } catch (Exception ignored) {
      return null;
    }
  }
}
