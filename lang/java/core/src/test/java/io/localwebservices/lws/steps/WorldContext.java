package io.localwebservices.lws.steps;

import io.localwebservices.lws.LwsServer;
import io.localwebservices.lws.cli.LwsCli;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.endpoints.Endpoint;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3Configuration;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.endpoints.SfnEndpointParams;
import software.amazon.awssdk.services.sfn.endpoints.SfnEndpointProvider;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.ssm.SsmClient;

import java.net.URI;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

/** Shared test context (one per step definition class instance, shared via DI). */
public class WorldContext {

    static final int BASE_PORT = 19302;

    private static LwsServer.RunningServer sharedServer;
    private static boolean started = false;

    static synchronized void ensureServerStarted() throws Exception {
        if (!started) {
            sharedServer = LwsServer.start(BASE_PORT);
            started = true;
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                if (sharedServer != null) sharedServer.stop();
            }));
        }
    }

    // Last operation result
    public boolean lastSuccess = false;
    public Object lastOutput = null;
    public Throwable lastError = null;

    // Timed result
    public boolean timedSuccess = false;
    public Object timedOutput = null;
    public long timedElapsedMs = 0;

    // Multi-step state
    public String lastReceiptHandle;
    public String lastQueueUrl;
    public String lastUploadId;
    public String lastBucket;
    public String lastKey;
    public String lastETag;
    public String lastExecutionArn;
    public String lastStateMachineArn;
    public String lastSubscriptionArn;
    public String lastTopicArn;

    public void setSuccess(Object output) {
        lastSuccess = true;
        lastOutput = output;
        lastError = null;
    }

    public void setFailure(Throwable error) {
        lastSuccess = false;
        lastOutput = error;
        lastError = error;
    }

    public int managementPort() { return BASE_PORT; }
    public int dynamodbPort() { return BASE_PORT + 1; }
    public int sqsPort() { return BASE_PORT + 2; }
    public int s3Port() { return BASE_PORT + 3; }
    public int snsPort() { return BASE_PORT + 4; }
    public int eventbridgePort() { return BASE_PORT + 5; }
    public int stepfunctionsPort() { return BASE_PORT + 6; }
    public int cognitoPort() { return BASE_PORT + 7; }
    public int ssmPort() { return BASE_PORT + 12; }
    public int secretsmanagerPort() { return BASE_PORT + 13; }

    private static final StaticCredentialsProvider CREDS = StaticCredentialsProvider.create(
        AwsBasicCredentials.create("test", "test")
    );

    public DynamoDbClient dynamodbClient() {
        return DynamoDbClient.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + dynamodbPort()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public SqsClient sqsClient() {
        return SqsClient.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + sqsPort()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public S3Client s3Client() {
        return S3Client.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + s3Port()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .forcePathStyle(true)
            .serviceConfiguration(S3Configuration.builder()
                .checksumValidationEnabled(false)
                .build())
            .build();
    }

    public SnsClient snsClient() {
        return SnsClient.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + snsPort()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public EventBridgeClient eventbridgeClient() {
        return EventBridgeClient.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + eventbridgePort()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public SfnClient sfnClient() {
        // Use "localhost" (not IP) so that "sync-" prefix creates valid hostname "sync-localhost"
        final String sfnEndpoint = "http://localhost:" + stepfunctionsPort();
        return SfnClient.builder()
            .endpointOverride(URI.create(sfnEndpoint))
            // Custom HTTP client strips "sync-" hostname prefix added by SDK for StartSyncExecution
            .httpClient(new SyncStripHttpClient(UrlConnectionHttpClient.create()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public SsmClient ssmClient() {
        return SsmClient.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + ssmPort()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public SecretsManagerClient secretsManagerClient() {
        return SecretsManagerClient.builder()
            .endpointOverride(URI.create("http://127.0.0.1:" + secretsmanagerPort()))
            .credentialsProvider(CREDS)
            .region(Region.US_EAST_1)
            .build();
    }

    public String sqsQueueUrl(String queueName) {
        return "http://127.0.0.1:" + sqsPort() + "/000000000000/" + queueName;
    }

    public void reset() throws Exception {
        LwsCli.reset(managementPort());
    }
}
