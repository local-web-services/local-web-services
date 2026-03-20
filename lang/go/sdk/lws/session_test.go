package lws

import (
	"os"
	"path/filepath"
	"strings"
	"testing"
)

func TestPortFor_returnsCorrectOffsetForEachKnownService(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedPorts := map[string]int{
		"dynamodb":       10001,
		"sqs":            10002,
		"s3":             10003,
		"sns":            10004,
		"stepfunctions":  10006,
		"ssm":            10012,
		"secretsmanager": 10013,
	}

	// Act & Assert
	for service, expectedPort := range expectedPorts {
		actualPort, err := session.PortFor(service)
		if err != nil {
			t.Errorf("PortFor(%q) returned error: %v", service, err)
		}
		if actualPort != expectedPort {
			t.Errorf("PortFor(%q) = %d, want %d", service, actualPort, expectedPort)
		}
	}
}

func TestPortFor_returnsErrorForUnknownService(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	_, err := session.PortFor("unknown-service")

	// Assert
	if err == nil {
		t.Error("expected error for unknown service, got nil")
	}
}

func TestQueueURL_containsHostPortAndQueueName(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedQueueName := "OrderQueue"

	// Act
	actualURL := session.QueueURL(expectedQueueName)

	// Assert
	if !strings.Contains(actualURL, "127.0.0.1") {
		t.Errorf("QueueURL %q does not contain 127.0.0.1", actualURL)
	}
	if !strings.Contains(actualURL, expectedQueueName) {
		t.Errorf("QueueURL %q does not contain %q", actualURL, expectedQueueName)
	}
	if !strings.Contains(actualURL, "000000000000") {
		t.Errorf("QueueURL %q does not contain account ID", actualURL)
	}
}

func TestPortFor_s3MinusDynamodbEqualsTwoOffsets(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	s3Port, _ := session.PortFor("s3")
	dynamoPort, _ := session.PortFor("dynamodb")

	// Assert
	if s3Port-dynamoPort != 2 {
		t.Errorf("s3Port - dynamoPort = %d, want 2", s3Port-dynamoPort)
	}
}

func TestDiscoverHcl_parsesStateMachineFromHeredoc(t *testing.T) {
	// Arrange
	tempDir := t.TempDir()
	expectedName := "OrderProcessor"
	expectedDefinitionFragment := "Done"
	tfContent := strings.Join([]string{
		`resource "aws_sfn_state_machine" "order_processor" {`,
		`  name     = "` + expectedName + `"`,
		`  role_arn = "arn:aws:iam::000000000000:role/StepFunctionsRole"`,
		`  definition = <<EOF`,
		`{"StartAt":"Done","States":{"Done":{"Type":"Pass","End":true}}}`,
		`EOF`,
		`}`,
	}, "\n")
	if err := os.WriteFile(filepath.Join(tempDir, "main.tf"), []byte(tfContent), 0644); err != nil {
		t.Fatal(err)
	}

	// Act
	spec, err := DiscoverHcl(tempDir)

	// Assert
	if err != nil {
		t.Fatalf("DiscoverHcl returned error: %v", err)
	}
	if len(spec.StateMachines) != 1 {
		t.Fatalf("expected 1 state machine, got %d", len(spec.StateMachines))
	}
	if spec.StateMachines[0].Name != expectedName {
		t.Errorf("Name = %q, want %q", spec.StateMachines[0].Name, expectedName)
	}
	if !strings.Contains(spec.StateMachines[0].Definition, expectedDefinitionFragment) {
		t.Errorf("Definition %q does not contain %q", spec.StateMachines[0].Definition, expectedDefinitionFragment)
	}
}

func TestDiscoverHcl_returnsEmptySpecForDirectoryWithNoTfFiles(t *testing.T) {
	// Arrange
	tempDir := t.TempDir()

	// Act
	spec, err := DiscoverHcl(tempDir)

	// Assert
	if err != nil {
		t.Fatalf("DiscoverHcl returned error: %v", err)
	}
	if len(spec.StateMachines) != 0 {
		t.Errorf("expected 0 state machines, got %d", len(spec.StateMachines))
	}
}

func TestDiscoverHcl_parsesDynamoDBTable(t *testing.T) {
	// Arrange
	tempDir := t.TempDir()
	expectedName := "Orders"
	expectedPartitionKey := "id"
	expectedSortKey := "createdAt"
	tfContent := strings.Join([]string{
		`resource "aws_dynamodb_table" "orders" {`,
		`  name     = "` + expectedName + `"`,
		`  hash_key  = "` + expectedPartitionKey + `"`,
		`  range_key = "` + expectedSortKey + `"`,
		`}`,
	}, "\n")
	if err := os.WriteFile(filepath.Join(tempDir, "main.tf"), []byte(tfContent), 0644); err != nil {
		t.Fatal(err)
	}

	// Act
	spec, err := DiscoverHcl(tempDir)

	// Assert
	if err != nil {
		t.Fatalf("DiscoverHcl returned error: %v", err)
	}
	if len(spec.Tables) != 1 {
		t.Fatalf("expected 1 table, got %d", len(spec.Tables))
	}
	if spec.Tables[0].Name != expectedName {
		t.Errorf("Name = %q, want %q", spec.Tables[0].Name, expectedName)
	}
	if spec.Tables[0].PartitionKey != expectedPartitionKey {
		t.Errorf("PartitionKey = %q, want %q", spec.Tables[0].PartitionKey, expectedPartitionKey)
	}
	if spec.Tables[0].SortKey != expectedSortKey {
		t.Errorf("SortKey = %q, want %q", spec.Tables[0].SortKey, expectedSortKey)
	}
}

func TestDiscoverHcl_parsesAllResourceTypes(t *testing.T) {
	// Arrange
	tempDir := t.TempDir()
	tfContent := strings.Join([]string{
		`resource "aws_sqs_queue" "my_queue" {`,
		`  name = "MyQueue"`,
		`}`,
		`resource "aws_s3_bucket" "my_bucket" {`,
		`  bucket = "my-bucket"`,
		`}`,
		`resource "aws_sns_topic" "my_topic" {`,
		`  name = "MyTopic"`,
		`}`,
		`resource "aws_ssm_parameter" "my_param" {`,
		`  name = "/app/param"`,
		`}`,
		`resource "aws_secretsmanager_secret" "my_secret" {`,
		`  name = "my-secret"`,
		`}`,
	}, "\n")
	if err := os.WriteFile(filepath.Join(tempDir, "main.tf"), []byte(tfContent), 0644); err != nil {
		t.Fatal(err)
	}

	// Act
	spec, err := DiscoverHcl(tempDir)

	// Assert
	if err != nil {
		t.Fatalf("DiscoverHcl returned error: %v", err)
	}
	if len(spec.Queues) != 1 || spec.Queues[0] != "MyQueue" {
		t.Errorf("Queues = %v, want [MyQueue]", spec.Queues)
	}
	if len(spec.Buckets) != 1 || spec.Buckets[0] != "my-bucket" {
		t.Errorf("Buckets = %v, want [my-bucket]", spec.Buckets)
	}
	if len(spec.Topics) != 1 || spec.Topics[0] != "MyTopic" {
		t.Errorf("Topics = %v, want [MyTopic]", spec.Topics)
	}
	if len(spec.Parameters) != 1 || spec.Parameters[0] != "/app/param" {
		t.Errorf("Parameters = %v, want [/app/param]", spec.Parameters)
	}
	if len(spec.Secrets) != 1 || spec.Secrets[0] != "my-secret" {
		t.Errorf("Secrets = %v, want [my-secret]", spec.Secrets)
	}
}

func TestFakeRuleBuilder_withHeaderAndDelayMs(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	builder := session.Fake("stepfunctions")

	// Act
	ruleBuilder := builder.Operation("start-execution").
		WithHeader("X-Test", "value").
		DelayMs(100)

	// Assert
	if ruleBuilder.headers["X-Test"] != "value" {
		t.Errorf("WithHeader: expected X-Test=value, got %v", ruleBuilder.headers)
	}
	if ruleBuilder.delayMs != 100 {
		t.Errorf("DelayMs: expected 100, got %d", ruleBuilder.delayMs)
	}
}

func TestLogCapture_assertMethods_passWhenConditionMet(t *testing.T) {
	// Arrange
	lc := &LogCapture{
		entries: []LogEntry{
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
		},
		done: make(chan struct{}),
	}

	// Act & Assert – AssertCalled should not fail
	lc.AssertCalled(t, "stepfunctions", "start-execution")
}

func TestLogCapture_assertNotCalled_passesWhenNoMatchingEntry(t *testing.T) {
	// Arrange
	lc := &LogCapture{
		entries: []LogEntry{
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
		},
		done: make(chan struct{}),
	}

	// Act & Assert – should not fail; "describe-execution" was never called
	lc.AssertNotCalled(t, "stepfunctions", "describe-execution")
}

func TestLogCapture_assertCallCount_matchesExpected(t *testing.T) {
	// Arrange
	lc := &LogCapture{
		entries: []LogEntry{
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
		},
		done: make(chan struct{}),
	}
	expectedCount := 2

	// Act & Assert
	lc.AssertCallCount(t, "stepfunctions", "start-execution", expectedCount)
}

func TestLogCapture_assertNoErrors_passesWhenAllSuccessful(t *testing.T) {
	// Arrange
	lc := &LogCapture{
		entries: []LogEntry{
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
			{Service: "dynamodb", Operation: "put-item", StatusCode: 200},
		},
		done: make(chan struct{}),
	}

	// Act & Assert – should not fail
	lc.AssertNoErrors(t)
}

func TestLogCapture_forService_filtersToMatchingEntries(t *testing.T) {
	// Arrange
	lc := &LogCapture{
		entries: []LogEntry{
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
			{Service: "dynamodb", Operation: "put-item", StatusCode: 200},
			{Service: "stepfunctions", Operation: "describe-execution", StatusCode: 200},
		},
		done: make(chan struct{}),
	}
	expectedService := "stepfunctions"
	expectedCount := 2

	// Act
	actualEntries := lc.ForService(expectedService)

	// Assert
	if len(actualEntries) != expectedCount {
		t.Errorf("ForService(%q) returned %d entries, want %d", expectedService, len(actualEntries), expectedCount)
	}
	for _, e := range actualEntries {
		if e.Service != expectedService {
			t.Errorf("ForService(%q) returned entry with service %q", expectedService, e.Service)
		}
	}
}

func TestLogCapture_forOperation_filtersToMatchingEntries(t *testing.T) {
	// Arrange
	lc := &LogCapture{
		entries: []LogEntry{
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
			{Service: "dynamodb", Operation: "put-item", StatusCode: 200},
			{Service: "stepfunctions", Operation: "start-execution", StatusCode: 200},
		},
		done: make(chan struct{}),
	}
	expectedOperation := "start-execution"
	expectedCount := 2

	// Act
	actualEntries := lc.ForOperation(expectedOperation)

	// Assert
	if len(actualEntries) != expectedCount {
		t.Errorf("ForOperation(%q) returned %d entries, want %d", expectedOperation, len(actualEntries), expectedCount)
	}
	for _, e := range actualEntries {
		if e.Operation != expectedOperation {
			t.Errorf("ForOperation(%q) returned entry with operation %q", expectedOperation, e.Operation)
		}
	}
}

func TestSession_recentLogs_returnsNilWhenNoBackgroundCapture(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualLogs := session.RecentLogs()

	// Assert
	if actualLogs != nil {
		t.Errorf("RecentLogs() = %v, want nil when no background capture", actualLogs)
	}
}

func TestSession_iam_returnsBuilderWithSessionRef(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	builder := session.Iam().Mode("enforce").DefaultIdentity("test-user")

	// Assert
	if builder.updates["mode"] != "enforce" {
		t.Errorf("IamBuilder mode = %v, want enforce", builder.updates["mode"])
	}
	if builder.updates["default_identity"] != "test-user" {
		t.Errorf("IamBuilder default_identity = %v, want test-user", builder.updates["default_identity"])
	}
}

func TestIamBuilder_identityStoresPolicies(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedActions := []string{"sfn:*"}
	expectedResource := "*"

	// Act
	builder := session.Iam().
		Identity("test-user").
		Allow(expectedActions, expectedResource).
		Apply()

	// Assert
	ib, ok := builder.identities["test-user"]
	if !ok {
		t.Fatal("expected identity 'test-user' to be registered")
	}
	if len(ib.policies) != 1 {
		t.Fatalf("expected 1 policy, got %d", len(ib.policies))
	}
	actualPolicy := ib.policies[0]
	if actualPolicy.Effect != "Allow" {
		t.Errorf("policy Effect = %q, want Allow", actualPolicy.Effect)
	}
	if actualPolicy.Resource != expectedResource {
		t.Errorf("policy Resource = %q, want %q", actualPolicy.Resource, expectedResource)
	}
}

func TestSession_dynamoDB_returnsHelperWithTableName(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedTableName := "Orders"

	// Act
	helper := session.DynamoDB(expectedTableName)

	// Assert
	if helper.tableName != expectedTableName {
		t.Errorf("DynamoDBHelper.tableName = %q, want %q", helper.tableName, expectedTableName)
	}
}

func TestSession_sqs_urlContainsPortAndQueueName(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedQueueName := "OrderQueue"

	// Act
	helper := session.SQS(expectedQueueName)

	// Assert
	if helper.queueName != expectedQueueName {
		t.Errorf("SQSHelper.queueName = %q, want %q", helper.queueName, expectedQueueName)
	}
	if !strings.Contains(helper.URL(), expectedQueueName) {
		t.Errorf("SQSHelper.URL() = %q, does not contain %q", helper.URL(), expectedQueueName)
	}
	if !strings.Contains(helper.URL(), "10002") {
		t.Errorf("SQSHelper.URL() = %q, does not contain expected SQS port 10002", helper.URL())
	}
}

func TestSession_s3_returnsHelperWithBucket(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedBucket := "my-bucket"

	// Act
	helper := session.S3(expectedBucket)

	// Assert
	if helper.bucket != expectedBucket {
		t.Errorf("S3Helper.bucket = %q, want %q", helper.bucket, expectedBucket)
	}
}

func TestDiscoverCdk_parsesAllResourceTypesFromFixture(t *testing.T) {
	// Arrange
	fixtureDir := filepath.Join("testdata", "cdk-fixture")

	// Act
	spec, err := DiscoverCdk(fixtureDir)

	// Assert
	if err != nil {
		t.Fatalf("DiscoverCdk returned error: %v", err)
	}
	if len(spec.Tables) != 1 {
		t.Fatalf("expected 1 table, got %d", len(spec.Tables))
	}
	if spec.Tables[0].Name != "CdkTestTable" {
		t.Errorf("Table Name = %q, want CdkTestTable", spec.Tables[0].Name)
	}
	if spec.Tables[0].PartitionKey != "pk" {
		t.Errorf("Table PartitionKey = %q, want pk", spec.Tables[0].PartitionKey)
	}
	if spec.Tables[0].SortKey != "sk" {
		t.Errorf("Table SortKey = %q, want sk", spec.Tables[0].SortKey)
	}
	if len(spec.Queues) != 1 || spec.Queues[0] != "CdkTestQueue" {
		t.Errorf("Queues = %v, want [CdkTestQueue]", spec.Queues)
	}
	if len(spec.Buckets) != 1 || spec.Buckets[0] != "cdk-test-bucket" {
		t.Errorf("Buckets = %v, want [cdk-test-bucket]", spec.Buckets)
	}
	if len(spec.Topics) != 1 || spec.Topics[0] != "CdkTestTopic" {
		t.Errorf("Topics = %v, want [CdkTestTopic]", spec.Topics)
	}
	if len(spec.StateMachines) != 1 || spec.StateMachines[0].Name != "CdkTestStateMachine" {
		t.Errorf("StateMachines = %v, want [{CdkTestStateMachine ...}]", spec.StateMachines)
	}
	if len(spec.Parameters) != 1 || spec.Parameters[0] != "/cdk/test/param" {
		t.Errorf("Parameters = %v, want [/cdk/test/param]", spec.Parameters)
	}
	if len(spec.Secrets) != 1 || spec.Secrets[0] != "cdk-test-secret" {
		t.Errorf("Secrets = %v, want [cdk-test-secret]", spec.Secrets)
	}
}

func TestDiscoverCdk_skipsResourcesWithIntrinsicNameProperties(t *testing.T) {
	// Arrange — a template where names are CloudFormation intrinsic functions
	tempDir := t.TempDir()
	if err := os.MkdirAll(filepath.Join(tempDir, "cdk.out"), 0755); err != nil {
		t.Fatal(err)
	}
	manifestContent := `{
		"version": "17.0.0",
		"artifacts": {
			"Stack": {
				"type": "aws:cloudformation:stack",
				"properties": {"templateFile": "Stack.template.json"}
			}
		}
	}`
	templateContent := `{
		"Resources": {
			"MyQueue": {
				"Type": "AWS::SQS::Queue",
				"Properties": {
					"QueueName": {"Ref": "AWS::StackName"}
				}
			}
		}
	}`
	if err := os.WriteFile(filepath.Join(tempDir, "cdk.out", "manifest.json"), []byte(manifestContent), 0644); err != nil {
		t.Fatal(err)
	}
	if err := os.WriteFile(filepath.Join(tempDir, "cdk.out", "Stack.template.json"), []byte(templateContent), 0644); err != nil {
		t.Fatal(err)
	}

	// Act
	spec, err := DiscoverCdk(tempDir)

	// Assert
	if err != nil {
		t.Fatalf("DiscoverCdk returned error: %v", err)
	}
	if len(spec.Queues) != 0 {
		t.Errorf("expected 0 queues (intrinsic name skipped), got %v", spec.Queues)
	}
}

func TestChaosBuilder_storesConfig(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	builder := session.Chaos("stepfunctions").
		ErrorRate(0.5).
		Latency(100, 500).
		ConnectionResetRate(0.1).
		TimeoutRate(0.2)

	// Assert
	if builder.cfg.ErrorRate != 0.5 {
		t.Errorf("ErrorRate = %v, want 0.5", builder.cfg.ErrorRate)
	}
	if builder.cfg.LatencyMinMs != 100 {
		t.Errorf("LatencyMinMs = %d, want 100", builder.cfg.LatencyMinMs)
	}
	if builder.cfg.LatencyMaxMs != 500 {
		t.Errorf("LatencyMaxMs = %d, want 500", builder.cfg.LatencyMaxMs)
	}
	if builder.cfg.ConnectionResetRate != 0.1 {
		t.Errorf("ConnectionResetRate = %v, want 0.1", builder.cfg.ConnectionResetRate)
	}
	if builder.cfg.TimeoutRate != 0.2 {
		t.Errorf("TimeoutRate = %v, want 0.2", builder.cfg.TimeoutRate)
	}
}

func TestLifecycleBuilder_storesCreateAndDeleteDwellMs(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedCreateDwellMs := 500
	expectedDeleteDwellMs := 200

	// Act
	builder := session.Lifecycle("dynamodb").
		CreateDwellMs(expectedCreateDwellMs).
		DeleteDwellMs(expectedDeleteDwellMs)

	// Assert
	if builder.config["create_dwell_ms"] != expectedCreateDwellMs {
		t.Errorf("CreateDwellMs: expected %d, got %v", expectedCreateDwellMs, builder.config["create_dwell_ms"])
	}
	if builder.config["delete_dwell_ms"] != expectedDeleteDwellMs {
		t.Errorf("DeleteDwellMs: expected %d, got %v", expectedDeleteDwellMs, builder.config["delete_dwell_ms"])
	}
}

func TestLifecycleBuilder_serviceStoredCorrectly(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	expectedService := "dynamodb"

	// Act
	builder := session.Lifecycle(expectedService)

	// Assert
	if builder.service != expectedService {
		t.Errorf("service = %q, want %q", builder.service, expectedService)
	}
}

func TestSession_cognitoIdentityProviderClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.CognitoIdentityProviderClient()

	// Assert
	if actualClient == nil {
		t.Error("CognitoIdentityProviderClient() returned nil")
	}
}

func TestSession_apiGatewayClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.APIGatewayClient()

	// Assert
	if actualClient == nil {
		t.Error("APIGatewayClient() returned nil")
	}
}

func TestSession_lambdaClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.LambdaClient()

	// Assert
	if actualClient == nil {
		t.Error("LambdaClient() returned nil")
	}
}

func TestSession_rdsClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.RDSClient()

	// Assert
	if actualClient == nil {
		t.Error("RDSClient() returned nil")
	}
}

func TestSession_docDBClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.DocDBClient()

	// Assert
	if actualClient == nil {
		t.Error("DocDBClient() returned nil")
	}
}

func TestSession_neptuneClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.NeptuneClient()

	// Assert
	if actualClient == nil {
		t.Error("NeptuneClient() returned nil")
	}
}

func TestSession_elastiCacheClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.ElastiCacheClient()

	// Assert
	if actualClient == nil {
		t.Error("ElastiCacheClient() returned nil")
	}
}

func TestSession_memoryDBClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.MemoryDBClient()

	// Assert
	if actualClient == nil {
		t.Error("MemoryDBClient() returned nil")
	}
}

func TestSession_glacierClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.GlacierClient()

	// Assert
	if actualClient == nil {
		t.Error("GlacierClient() returned nil")
	}
}

func TestSession_elasticsearchClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.ElasticsearchClient()

	// Assert
	if actualClient == nil {
		t.Error("ElasticsearchClient() returned nil")
	}
}

func TestSession_openSearchClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.OpenSearchClient()

	// Assert
	if actualClient == nil {
		t.Error("OpenSearchClient() returned nil")
	}
}

func TestSession_s3TablesClient_returnsNonNilClient(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}

	// Act
	actualClient := session.S3TablesClient()

	// Assert
	if actualClient == nil {
		t.Error("S3TablesClient() returned nil")
	}
}
