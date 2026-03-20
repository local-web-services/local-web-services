package io.localwebservices.lws;

import io.localwebservices.lws.hcl.HclDiscovery;
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
import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.apigateway.ApiGatewayClient;
import software.amazon.awssdk.services.cognitoidentityprovider.CognitoIdentityProviderClient;
import software.amazon.awssdk.services.docdb.DocDbClient;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.elasticache.ElastiCacheClient;
import software.amazon.awssdk.services.elasticsearch.ElasticsearchClient;
import software.amazon.awssdk.services.glacier.GlacierClient;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.memorydb.MemoryDbClient;
import software.amazon.awssdk.services.neptune.NeptuneClient;
import software.amazon.awssdk.services.opensearch.OpenSearchClient;
import software.amazon.awssdk.services.organizations.OrganizationsClient;
import software.amazon.awssdk.services.rds.RdsClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3tables.S3TablesClient;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.ssm.SsmClient;

/**
 * A local AWS session that spawns {@code ldk dev} as a subprocess and provides pre-configured AWS
 * SDK v2 clients pointing at the local emulators.
 *
 * <p>Use with try-with-resources to ensure the subprocess is stopped after the test:
 *
 * <pre>{@code
 * try (LwsSession session = LwsSession.fromHcl("terraform")) {
 *     SfnClient sfn = session.sfnClient();
 *     // run your tests
 * }
 * }</pre>
 */
public class LwsSession implements AutoCloseable {

  static final Map<String, Integer> SERVICE_OFFSETS = ResourceProvisioner.SERVICE_OFFSETS;

  private final int basePort;
  private final Process process;
  private LwsServer.RunningServer runningServer;
  private LogCapture bgLogs;
  private SessionSpec provisionedSpec;

  LwsSession(int basePort, Process process) {
    this.basePort = basePort;
    this.process = process;
  }

  LwsSession(int basePort, LwsServer.RunningServer runningServer) {
    this.basePort = basePort;
    this.process = null;
    this.runningServer = runningServer;
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

    Process proc =
        new ProcessBuilder(
                "ldk",
                "dev",
                "--project-dir",
                tempDir.toString(),
                "--port",
                String.valueOf(basePort))
            .redirectOutput(ProcessBuilder.Redirect.DISCARD)
            .redirectError(ProcessBuilder.Redirect.DISCARD)
            .start();

    LwsSession session = new LwsSession(basePort, proc);
    session.awaitReady();
    session.provisionedSpec = spec;
    session.preCreateResources(spec);
    try {
      session.bgLogs = LogCapture.start(session);
    } catch (Exception ignored) {
      // log capture is optional; proceed without it if unavailable
    }
    return session;
  }

  /**
   * Creates a session backed by an in-process LWS server (no external binary required). The server
   * is started using {@code io.localwebservices.lws.LwsServer.start(basePort)}.
   *
   * @param spec resource declarations
   * @return a ready session
   */
  public static LwsSession createInProcess(SessionSpec spec) throws Exception {
    int basePort = findFreePort();
    LwsServer.RunningServer runningServer = LwsServer.start(basePort);
    LwsSession session = new LwsSession(basePort, runningServer);
    session.provisionedSpec = spec;
    session.preCreateResources(spec);
    session.bgLogs = LogCapture.startHttp(session);
    return session;
  }

  /** Returns the base port for this session (used internally by {@link FakeBuilder}). */
  int getBasePort() {
    return basePort;
  }

  /**
   * Returns a {@link FakeBuilder} for the given service (e.g. {@code "stepfunctions"}). Use it to
   * configure fake responses or inject errors for specific operations.
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

  /** Returns a pre-configured Organizations client pointing at the local emulator. */
  public OrganizationsClient organizationsClient() {
    return OrganizationsClient.builder()
        .endpointOverride(endpointFor("organizations"))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  /** Returns a pre-configured Cognito Identity Provider client pointing at the local emulator. */
  public CognitoIdentityProviderClient cognitoIdpClient() {
    return CognitoIdentityProviderClient.builder()
        .endpointOverride(endpointFor("cognito-idp"))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  /** Returns a pre-configured API Gateway client pointing at the local emulator. */
  public ApiGatewayClient apiGatewayClient() {
    return ApiGatewayClient.builder()
        .endpointOverride(endpointFor("apigateway"))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  /** Returns a pre-configured Lambda client pointing at the local emulator. */
  public LambdaClient lambdaClient() {
    return LambdaClient.builder()
        .endpointOverride(endpointFor("lambda"))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  /** Returns a pre-configured RDS client pointing at the local emulator. */
  public RdsClient rdsClient() {
    return AwsClientFactory.rdsClient(this);
  }

  /** Returns a pre-configured DocDB client pointing at the local emulator. */
  public DocDbClient docDbClient() {
    return AwsClientFactory.docDbClient(this);
  }

  /** Returns a pre-configured Neptune client pointing at the local emulator. */
  public NeptuneClient neptuneClient() {
    return AwsClientFactory.neptuneClient(this);
  }

  /** Returns a pre-configured ElastiCache client pointing at the local emulator. */
  public ElastiCacheClient elastiCacheClient() {
    return AwsClientFactory.elastiCacheClient(this);
  }

  /** Returns a pre-configured MemoryDB client pointing at the local emulator. */
  public MemoryDbClient memoryDbClient() {
    return AwsClientFactory.memoryDbClient(this);
  }

  /** Returns a pre-configured Glacier client pointing at the local emulator. */
  public GlacierClient glacierClient() {
    return AwsClientFactory.glacierClient(this);
  }

  /** Returns a pre-configured Elasticsearch client pointing at the local emulator. */
  public ElasticsearchClient elasticsearchClient() {
    return AwsClientFactory.elasticsearchClient(this);
  }

  /** Returns a pre-configured OpenSearch client pointing at the local emulator. */
  public OpenSearchClient openSearchClient() {
    return AwsClientFactory.openSearchClient(this);
  }

  /** Returns a pre-configured S3Tables client pointing at the local emulator. */
  public S3TablesClient s3TablesClient() {
    return S3TablesClient.builder()
        .endpointOverride(endpointFor("s3tables"))
        .region(Region.US_EAST_1)
        .credentialsProvider(testCredentials())
        .build();
  }

  /** Returns a pre-configured AWS SDK client of the given type pointing at the local emulator. */
  @SuppressWarnings("unchecked")
  public <T> T client(Class<T> clientClass) {
    if (clientClass == DynamoDbClient.class) return clientClass.cast(dynamoDbClient());
    if (clientClass == SqsClient.class) return clientClass.cast(sqsClient());
    if (clientClass == SfnClient.class) return clientClass.cast(sfnClient());
    if (clientClass == S3Client.class) return clientClass.cast(s3Client());
    if (clientClass == SnsClient.class) return clientClass.cast(snsClient());
    if (clientClass == SsmClient.class) return clientClass.cast(ssmClient());
    if (clientClass == SecretsManagerClient.class) return clientClass.cast(secretsManagerClient());
    if (clientClass == CognitoIdentityProviderClient.class)
      return clientClass.cast(cognitoIdpClient());
    if (clientClass == ApiGatewayClient.class) return clientClass.cast(apiGatewayClient());
    if (clientClass == LambdaClient.class) return clientClass.cast(lambdaClient());
    if (clientClass == RdsClient.class) return clientClass.cast(rdsClient());
    if (clientClass == DocDbClient.class) return clientClass.cast(docDbClient());
    if (clientClass == NeptuneClient.class) return clientClass.cast(neptuneClient());
    if (clientClass == ElastiCacheClient.class) return clientClass.cast(elastiCacheClient());
    if (clientClass == MemoryDbClient.class) return clientClass.cast(memoryDbClient());
    if (clientClass == GlacierClient.class) return clientClass.cast(glacierClient());
    if (clientClass == ElasticsearchClient.class) return clientClass.cast(elasticsearchClient());
    if (clientClass == OpenSearchClient.class) return clientClass.cast(openSearchClient());
    if (clientClass == S3TablesClient.class) return clientClass.cast(s3TablesClient());
    throw new IllegalArgumentException("Unsupported client type: " + clientClass.getName());
  }

  /** Resets all provider state via the management API. */
  public void reset() throws Exception {
    URI uri = URI.create("http://127.0.0.1:" + basePort + "/_ldk/reset");
    HttpRequest request =
        HttpRequest.newBuilder(uri)
            .POST(HttpRequest.BodyPublishers.noBody())
            .timeout(Duration.ofSeconds(10))
            .build();
    HttpClient.newBuilder()
        .version(HttpClient.Version.HTTP_1_1)
        .build()
        .send(request, HttpResponse.BodyHandlers.discarding());
    if (provisionedSpec != null) {
      preCreateResources(provisionedSpec);
    }
  }

  /** Returns a {@link ChaosBuilder} for the given service (e.g. {@code "stepfunctions"}). */
  public ChaosBuilder chaos(String service) {
    return new ChaosBuilder(this, service);
  }

  /** Returns a {@link CapacityBuilder} for the given service (e.g. {@code "stepfunctions"}). */
  public CapacityBuilder capacity(String service) {
    return new CapacityBuilder(this, service);
  }

  /**
   * Connects to the log stream and begins recording entries. Uses WebSocket if available; falls
   * back to HTTP polling for in-process sessions.
   */
  public LogCapture startLogCapture() throws Exception {
    if (runningServer != null) {
      // In-process mode: use HTTP polling since WebSocket is not available
      return LogCapture.startHttp(this);
    }
    return LogCapture.start(this);
  }

  /**
   * Creates a session by discovering resources from a synthesised CDK cloud assembly at {@code
   * projectDir/cdk.out}.
   *
   * @param projectDir path to the CDK project root
   * @return a ready session
   */
  public static LwsSession fromCdk(String projectDir) throws Exception {
    java.nio.file.Path resolved = java.nio.file.Path.of(projectDir).toAbsolutePath();
    SessionSpec spec = CdkDiscovery.discover(resolved);
    return create(spec);
  }

  /** Returns an {@link IamBuilder} for configuring IAM authentication mode. */
  public IamBuilder iam() {
    return new IamBuilder(this);
  }

  /**
   * Returns a {@link LifecycleBuilder} for configuring lifecycle simulation of the given service.
   */
  public LifecycleBuilder lifecycle(String service) {
    return new LifecycleBuilder(this, service);
  }

  /** Returns a {@link DynamoDbHelper} bound to the given table name. */
  public DynamoDbHelper dynamoDb(String tableName) {
    return new DynamoDbHelper(tableName, dynamoDbClient());
  }

  /** Returns an {@link SqsHelper} bound to the given queue name. */
  public SqsHelper sqs(String queueName) {
    return new SqsHelper(queueName, queueUrl(queueName), sqsClient());
  }

  /** Returns an {@link S3Helper} bound to the given bucket name. */
  public S3Helper s3(String bucketName) {
    return new S3Helper(bucketName, s3Client());
  }

  /**
   * Returns a snapshot of all log entries recorded since session start. Returns an empty list if
   * the background log capture is not running.
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
    if (runningServer != null) {
      runningServer.stop();
      runningServer = null;
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
    ResourceProvisioner.awaitReady(process, basePort);
  }

  private void preCreateResources(SessionSpec spec) {
    ResourceProvisioner.provision(this, spec);
  }

  static int findFreePort() throws IOException {
    int maxOffset = SERVICE_OFFSETS.values().stream().mapToInt(Integer::intValue).max().orElse(20);
    for (int attempt = 0; attempt < 100; attempt++) {
      List<ServerSocket> held = new ArrayList<>();
      try {
        held.add(new ServerSocket(0));
        int base = held.get(0).getLocalPort();
        for (int offset = 1; offset <= maxOffset; offset++) {
          try {
            held.add(new ServerSocket(base + offset));
          } catch (IOException e) {
            break;
          }
        }
        if (held.size() == maxOffset + 1) return base;
      } finally {
        for (ServerSocket s : held) s.close();
      }
    }
    throw new IOException("Could not find a free contiguous port range after 100 attempts");
  }
}
