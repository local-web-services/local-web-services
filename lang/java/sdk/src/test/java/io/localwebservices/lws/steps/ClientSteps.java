package io.localwebservices.lws.steps;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import software.amazon.awssdk.core.SdkClient;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.ssm.SsmClient;

import static org.junit.jupiter.api.Assertions.*;

public class ClientSteps {

    private final WorldContext world;
    private Object lastClient;
    private String lastService;

    public ClientSteps(WorldContext world) {
        this.world = world;
    }

    @When("I request a client for {string}")
    public void iRequestAClientFor(String service) {
        lastService = service;
        switch (service) {
            case "dynamodb"       -> lastClient = world.session.dynamoDbClient();
            case "sqs"            -> lastClient = world.session.sqsClient();
            case "s3"             -> lastClient = world.session.s3Client();
            case "sns"            -> lastClient = world.session.snsClient();
            case "stepfunctions"  -> lastClient = world.session.sfnClient();
            case "ssm"            -> lastClient = world.session.ssmClient();
            case "secretsmanager" -> lastClient = world.session.secretsManagerClient();
            default -> throw new IllegalArgumentException("Unknown service: " + service);
        }
    }

    @Then("a configured client is returned")
    public void aConfiguredClientIsReturned() {
        assertNotNull(lastClient, "expected a client to be returned");
    }

    @And("the client can successfully call the {word} service")
    public void theClientCanSuccessfullyCallTheService(String service) {
        // Make a simple "list" call on the client to verify connectivity
        try {
            switch (service) {
                case "dynamodb" -> ((DynamoDbClient) lastClient).listTables();
                case "sqs"      -> ((SqsClient) lastClient).listQueues();
                case "s3"       -> ((S3Client) lastClient).listBuckets();
                case "sns"      -> ((SnsClient) lastClient).listTopics();
                case "stepfunctions" -> ((SfnClient) lastClient).listStateMachines();
                case "ssm"      -> ((SsmClient) lastClient).describeParameters();
                case "secretsmanager" -> ((SecretsManagerClient) lastClient).listSecrets();
                default -> fail("Unknown service for connectivity check: " + service);
            }
        } catch (Exception e) {
            fail("Client call failed for " + service + ": " + e.getMessage());
        } finally {
            if (lastClient instanceof AutoCloseable ac) {
                try { ac.close(); } catch (Exception ignored) {}
            }
        }
    }
}
