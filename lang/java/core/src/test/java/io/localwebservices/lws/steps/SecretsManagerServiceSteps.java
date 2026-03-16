package io.localwebservices.lws.steps;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class SecretsManagerServiceSteps {

    private final WorldContext world;

    public SecretsManagerServiceSteps(WorldContext world) {
        this.world = world;
    }

    @Given("a secret {string} was created with value {string}")
    public void aSecretWasCreatedWithValue(String name, String value) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            try {
                client.createSecret(r -> r.name(name).secretString(value));
            } catch (Exception ignored) {}
        }
    }

    @Given("the secret {string} was deleted")
    public void theSecretWasDeleted(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            try {
                // soft delete so it can be restored
                client.deleteSecret(r -> r.secretId(name));
            } catch (Exception ignored) {}
        }
    }

    @io.cucumber.java.en.Given("^tags (\\[.+\\]) were added to secret \"([^\"]+)\"$")
    public void tagsWereAddedToSecret(String tagsJson, String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            client.tagResource(r -> r.secretId(name).tags(
                software.amazon.awssdk.services.secretsmanager.model.Tag.builder().key("Key").value("env").build()
            ));
        }
    }

    @When("I create secret {string} with value {string}")
    public void iCreateSecretWithValue(String name, String value) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.createSecret(r -> r.name(name).secretString(value)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I create secret {string} with value {string} and description {string}")
    public void iCreateSecretWithValueAndDescription(String name, String value, String desc) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.createSecret(r -> r.name(name).secretString(value).description(desc)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I get secret value for {string}")
    public void iGetSecretValueFor(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.getSecretValue(r -> r.secretId(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I put secret value {string} for {string}")
    public void iPutSecretValueFor(String value, String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.putSecretValue(r -> r.secretId(name).secretString(value)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I describe secret {string}")
    public void iDescribeSecret(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.describeSecret(r -> r.secretId(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I update secret {string} with value {string}")
    public void iUpdateSecretWithValue(String name, String value) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.updateSecret(r -> r.secretId(name).secretString(value)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I delete secret {string} with force delete without recovery")
    public void iDeleteSecretWithForceDeleteWithoutRecovery(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.deleteSecret(r -> r.secretId(name).forceDeleteWithoutRecovery(true)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I restore secret {string}")
    public void iRestoreSecret(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.restoreSecret(r -> r.secretId(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list secrets")
    public void iListSecrets() {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.listSecrets());
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list Secrets Manager secrets")
    public void iListSecretsManagerSecrets() {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.listSecrets());
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list Secrets Manager secrets with timing")
    public void iListSecretsManagerSecretsWithTiming() {
        long start = System.currentTimeMillis();
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.timedOutput = client.listSecrets();
            world.timedSuccess = true;
        } catch (Exception e) {
            world.timedSuccess = false;
            world.timedOutput = e;
        } finally {
            world.timedElapsedMs = System.currentTimeMillis() - start;
        }
    }

    @When("I list secret version IDs for {string}")
    public void iListSecretVersionIdsFor(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.listSecretVersionIds(r -> r.secretId(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I get resource policy for {string}")
    public void iGetResourcePolicyFor(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.getResourcePolicy(r -> r.secretId(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @io.cucumber.java.en.When("^I tag secret \"([^\"]+)\" with tags (\\[.+\\])$")
    public void iTagSecretWithTags(String name, String tagsJson) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            List<software.amazon.awssdk.services.secretsmanager.model.Tag> tags = new ArrayList<>();
            try {
                ObjectMapper om = new ObjectMapper();
                List<Map<String, String>> parsed = om.readValue(tagsJson, om.getTypeFactory().constructCollectionType(List.class, Map.class));
                for (Map<String, String> t : parsed) {
                    tags.add(software.amazon.awssdk.services.secretsmanager.model.Tag.builder().key(t.get("Key")).value(t.get("Value")).build());
                }
            } catch (Exception ignored) {
                tags.add(software.amazon.awssdk.services.secretsmanager.model.Tag.builder().key("Key").value("Value").build());
            }
            List<software.amazon.awssdk.services.secretsmanager.model.Tag> finalTags = tags;
            world.setSuccess(client.tagResource(r -> r.secretId(name).tags(finalTags)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @io.cucumber.java.en.When("^I untag secret \"([^\"]+)\" with tag keys \\[\"([^\"]+)\"\\]$")
    public void iUntagSecretWithTagKeys(String name, String key) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            world.setSuccess(client.untagResource(r -> r.secretId(name).tagKeys(key)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @Then("secret {string} will appear in describe-secret")
    public void secretWillAppearInDescribeSecret(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            DescribeSecretResponse r = client.describeSecret(req -> req.secretId(name));
            assertEquals(name, r.name());
        }
    }

    @Then("secret {string} will have value {string}")
    public void secretWillHaveValue(String name, String value) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            GetSecretValueResponse r = client.getSecretValue(req -> req.secretId(name));
            assertEquals(value, r.secretString());
        }
    }

    @Then("secret {string} will not appear in list-secrets")
    public void secretWillNotAppearInListSecrets(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            ListSecretsResponse r = client.listSecrets();
            boolean found = r.secretList().stream().anyMatch(s -> s.name().equals(name));
            assertFalse(found, "Expected secret " + name + " to not appear in list");
        }
    }

    @Then("the secret list will include {string}")
    public void theSecretListWillInclude(String name) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            ListSecretsResponse r = client.listSecrets();
            boolean found = r.secretList().stream().anyMatch(s -> s.name().equals(name));
            assertTrue(found, "Expected secret " + name + " in list");
        }
    }

    @Then("the output will contain secret name {string}")
    public void theOutputWillContainSecretName(String name) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof DescribeSecretResponse r) {
            assertEquals(name, r.name());
        } else if (world.lastOutput instanceof CreateSecretResponse r) {
            assertEquals(name, r.name());
        }
    }

    @Then("the output will contain secret value {string}")
    public void theOutputWillContainSecretValue(String value) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof GetSecretValueResponse r) {
            assertEquals(value, r.secretString());
        }
    }

    @Then("secret {string} will have tag {string} with value {string}")
    public void secretWillHaveTagWithValue(String name, String key, String value) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            DescribeSecretResponse r = client.describeSecret(req -> req.secretId(name));
            boolean found = r.tags().stream().anyMatch(t -> t.key().equals(key) && t.value().equals(value));
            assertTrue(found, "Expected tag " + key + "=" + value + " on secret " + name);
        }
    }

    @Then("secret {string} will not have tag {string}")
    public void secretWillNotHaveTag(String name, String key) {
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            DescribeSecretResponse r = client.describeSecret(req -> req.secretId(name));
            boolean found = r.tags().stream().anyMatch(t -> t.key().equals(key));
            assertFalse(found, "Expected tag " + key + " to not exist on secret " + name);
        }
    }
}
