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

func TestMockRuleBuilder_withHeaderAndDelayMs(t *testing.T) {
	// Arrange
	session := &Session{basePort: 10000}
	builder := session.Mock("stepfunctions")

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
