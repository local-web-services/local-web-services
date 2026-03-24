package tests

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"testing"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	ddbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

func TestCapacityGetReturnsEmptyByDefault(t *testing.T) {
	// Arrange
	expectedStatusCode := 200

	// Act
	resp, err := http.Get(fmt.Sprintf("http://127.0.0.1:%d/_ldk/capacity", basePort))

	// Assert
	if err != nil {
		t.Fatalf("GET /_ldk/capacity failed: %v", err)
	}
	defer resp.Body.Close()
	actualStatusCode := resp.StatusCode
	if actualStatusCode != expectedStatusCode {
		t.Errorf("expected status %d, got %d", expectedStatusCode, actualStatusCode)
	}

	var actualBody map[string]interface{}
	if err := json.NewDecoder(resp.Body).Decode(&actualBody); err != nil {
		t.Fatalf("failed to decode response body: %v", err)
	}
	// By default, no capacity rules are set
	if len(actualBody) != 0 {
		t.Errorf("expected empty capacity status by default, got %v", actualBody)
	}
}

func TestCapacityPostSetsSlots(t *testing.T) {
	// Arrange
	lws.Reset(basePort) //nolint:errcheck
	expectedStatusCode := 200
	expectedSlotsValue := float64(0)

	payload := map[string]interface{}{
		"stepfunctions": map[string]interface{}{"slots": 0},
	}
	body, _ := json.Marshal(payload)

	// Act
	resp, err := http.Post(
		fmt.Sprintf("http://127.0.0.1:%d/_ldk/capacity", basePort),
		"application/json",
		bytes.NewReader(body),
	)

	// Assert
	if err != nil {
		t.Fatalf("POST /_ldk/capacity failed: %v", err)
	}
	defer resp.Body.Close()
	actualStatusCode := resp.StatusCode
	if actualStatusCode != expectedStatusCode {
		t.Errorf("expected status %d, got %d", expectedStatusCode, actualStatusCode)
	}

	// Verify via GET
	getResp, err := http.Get(fmt.Sprintf("http://127.0.0.1:%d/_ldk/capacity", basePort))
	if err != nil {
		t.Fatalf("GET /_ldk/capacity failed: %v", err)
	}
	defer getResp.Body.Close()
	data, _ := io.ReadAll(getResp.Body)
	var actualCapacity map[string]map[string]interface{}
	json.Unmarshal(data, &actualCapacity) //nolint:errcheck

	sfnRule, ok := actualCapacity["stepfunctions"]
	if !ok {
		t.Fatalf("expected stepfunctions key in capacity status, got %v", actualCapacity)
	}
	actualSlots, ok := sfnRule["slots"].(float64)
	if !ok {
		t.Fatalf("expected slots to be numeric, got %T: %v", sfnRule["slots"], sfnRule["slots"])
	}
	if actualSlots != expectedSlotsValue {
		t.Errorf("expected slots %v, got %v", expectedSlotsValue, actualSlots)
	}

	// Cleanup
	lws.Reset(basePort) //nolint:errcheck
}

func TestStartExecutionFailsWhenCapacityExhausted(t *testing.T) {
	// Arrange
	lws.Reset(basePort) //nolint:errcheck

	// Create a state machine
	world := newWorld()
	if err := sfnCreateStandardSM(world); err != nil {
		t.Fatalf("setup: create state machine: %v", err)
	}

	// Exhaust capacity
	if err := lws.CapacityExhaust(basePort, "stepfunctions"); err != nil {
		t.Fatalf("setup: exhaust capacity: %v", err)
	}

	sfnClient := world.SFNClient()

	// Act
	_, actualErr := sfnClient.StartExecution(context.Background(), &sfn.StartExecutionInput{
		StateMachineArn: aws.String(world.lastStateMachineArn),
		Input:           aws.String(`{}`),
	})

	// Assert
	if actualErr == nil {
		t.Fatal("expected StartExecution to fail when capacity is exhausted, but it succeeded")
	}

	// Cleanup
	lws.Reset(basePort) //nolint:errcheck
}

func TestPutItemFailsWhenCapacityExhausted(t *testing.T) {
	// Arrange
	lws.Reset(basePort) //nolint:errcheck

	world := newWorld()
	if err := ddbCreateTable(world); err != nil {
		t.Fatalf("setup: create table: %v", err)
	}

	if err := lws.CapacityExhaust(basePort, "dynamodb"); err != nil {
		t.Fatalf("setup: exhaust capacity: %v", err)
	}

	ddbClient := world.DynamoDBClient()

	// Act
	_, actualErr := ddbClient.PutItem(context.Background(), &dynamodb.PutItemInput{
		TableName: aws.String(testDDBTable),
		Item: map[string]ddbtypes.AttributeValue{
			testDDBKey: &ddbtypes.AttributeValueMemberS{Value: "test-id"},
		},
	})

	// Assert
	if actualErr == nil {
		t.Fatal("expected PutItem to fail when capacity is exhausted, but it succeeded")
	}

	// Cleanup
	lws.Reset(basePort) //nolint:errcheck
}

func TestCapacityResetOnReset(t *testing.T) {
	// Arrange: set a capacity rule, then reset, verify it's cleared
	payload := map[string]interface{}{
		"dynamodb": map[string]interface{}{"slots": 0},
	}
	body, _ := json.Marshal(payload)
	resp, err := http.Post(
		fmt.Sprintf("http://127.0.0.1:%d/_ldk/capacity", basePort),
		"application/json",
		bytes.NewReader(body),
	)
	if err != nil {
		t.Fatalf("POST /_ldk/capacity failed: %v", err)
	}
	resp.Body.Close()

	// Act: reset
	if err := lws.Reset(basePort); err != nil {
		t.Fatalf("Reset failed: %v", err)
	}

	// Assert: capacity should be empty again
	getResp, err := http.Get(fmt.Sprintf("http://127.0.0.1:%d/_ldk/capacity", basePort))
	if err != nil {
		t.Fatalf("GET /_ldk/capacity failed: %v", err)
	}
	defer getResp.Body.Close()
	var actualBody map[string]interface{}
	json.NewDecoder(getResp.Body).Decode(&actualBody) //nolint:errcheck
	if len(actualBody) != 0 {
		t.Errorf("expected capacity to be cleared after reset, got %v", actualBody)
	}
}
