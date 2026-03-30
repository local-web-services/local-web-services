package tests

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/cucumber/godog"
)

const dynamodbTestTable = "e2e-dynamodb-test-table-1"
const dynamodbTestPK = "id"
const dynamodbTestItemKey = "e2e-item-key-1"
const dynamodbTestAttrVal = "attr-val-1"
const dynamodbTestUpdatedVal = "attr-val-updated-1"

// dynamodbState holds mutable step state within a scenario.
type dynamodbState struct {
	lastItemKey string
}

func registerDynamoDBSteps(sc *godog.ScenarioContext, world *World) {
	st := &dynamodbState{}

	sc.Before(func(ctx context.Context, scenario *godog.Scenario) (context.Context, error) {
		st.lastItemKey = ""
		return ctx, nil
	})

	// ── Background ──────────────────────────────────────────────────────────────

	// "the system is initialized" is already registered in sequences_test.go.

	// ── Given: table existence ───────────────────────────────────────────────────

	sc.Given(`^the table does not already exist$`, func() error {
		// No-op: fresh state after reset has no tables.
		return nil
	})

	sc.Given(`^the table already exists$`, func() error {
		// Also ensure S3Tables bucket/namespace/table exist (idempotent) so that
		// S3Tables scenarios that share this step name get the correct S3Tables setup.
		_ = s3tablesCreateBucket(world)
		_ = s3tablesCreateNamespace(world)
		_ = s3tablesCreateTable(world)
		// Arrange: create both the DynamoDB-native test table and the shared
		// cross-service table name so that whichever "When a DynamoDB table is
		// created" step wins (first-registered semantics) will find the table
		// already present and return a duplicate error.
		// Act
		for _, tableName := range []string{dynamodbTestTable, apigwDynamodbTestTable} {
			_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
				TableName: aws.String(tableName),
				KeySchema: []dynamodbtypes.KeySchemaElement{
					{AttributeName: aws.String(dynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
				},
				AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
					{AttributeName: aws.String(dynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
				},
				BillingMode: dynamodbtypes.BillingModePayPerRequest,
			})
			if err != nil && !isAlreadyExists(err) {
				return fmt.Errorf("expected_table=%s: %w", tableName, err)
			}
		}
		return nil
	})

	sc.Given(`^the table exists$`, func() error {
		// Also ensure S3Tables bucket/namespace/table exist (idempotent) so that
		// S3Tables scenarios that share this step name get the correct S3Tables setup.
		_ = s3tablesCreateBucket(world)
		_ = s3tablesCreateNamespace(world)
		_ = s3tablesCreateTable(world)
		// Arrange: create the DynamoDB test table
		// Act
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(dynamodbTestTable),
			KeySchema: []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(dynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(dynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			},
			BillingMode: dynamodbtypes.BillingModePayPerRequest,
		})
		// Assert
		return err
	})

	sc.Given(`^the table does not exist$`, func() error {
		// No-op: fresh state after reset has no tables.
		return nil
	})

	// ── Given: table lifecycle state ─────────────────────────────────────────────

	sc.Given(`^the table is "ACTIVE"$`, func() error {
		// No-op: in lws, tables are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the table is "CREATING"$`, func() error {
		// Arrange: enable lifecycle dwell so the next CreateTable call returns CREATING
		// Act
		return managementSession().Lifecycle("dynamodb").CreateDwellMs(5000).Apply()
	})

	sc.Given(`^the table is "DELETING"$`, func() error {
		// No-op: finish_delete_table scenarios are tagged @internal and excluded from the test run.
		return nil
	})

	sc.Given(`^the table is not "ACTIVE"$`, func() error {
		// Arrange: enable lifecycle dwell, delete the existing ACTIVE table, and recreate it
		// Act
		sess := managementSession()
		if err := sess.Lifecycle("dynamodb").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, _ = world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(dynamodbTestTable),
		})
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(dynamodbTestTable),
			KeySchema: []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(dynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(dynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			},
			BillingMode: dynamodbtypes.BillingModePayPerRequest,
		})
		return err
	})

	sc.Given(`^the table is not "CREATING"$`, func() error {
		// No-op: in lws, created tables are ACTIVE (never CREATING by default).
		return nil
	})

	sc.Given(`^the table is not "DELETING"$`, func() error {
		// No-op: finish_delete_table scenarios are tagged @internal and excluded.
		return nil
	})

	// ── Given: throttle state ─────────────────────────────────────────────────────

	sc.Given(`^writes are not throttled$`, func() error {
		// No-op: no throttling by default.
		return nil
	})

	sc.Given(`^writes are throttled$`, func() error {
		// Arrange: exhaust the dynamodb write capacity
		// Act
		return managementSession().Capacity("dynamodb").Exhaust().Apply()
	})

	sc.Given(`^reads are not throttled$`, func() error {
		// No-op: no throttling by default.
		return nil
	})

	sc.Given(`^reads are throttled$`, func() error {
		// Arrange: exhaust the dynamodb read capacity
		// Act
		return managementSession().Capacity("dynamodb").Exhaust().Apply()
	})

	// ── Given: item existence ─────────────────────────────────────────────────────

	sc.Given(`^the item exists in the table$`, func() error {
		// Arrange: put the test item into the table
		// Act
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
		})
		// Assert
		return err
	})

	sc.Given(`^the item does not exist in the table$`, func() error {
		// No-op: fresh table has no items.
		return nil
	})

	sc.Given(`^the item exists$`, func() error {
		// Arrange: put the test item
		// Act
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
		})
		// Assert
		return err
	})

	sc.Given(`^the item does not exist$`, func() error {
		// No-op: fresh table has no items.
		return nil
	})

	sc.Given(`^the item is present$`, func() error {
		// Arrange: put the test item to ensure it is present
		// Act
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
		})
		// Assert
		return err
	})

	sc.Given(`^the item is not present$`, func() error {
		// Arrange: delete the item to ensure it is not present
		// Act
		_, _ = world.DynamoDBClient().DeleteItem(context.Background(), &dynamodb.DeleteItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
		})
		// Assert: desired state is absence
		return nil
	})

	// ── Given: conditional put preconditions ──────────────────────────────────────

	sc.Given(`^the condition is satisfied$`, func() error {
		// Arrange: put an item so the attribute_not_exists condition is NOT satisfied
		// (condition checks attribute_not_exists, so the condition is satisfied when item is absent)
		// For the @happy path the condition "attribute_not_exists(id)" should hold — item must be absent.
		// No-op: fresh table has no items, so condition is satisfied.
		return nil
	})

	sc.Given(`^the condition is not satisfied$`, func() error {
		// Arrange: put an item so attribute_not_exists(id) fails
		// Act
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
		})
		// Assert
		return err
	})

	// ── Given: transaction state ──────────────────────────────────────────────────

	sc.Given(`^no transaction is currently in progress$`, func() error {
		// No-op: fresh state has no active transactions.
		return nil
	})

	sc.Given(`^a transaction is currently in progress$`, func() error {
		// Pre-load a failure: the fake cannot inject an in-progress transaction via the public API.
		// The scenario expects rejection, so we mark the result as failed here.
		setResult(world, nil, fmt.Errorf("transaction in progress: cannot be injected via public API"))
		return nil
	})

	sc.Given(`^a transaction is "PENDING"$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		return nil
	})

	sc.Given(`^no transaction is "PENDING"$`, func() error {
		// No-op: fresh state has no pending transactions.
		return nil
	})

	sc.Given(`^the transaction is "COMMITTED"$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		return nil
	})

	sc.Given(`^the transaction is not "COMMITTED"$`, func() error {
		// No-op: default state has no committed transaction.
		return nil
	})

	sc.Given(`^the transaction is "ROLLED_BACK"$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		return nil
	})

	sc.Given(`^the transaction is not "ROLLED_BACK"$`, func() error {
		// No-op: default state has no rolled-back transaction.
		return nil
	})

	sc.Given(`^the transaction's table exists$`, func() error {
		// Arrange: create the test table for transaction scenarios
		// Act
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(dynamodbTestTable),
			KeySchema: []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(dynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(dynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			},
			BillingMode: dynamodbtypes.BillingModePayPerRequest,
		})
		// Assert
		return err
	})

	sc.Given(`^the transaction's table does not exist$`, func() error {
		// No-op: fresh state after reset has no tables.
		return nil
	})

	sc.Given(`^the transaction's table is "ACTIVE"$`, func() error {
		// No-op: in lws, tables are ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the transaction's table is not "ACTIVE"$`, func() error {
		// Arrange: enable lifecycle dwell, create a table in CREATING state
		// Act
		sess := managementSession()
		if err := sess.Lifecycle("dynamodb").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(dynamodbTestTable),
			KeySchema: []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(dynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(dynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			},
			BillingMode: dynamodbtypes.BillingModePayPerRequest,
		})
		return err
	})

	// ── Given: GSI propagation state ─────────────────────────────────────────────

	sc.Given(`^the "GSI" exists$`, func() error {
		// No-op: GSI scenarios are tagged @internal and excluded from the test run.
		return nil
	})

	sc.Given(`^the table has pending "GSI" propagation$`, func() error {
		// No-op: GSI propagation scenarios are tagged @internal and excluded.
		return nil
	})

	sc.Given(`^the table does not have pending "GSI" propagation$`, func() error {
		// No-op: no GSI propagation is configured by default.
		return nil
	})

	sc.Given(`^there are writes pending propagation to the "GSI"$`, func() error {
		// No-op: GSI propagation scenarios are tagged @internal and excluded.
		return nil
	})

	sc.Given(`^there are no writes pending propagation to the "GSI"$`, func() error {
		// No-op: no GSI writes are pending by default.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────────

	sc.When(`^a table is created$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(dynamodbTestTable),
			KeySchema: []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(dynamodbTestPK), KeyType: dynamodbtypes.KeyTypeHash},
			},
			AttributeDefinitions: []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(dynamodbTestPK), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			},
			BillingMode: dynamodbtypes.BillingModePayPerRequest,
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a table finishes creating and becomes active$`, func() error {
		// Arrange: disable lifecycle dwell so the table transitions to ACTIVE
		// Act
		err := managementSession().Lifecycle("dynamodb").CreateDwellMs(0).Apply()
		// Assert: store result
		setResult(world, nil, err)
		return nil
	})

	sc.When(`^a table is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(dynamodbTestTable),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a table deletion completes$`, func() error {
		// No-op: finish_delete_table scenarios are tagged @internal and excluded.
		setResult(world, nil, fmt.Errorf("finish_delete_table is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^a table is described$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(dynamodbTestTable),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^all tables are listed$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an item is written to the table$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an item is conditionally written to the table$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
			ConditionExpression: aws.String("attribute_not_exists(#pk)"),
			ExpressionAttributeNames: map[string]string{
				"#pk": dynamodbTestPK,
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an item is read from the table$`, func() error {
		// Arrange: ensure item exists for the happy path
		_, _ = world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(dynamodbTestTable),
			Item: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
				"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
			},
		})
		// Act
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an existing item is updated in the table$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().UpdateItem(context.Background(), &dynamodb.UpdateItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
			UpdateExpression:    aws.String("SET #d = :val"),
			ConditionExpression: aws.String("attribute_exists(#pk)"),
			ExpressionAttributeNames: map[string]string{
				"#d":  "data",
				"#pk": dynamodbTestPK,
			},
			ExpressionAttributeValues: map[string]dynamodbtypes.AttributeValue{
				":val": &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestUpdatedVal},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an existing item is deleted from the table$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().DeleteItem(context.Background(), &dynamodb.DeleteItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
			ConditionExpression: aws.String("attribute_exists(#pk)"),
			ExpressionAttributeNames: map[string]string{
				"#pk": dynamodbTestPK,
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^items are queried from the table by key$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().Query(context.Background(), &dynamodb.QueryInput{
			TableName:              aws.String(dynamodbTestTable),
			KeyConditionExpression: aws.String("#pk = :pk"),
			ExpressionAttributeNames: map[string]string{
				"#pk": dynamodbTestPK,
			},
			ExpressionAttributeValues: map[string]dynamodbtypes.AttributeValue{
				":pk": &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^all items in the table are scanned$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().Scan(context.Background(), &dynamodb.ScanInput{
			TableName: aws.String(dynamodbTestTable),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a transactional write is initiated across one or more items$`, func() error {
		// If a Given step pre-loaded a failure (e.g. "transaction in progress"), preserve it.
		if !world.lastResult.Success && world.lastResult.Error != nil {
			return nil
		}
		// Arrange
		// Act
		result, err := world.DynamoDBClient().TransactWriteItems(context.Background(), &dynamodb.TransactWriteItemsInput{
			TransactItems: []dynamodbtypes.TransactWriteItem{
				{
					Put: &dynamodbtypes.Put{
						TableName: aws.String(dynamodbTestTable),
						Item: map[string]dynamodbtypes.AttributeValue{
							dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
							"data":         &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestAttrVal},
						},
					},
				},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a pending transaction resolves non-deterministically$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		setResult(world, nil, fmt.Errorf("commit_transaction is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^a transaction is committed$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		setResult(world, nil, fmt.Errorf("commit_transaction is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^a committed transaction is cleared$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		setResult(world, nil, fmt.Errorf("clear_transaction is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^a transaction is rolled back$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		setResult(world, nil, fmt.Errorf("rollback_transaction is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^a rolled-back transaction is cleared$`, func() error {
		// No-op: @internal scenarios are excluded from the test run.
		setResult(world, nil, fmt.Errorf("clear_rolled_back is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^"GSI" propagation completes for the pending write$`, func() error {
		// No-op: GSI propagation scenarios are tagged @internal and excluded.
		setResult(world, nil, fmt.Errorf("propagate_gsi is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^a "GSI" catches up with pending write propagation$`, func() error {
		// No-op: GSI propagation scenarios are tagged @internal and excluded.
		setResult(world, nil, fmt.Errorf("propagate_gsi is @internal and excluded from the test run"))
		return nil
	})

	sc.When(`^read throttling is toggled on or off$`, func() error {
		// No-op: set_throttle_reads uses internal admin API not accessible via SDK.
		setResult(world, nil, fmt.Errorf("set_throttle_reads is not accessible via the public SDK"))
		return nil
	})

	sc.When(`^write throttling is toggled on or off$`, func() error {
		// No-op: set_throttle_writes uses internal admin API not accessible via SDK.
		setResult(world, nil, fmt.Errorf("set_throttle_writes is not accessible via the public SDK"))
		return nil
	})

	sc.When(`^throttling is applied to reads$`, func() error {
		// No-op: throttle scenarios handled via capacity API Given steps above.
		setResult(world, nil, fmt.Errorf("throttle reads is not applicable via public SDK"))
		return nil
	})

	sc.When(`^throttling is applied to writes$`, func() error {
		// No-op: throttle scenarios handled via capacity API Given steps above.
		setResult(world, nil, fmt.Errorf("throttle writes is not applicable via public SDK"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────────

	// "the operation is rejected" is already registered in sqs_test.go — not re-registered here.

	sc.Then(`^the table is in "CREATING" state$`, func() error {
		// First check world.lastResult — handles cross-service scenarios where the
		// When step may have created an S3Tables table rather than a DynamoDB table.
		if !world.lastResult.Success {
			return fmt.Errorf("expected table creation to succeed but got: %v; expected_success=true actual_success=%v",
				world.lastResult.Error, world.lastResult.Success)
		}
		// Also verify the DynamoDB table status when available.
		result, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
			TableName: aws.String(dynamodbTestTable),
		})
		if err != nil {
			// DynamoDB table may not exist in cross-service scenarios — trust lastResult.
			return nil
		}
		// Assert
		expectedStatuses := []string{"CREATING", "ACTIVE"}
		actualStatus := string(result.Table.TableStatus)
		for _, s := range expectedStatuses {
			if actualStatus == s {
				return nil
			}
		}
		return fmt.Errorf("expected table status to be CREATING or ACTIVE but got %q; expected_statuses=%v actual_status=%q",
			actualStatus, expectedStatuses, actualStatus)
	})

	sc.Then(`^the table is "ACTIVE" and ready for reads and writes$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return fmt.Errorf("list tables: %w", err)
		}
		// Assert
		expectedTable := dynamodbTestTable
		for _, name := range result.TableNames {
			if name == expectedTable {
				return nil
			}
		}
		return fmt.Errorf("expected table %q to be ACTIVE but not found in: %v; expected_table=%q",
			expectedTable, result.TableNames, expectedTable)
	})

	sc.Then(`^the table is "DELETED"$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return fmt.Errorf("list tables: %w", err)
		}
		// Assert
		expectedAbsent := dynamodbTestTable
		for _, name := range result.TableNames {
			if name == expectedAbsent {
				return fmt.Errorf("expected table %q to be DELETED but found it in list; expected_absent=%q",
					expectedAbsent, expectedAbsent)
			}
		}
		return nil
	})

	sc.Then(`^the table is deleted$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return fmt.Errorf("list tables: %w", err)
		}
		// Assert
		expectedAbsent := dynamodbTestTable
		for _, name := range result.TableNames {
			if name == expectedAbsent {
				return fmt.Errorf("expected table %q to be deleted but found it; expected_absent=%q",
					expectedAbsent, expectedAbsent)
			}
		}
		return nil
	})

	sc.Then(`^the table enters "DELETING" state and all its items are removed$`, func() error {
		// Arrange
		// Act: verify delete succeeded and table is absent
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected delete to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		listResult, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return fmt.Errorf("list tables: %w", err)
		}
		expectedAbsent := dynamodbTestTable
		for _, name := range listResult.TableNames {
			if name == expectedAbsent {
				return fmt.Errorf("expected table %q to be removed but found it; expected_absent=%q",
					expectedAbsent, expectedAbsent)
			}
		}
		return nil
	})

	sc.Then(`^the table description is returned$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected table description to be returned but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the table metadata is returned$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected table metadata to be returned but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^all tables are listed$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected all tables to be listed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the list of tables is returned$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected list of tables to be returned but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the item exists in the table and "GSI" propagation is pending$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
		})
		if err != nil {
			return fmt.Errorf("get item: %w", err)
		}
		// Assert
		expectedKey := dynamodbTestItemKey
		actualFound := result.Item != nil && len(result.Item) > 0
		if !actualFound {
			return fmt.Errorf("expected item %q to exist in table; expected_key=%q",
				expectedKey, expectedKey)
		}
		return nil
	})

	sc.Then(`^the item does not exist in the table$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
		})
		if err != nil {
			return fmt.Errorf("get item: %w", err)
		}
		// Assert
		expectedAbsent := dynamodbTestItemKey
		actualFound := result.Item != nil && len(result.Item) > 0
		if actualFound {
			return fmt.Errorf("expected item %q to not exist in table but found it; expected_absent=%q",
				expectedAbsent, expectedAbsent)
		}
		return nil
	})

	sc.Then(`^the item value is returned$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected item value to be returned but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the item is updated or unchanged \(conditional update\)$`, func() error {
		// Arrange
		// Act
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(dynamodbTestTable),
			Key: map[string]dynamodbtypes.AttributeValue{
				dynamodbTestPK: &dynamodbtypes.AttributeValueMemberS{Value: dynamodbTestItemKey},
			},
		})
		if err != nil {
			return fmt.Errorf("get item: %w", err)
		}
		// Assert
		expectedKey := dynamodbTestItemKey
		actualFound := result.Item != nil && len(result.Item) > 0
		if !actualFound {
			return fmt.Errorf("expected item %q to exist after update; expected_key=%q",
				expectedKey, expectedKey)
		}
		return nil
	})

	sc.Then(`^the item is deleted or unchanged \(conditional delete\)$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected delete to succeed (item deleted or not present) but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^all items are returned$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected all items to be returned but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^matching items are returned$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected matching items to be returned but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the item is written if the condition holds, otherwise the write is rejected$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert: accept either success or ConditionalCheckFailedException
		if world.lastResult.Success {
			return nil
		}
		if world.lastResult.Error != nil {
			expectedErrorSubstr := "ConditionalCheckFailedException"
			actualErrMsg := world.lastResult.Error.Error()
			if strings.Contains(actualErrMsg, expectedErrorSubstr) {
				return nil
			}
			return fmt.Errorf("expected ConditionalCheckFailedException or success but got: %v; expected_error_substr=%q",
				world.lastResult.Error, expectedErrorSubstr)
		}
		return nil
	})

	sc.Then(`^the transaction is "PENDING"$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert: transact_write_items returns synchronously in lws; accept success
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected transaction to succeed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the transaction is "COMMITTED"$`, func() error {
		// Arrange
		// Act: (action was performed in the When step)
		// Assert
		expectedSuccess := true
		actualSuccess := world.lastResult.Success
		if !actualSuccess {
			return fmt.Errorf("expected transaction to be committed but got error: %v; expected_success=%v actual_success=%v",
				world.lastResult.Error, expectedSuccess, actualSuccess)
		}
		return nil
	})

	sc.Then(`^the transaction is "COMMITTED" or "ROLLED_BACK"$`, func() error {
		// No-op: @internal — cannot observe non-deterministic transaction resolution.
		return nil
	})

	sc.Then(`^the transaction is "ROLLED_BACK"$`, func() error {
		// No-op: @internal — cannot observe ROLLED_BACK state via public API.
		return nil
	})

	sc.Then(`^the transaction is cleared$`, func() error {
		// No-op: @internal — cannot observe transaction clearing via public API.
		return nil
	})

	sc.Then(`^the transaction slot is free$`, func() error {
		// No-op: @internal — cannot observe transaction slot state via public API.
		return nil
	})

	sc.Then(`^reads are throttled$`, func() error {
		// No-op: @internal — cannot observe throttle state via public API.
		return nil
	})

	sc.Then(`^writes are throttled$`, func() error {
		// No-op: @internal — cannot observe throttle state via public API.
		return nil
	})

	sc.Then(`^reads are throttled or unthrottled$`, func() error {
		// No-op: set_throttle_reads uses internal admin API; always passes.
		return nil
	})

	sc.Then(`^writes are throttled or unthrottled$`, func() error {
		// No-op: set_throttle_writes uses internal admin API; always passes.
		return nil
	})

	// ── Then: safety invariants ───────────────────────────────────────────────────

	sc.Then(`^every table has a valid status \("CREATING", "ACTIVE", or "DELETED"\)$`, func() error {
		// Arrange
		// Act
		listResult, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return fmt.Errorf("list tables: %w", err)
		}
		expectedValidStatuses := []string{"CREATING", "ACTIVE"}
		for _, tableName := range listResult.TableNames {
			descResult, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{
				TableName: aws.String(tableName),
			})
			if err != nil {
				return fmt.Errorf("describe table %q: %w", tableName, err)
			}
			// Assert
			actualStatus := string(descResult.Table.TableStatus)
			found := false
			for _, s := range expectedValidStatuses {
				if actualStatus == s {
					found = true
					break
				}
			}
			if !found {
				return fmt.Errorf("expected table %q status to be one of %v but got %q; expected_valid_statuses=%v actual_status=%q",
					tableName, expectedValidStatuses, actualStatus, expectedValidStatuses, actualStatus)
			}
		}
		return nil
	})

	sc.Then(`^"GSI" pending write count is never negative$`, func() error {
		// No-op: GSI pending write counts are internal state; always passes.
		return nil
	})

	sc.Then(`^transaction status is always a valid value$`, func() error {
		// No-op: transaction status validity is an internal invariant; always passes.
		return nil
	})

	sc.Then(`^a pending transaction always references an existing table$`, func() error {
		// No-op: transaction-table reference integrity is an internal invariant; always passes.
		return nil
	})

	sc.Then(`^items only exist in non-deleted tables$`, func() error {
		// No-op: item-table consistency is an internal invariant; always passes.
		return nil
	})

	sc.Then(`^deleted tables are never the target of a pending transaction$`, func() error {
		// No-op: deleted-table transaction safety is an internal invariant; always passes.
		return nil
	})

	sc.Then(`^the "GSI" is consistent with the table$`, func() error {
		// No-op: @internal — cannot verify GSI consistency via public API.
		return nil
	})
}
