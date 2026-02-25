package io.localwebservices.lws;

import io.localwebservices.lws.hcl.HclDiscovery;
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.StateMachineType;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.ssm.SsmClient;

import software.amazon.awssdk.services.dynamodb.model.AttributeDefinition;
import software.amazon.awssdk.services.dynamodb.model.BillingMode;
import software.amazon.awssdk.services.dynamodb.model.KeySchemaElement;
import software.amazon.awssdk.services.dynamodb.model.KeyType;
import software.amazon.awssdk.services.dynamodb.model.ScalarAttributeType;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.secretsmanager.model.CreateSecretRequest;
import software.amazon.awssdk.services.sns.model.CreateTopicRequest;
import software.amazon.awssdk.services.sqs.model.CreateQueueRequest;
import software.amazon.awssdk.services.ssm.model.ParameterType;
import software.amazon.awssdk.services.ssm.model.PutParameterRequest;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * A local AWS session that spawns {@code ldk dev} as a subprocess and provides
 * pre-configured AWS SDK v2 clients pointing at the local emulators.
 *
 * <p>Use with try-with-resources to ensure the subprocess is stopped after the test:
 * <pre>{@code
 * try (LwsSession session = LwsSession.fromHcl("terraform")) {
 *     SfnClient sfn = session.sfnClient();
 *     // run your tests
 * }
 * }</pre>
 */
public class LwsSession implements AutoCloseable {

    static final Map<String, Integer> SERVICE_OFFSETS = Map.of(
            "dynamodb", 1,
            "sqs", 2,
            "s3", 3,
            "sns", 4,
            "stepfunctions", 6,
            "ssm", 12,
            "secretsmanager", 13
    );

    private final int basePort;
    private final Process process;
    private LogCapture bgLogs;

    LwsSession(int basePort, Process process) {
        this.basePort = basePort;
        this.process = process;
    }

    /**
     * Creates a session by discovering resources from Terraform HCL files in the given directory.
     *
     * @param projectDir path to the directory containing {@code .tf} files
     * @return a ready session
     */
    public static LwsSession fromHcl(String projectDir) throws Exception {
        Path resolved = Path.of(projectDir).toAbsolutePath();
        SessionSpec spec = HclDiscovery.discover(resolved.toString());
        return create(spec);
    }

    /**
     * Creates a session with explicitly declared resources.
     *
     * @param spec resource declarations
     * @return a ready session
     */
    public static LwsSession create(SessionSpec spec) throws Exception {
        Path tempDir = Files.createTempDirectory("lws-testing-");
        Files.writeString(tempDir.resolve("ldk.yaml"), "services:\n");
        // ldk requires at least one .tf file to detect the project as Terraform mode
        Files.writeString(tempDir.resolve("main.tf"), "# local-web-services testing session\n");
        int basePort = findFreePort();

        Process proc = new ProcessBuilder("ldk", "dev",
                "--project-dir", tempDir.toString(),
                "--port", String.valueOf(basePort))
                .redirectOutput(ProcessBuilder.Redirect.DISCARD)
                .redirectError(ProcessBuilder.Redirect.DISCARD)
                .start();

        LwsSession session = new LwsSession(basePort, proc);
        session.awaitReady();
        session.preCreateResources(spec);
        try {
            session.bgLogs = LogCapture.start(session);
        } catch (Exception ignored) {
        }
        return session;
    }

    /** Returns the base port for this session (used internally by {@link FakeBuilder}). */
    int getBasePort() {
        return basePort;
    }

    /**
     * Returns a {@link FakeBuilder} for the given service (e.g. {@code "stepfunctions"}).
     * Use it to configure fake responses or inject errors for specific operations.
     */
    public FakeBuilder fake(String service) {
        return new FakeBuilder(this, service);
    }

    /** Returns the port number for a named service. */
    public int portFor(String service) {
        Integer offset = SERVICE_OFFSETS.get(service);
        if (offset == null) {
            throw new IllegalArgumentException("Unknown service: " + service);
        }
        return basePort + offset;
    }

    /** Returns the local SQS queue URL for the given queue name. */
    public String queueUrl(String queueName) {
        return String.format("http://127.0.0.1:%d/000000000000/%s", portFor("sqs"), queueName);
    }

    /** Returns a pre-configured DynamoDB client pointing at the local emulator. */
    public DynamoDbClient dynamoDbClient() {
        return DynamoDbClient.builder()
                .endpointOverride(endpointFor("dynamodb"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .build();
    }

    /** Returns a pre-configured SQS client pointing at the local emulator. */
    public SqsClient sqsClient() {
        return SqsClient.builder()
                .endpointOverride(endpointFor("sqs"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .build();
    }

    /** Returns a pre-configured Step Functions client pointing at the local emulator. */
    public SfnClient sfnClient() {
        return SfnClient.builder()
                .endpointOverride(endpointFor("stepfunctions"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .build();
    }

    /** Returns a pre-configured S3 client pointing at the local emulator. */
    public S3Client s3Client() {
        return S3Client.builder()
                .endpointOverride(endpointFor("s3"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .forcePathStyle(true)
                .build();
    }

    /** Returns a pre-configured SNS client pointing at the local emulator. */
    public SnsClient snsClient() {
        return SnsClient.builder()
                .endpointOverride(endpointFor("sns"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .build();
    }

    /** Returns a pre-configured SSM client pointing at the local emulator. */
    public SsmClient ssmClient() {
        return SsmClient.builder()
                .endpointOverride(endpointFor("ssm"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .build();
    }

    /** Returns a pre-configured Secrets Manager client pointing at the local emulator. */
    public SecretsManagerClient secretsManagerClient() {
        return SecretsManagerClient.builder()
                .endpointOverride(endpointFor("secretsmanager"))
                .region(Region.US_EAST_1)
                .credentialsProvider(testCredentials())
                .build();
    }

    /**
     * Resets all provider state via the management API.
     */
    public void reset() throws Exception {
        URI uri = URI.create("http://127.0.0.1:" + basePort + "/_ldk/reset");
        HttpRequest request = HttpRequest.newBuilder(uri)
                .POST(HttpRequest.BodyPublishers.noBody())
                .timeout(Duration.ofSeconds(10))
                .build();
        HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_1_1)
                .build()
                .send(request, HttpResponse.BodyHandlers.discarding());
    }

    /**
     * Returns a {@link ChaosBuilder} for the given service (e.g. {@code "stepfunctions"}).
     */
    public ChaosBuilder chaos(String service) {
        return new ChaosBuilder(this, service);
    }

    /**
     * Connects to the WebSocket log stream and begins recording entries.
     */
    public LogCapture startLogCapture() throws Exception {
        return LogCapture.start(this);
    }

    /**
     * Creates a session by discovering resources from a synthesised CDK cloud assembly at
     * {@code projectDir/cdk.out}.
     *
     * @param projectDir path to the CDK project root
     * @return a ready session
     */
    public static LwsSession fromCdk(String projectDir) throws Exception {
        java.nio.file.Path resolved = java.nio.file.Path.of(projectDir).toAbsolutePath();
        SessionSpec spec = CdkDiscovery.discover(resolved);
        return create(spec);
    }

    /**
     * Returns an {@link IamBuilder} for configuring IAM authentication mode.
     */
    public IamBuilder iam() {
        return new IamBuilder(this);
    }

    /**
     * Returns a {@link DynamoDbHelper} bound to the given table name.
     */
    public DynamoDbHelper dynamoDb(String tableName) {
        return new DynamoDbHelper(tableName, dynamoDbClient());
    }

    /**
     * Returns an {@link SqsHelper} bound to the given queue name.
     */
    public SqsHelper sqs(String queueName) {
        return new SqsHelper(queueName, queueUrl(queueName), sqsClient());
    }

    /**
     * Returns an {@link S3Helper} bound to the given bucket name.
     */
    public S3Helper s3(String bucketName) {
        return new S3Helper(bucketName, s3Client());
    }

    /**
     * Returns a snapshot of all log entries recorded since session start.
     * Returns an empty list if the background log capture is not running.
     */
    public List<LogCapture.LogEntry> recentLogs() {
        if (bgLogs == null) return new ArrayList<>();
        return bgLogs.getEntries();
    }

    @Override
    public void close() {
        if (bgLogs != null) {
            bgLogs.stop();
            bgLogs = null;
        }
        if (process != null && process.isAlive()) {
            process.destroy();
            try {
                process.waitFor(10, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    private URI endpointFor(String service) {
        return URI.create("http://127.0.0.1:" + portFor(service));
    }

    private static StaticCredentialsProvider testCredentials() {
        return StaticCredentialsProvider.create(AwsBasicCredentials.create("test", "test"));
    }

    private void awaitReady() throws Exception {
        final int maxRetries = 3;
        HttpClient httpClient = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(2))
                .build();
        URI statusUri = URI.create("http://127.0.0.1:" + basePort + "/_ldk/status");
        Exception lastError = null;
        for (int retry = 0; retry <= maxRetries; retry++) {
            for (int attempt = 0; attempt < 60; attempt++) {
                if (!process.isAlive()) {
                    throw new RuntimeException("ldk dev process exited unexpectedly");
                }
                try {
                    HttpRequest request = HttpRequest.newBuilder(statusUri)
                            .GET()
                            .timeout(Duration.ofSeconds(2))
                            .build();
                    HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
                    if (response.statusCode() < 400 && response.body().contains("\"running\":true")) {
                        return;
                    }
                    lastError = new RuntimeException("status endpoint returned HTTP " + response.statusCode());
                } catch (Exception e) {
                    lastError = e;
                }
                Thread.sleep(500);
            }
            if (retry < maxRetries) {
                System.out.printf("[lws] ldk dev not ready after 30 s, retrying in 15 s... (%d/%d)%n", retry + 1, maxRetries);
                Thread.sleep(15_000);
            }
        }
        String reason = lastError != null ? ": " + lastError.getMessage() : "";
        throw new RuntimeException("ldk dev did not become ready after " + maxRetries + " retries" + reason);
    }

    private void preCreateResources(SessionSpec spec) {
        if (!spec.getTables().isEmpty()) {
            try (var ddb = dynamoDbClient()) {
                for (TableSpec t : spec.getTables()) {
                    List<KeySchemaElement> keySchema = new ArrayList<>();
                    List<AttributeDefinition> attrDefs = new ArrayList<>();
                    keySchema.add(KeySchemaElement.builder()
                            .attributeName(t.getPartitionKey()).keyType(KeyType.HASH).build());
                    attrDefs.add(AttributeDefinition.builder()
                            .attributeName(t.getPartitionKey()).attributeType(ScalarAttributeType.S).build());
                    if (t.getSortKey() != null) {
                        keySchema.add(KeySchemaElement.builder()
                                .attributeName(t.getSortKey()).keyType(KeyType.RANGE).build());
                        attrDefs.add(AttributeDefinition.builder()
                                .attributeName(t.getSortKey()).attributeType(ScalarAttributeType.S).build());
                    }
                    ddb.createTable(r -> r
                            .tableName(t.getName())
                            .keySchema(keySchema)
                            .attributeDefinitions(attrDefs)
                            .billingMode(BillingMode.PAY_PER_REQUEST));
                }
            }
        }

        if (!spec.getQueues().isEmpty()) {
            try (var sqsc = sqsClient()) {
                for (String q : spec.getQueues()) {
                    sqsc.createQueue(CreateQueueRequest.builder().queueName(q).build());
                }
            }
        }

        if (!spec.getBuckets().isEmpty()) {
            try (var s3c = s3Client()) {
                for (String b : spec.getBuckets()) {
                    s3c.createBucket(CreateBucketRequest.builder().bucket(b).build());
                }
            }
        }

        if (!spec.getTopics().isEmpty()) {
            try (var snsc = snsClient()) {
                for (String t : spec.getTopics()) {
                    snsc.createTopic(CreateTopicRequest.builder().name(t).build());
                }
            }
        }

        if (!spec.getStateMachines().isEmpty()) {
            try (SfnClient sfn = sfnClient()) {
                for (StateMachineSpec sm : spec.getStateMachines()) {
                    String roleArn = sm.getRoleArn() != null
                            ? sm.getRoleArn()
                            : "arn:aws:iam::000000000000:role/StepFunctionsRole";
                    sfn.createStateMachine(r -> r
                            .name(sm.getName())
                            .definition(sm.getDefinition())
                            .roleArn(roleArn)
                            .type(StateMachineType.STANDARD));
                }
            }
        }

        if (!spec.getParameters().isEmpty()) {
            try (var ssmc = ssmClient()) {
                for (String p : spec.getParameters()) {
                    ssmc.putParameter(PutParameterRequest.builder()
                            .name(p).value("").type(ParameterType.STRING).overwrite(true).build());
                }
            }
        }

        if (!spec.getSecrets().isEmpty()) {
            try (var smc = secretsManagerClient()) {
                for (String sec : spec.getSecrets()) {
                    smc.createSecret(CreateSecretRequest.builder()
                            .name(sec).secretString("").build());
                }
            }
        }
    }

    static int findFreePort() throws IOException {
        try (ServerSocket socket = new ServerSocket(0)) {
            socket.setReuseAddress(true);
            return socket.getLocalPort();
        }
    }
}
