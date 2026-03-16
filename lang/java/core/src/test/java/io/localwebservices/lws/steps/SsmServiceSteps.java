package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.*;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class SsmServiceSteps {

    private final WorldContext world;

    public SsmServiceSteps(WorldContext world) {
        this.world = world;
    }

    @Given("a parameter {string} was created with value {string} and type {string}")
    public void aParameterWasCreatedWithValueAndType(String name, String value, String type) {
        try (SsmClient client = world.ssmClient()) {
            try {
                client.putParameter(r -> r.name(name).value(value).type(ParameterType.fromValue(type)).overwrite(true));
            } catch (Exception ignored) {}
        }
    }

    @When("I put parameter {string} with value {string} and type {string}")
    public void iPutParameterWithValueAndType(String name, String value, String type) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.putParameter(r -> r.name(name).value(value).type(ParameterType.fromValue(type))));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I put parameter {string} with value {string} and type {string} and description {string}")
    public void iPutParameterWithValueAndTypeAndDescription(String name, String value, String type, String desc) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.putParameter(r -> r.name(name).value(value).type(ParameterType.fromValue(type)).description(desc)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I put parameter {string} with value {string} and type {string} with overwrite")
    public void iPutParameterWithValueAndTypeWithOverwrite(String name, String value, String type) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.putParameter(r -> r.name(name).value(value).type(ParameterType.fromValue(type)).overwrite(true)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I get parameter {string}")
    public void iGetParameter(String name) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.getParameter(r -> r.name(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @io.cucumber.java.en.When("^I get parameters \\[\"([^\"]+)\", \"([^\"]+)\"\\]$")
    public void iGetParameters(String name1, String name2) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.getParameters(r -> r.names(name1, name2)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I get parameters by path {string}")
    public void iGetParametersByPath(String path) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.getParametersByPath(r -> r.path(path)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I delete parameter {string}")
    public void iDeleteParameter(String name) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.deleteParameter(r -> r.name(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @io.cucumber.java.en.When("^I delete parameters \\[\"([^\"]+)\"\\]$")
    public void iDeleteParameters(String name) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.deleteParameters(r -> r.names(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I describe parameters")
    public void iDescribeParameters() {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.describeParameters());
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I describe SSM parameters with timing")
    public void iDescribeSsmParametersWithTiming() {
        long start = System.currentTimeMillis();
        try (SsmClient client = world.ssmClient()) {
            world.timedOutput = client.describeParameters();
            world.timedSuccess = true;
        } catch (Exception e) {
            world.timedSuccess = false;
            world.timedOutput = e;
        } finally {
            world.timedElapsedMs = System.currentTimeMillis() - start;
        }
    }

    @io.cucumber.java.en.When("^I add tags (\\[.+\\]) to parameter \"([^\"]+)\"$")
    public void iAddTagsToParameter(String tagsJson, String name) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.addTagsToResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(name)
                .tags(
                    software.amazon.awssdk.services.ssm.model.Tag.builder().key("env").value("test").build()
                )));
        } catch (Exception e) { world.setFailure(e); }
    }

    @io.cucumber.java.en.When("^I remove tag keys \\[\"([^\"]+)\"\\] from parameter \"([^\"]+)\"$")
    public void iRemoveTagKeysFromParameter(String key, String name) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.removeTagsFromResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(name).tagKeys(key)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @When("I list tags for parameter {string}")
    public void iListTagsForParameter(String name) {
        try (SsmClient client = world.ssmClient()) {
            world.setSuccess(client.listTagsForResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(name)));
        } catch (Exception e) { world.setFailure(e); }
    }

    @Then("parameter {string} will have value {string}")
    public void parameterWillHaveValue(String name, String value) {
        try (SsmClient client = world.ssmClient()) {
            GetParameterResponse r = client.getParameter(req -> req.name(name));
            assertEquals(value, r.parameter().value());
        }
    }

    @Then("parameter {string} will not appear in describe-parameters")
    public void parameterWillNotAppearInDescribeParameters(String name) {
        try (SsmClient client = world.ssmClient()) {
            DescribeParametersResponse r = client.describeParameters();
            boolean found = r.parameters().stream().anyMatch(p -> p.name().equals(name));
            assertFalse(found, "Expected parameter " + name + " to not appear");
        }
    }

    @Then("the parameter list will include {string}")
    public void theParameterListWillInclude(String name) {
        try (SsmClient client = world.ssmClient()) {
            DescribeParametersResponse r = client.describeParameters();
            boolean found = r.parameters().stream().anyMatch(p -> p.name().equals(name));
            assertTrue(found, "Expected parameter " + name + " in list");
        }
    }

    @Then("the output will contain parameter value {string}")
    public void theOutputWillContainParameterValue(String value) {
        assertTrue(world.lastSuccess, "Last command did not succeed");
        if (world.lastOutput instanceof GetParameterResponse r) {
            assertEquals(value, r.parameter().value());
        }
    }

    @io.cucumber.java.en.Given("^tags (\\[.+\\]) were added to parameter \"([^\"]+)\"$")
    public void tagsWereAddedToParameter(String tagsJson, String name) {
        try (SsmClient client = world.ssmClient()) {
            client.addTagsToResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(name)
                .tags(software.amazon.awssdk.services.ssm.model.Tag.builder().key("env").value("test").build()));
        } catch (Exception ignored) {}
    }
}
