package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	ddbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/cucumber/godog"
)

func registerDynamoDBSteps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^a DynamoDB table "([^"]*)" with partition key "([^"]*)" exists$`, func(tableName, partitionKey string) error {
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName:            aws.String(tableName),
			KeySchema:            []ddbtypes.KeySchemaElement{{AttributeName: aws.String(partitionKey), KeyType: ddbtypes.KeyTypeHash}},
			AttributeDefinitions: []ddbtypes.AttributeDefinition{{AttributeName: aws.String(partitionKey), AttributeType: ddbtypes.ScalarAttributeTypeS}},
			BillingMode:          ddbtypes.BillingModePayPerRequest,
		})
		return err
	})

	sc.Given(`^a DynamoDB table "([^"]*)" with partition key "([^"]*)" and sort key "([^"]*)" exists$`, func(tableName, pk, sk string) error {
		_, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName: aws.String(tableName),
			KeySchema: []ddbtypes.KeySchemaElement{
				{AttributeName: aws.String(pk), KeyType: ddbtypes.KeyTypeHash},
				{AttributeName: aws.String(sk), KeyType: ddbtypes.KeyTypeRange},
			},
			AttributeDefinitions: []ddbtypes.AttributeDefinition{
				{AttributeName: aws.String(pk), AttributeType: ddbtypes.ScalarAttributeTypeS},
				{AttributeName: aws.String(sk), AttributeType: ddbtypes.ScalarAttributeTypeS},
			},
			BillingMode: ddbtypes.BillingModePayPerRequest,
		})
		return err
	})

	sc.Given(`^item "([^"]*)" exists in DynamoDB table "([^"]*)"$`, func(itemJSON, tableName string) error {
		var rawItem map[string]interface{}
		json.Unmarshal([]byte(itemJSON), &rawItem)
		item := make(map[string]ddbtypes.AttributeValue)
		for k, v := range rawItem {
			item[k] = &ddbtypes.AttributeValueMemberS{Value: fmt.Sprintf("%v", v)}
		}
		_, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(tableName), Item: item,
		})
		return err
	})

	// When
	sc.When(`^I create a DynamoDB table "([^"]*)" with partition key "([^"]*)"$`, func(tableName, partitionKey string) error {
		result, err := world.DynamoDBClient().CreateTable(context.Background(), &dynamodb.CreateTableInput{
			TableName:            aws.String(tableName),
			KeySchema:            []ddbtypes.KeySchemaElement{{AttributeName: aws.String(partitionKey), KeyType: ddbtypes.KeyTypeHash}},
			AttributeDefinitions: []ddbtypes.AttributeDefinition{{AttributeName: aws.String(partitionKey), AttributeType: ddbtypes.ScalarAttributeTypeS}},
			BillingMode:          ddbtypes.BillingModePayPerRequest,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the DynamoDB table "([^"]*)"$`, func(tableName string) error {
		result, err := world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{TableName: aws.String(tableName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list DynamoDB tables$`, func() error {
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I describe the DynamoDB table "([^"]*)"$`, func(tableName string) error {
		result, err := world.DynamoDBClient().DescribeTable(context.Background(), &dynamodb.DescribeTableInput{TableName: aws.String(tableName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I put item "([^"]*)" into DynamoDB table "([^"]*)"$`, func(itemJSON, tableName string) error {
		var rawItem map[string]interface{}
		json.Unmarshal([]byte(itemJSON), &rawItem)
		item := make(map[string]ddbtypes.AttributeValue)
		for k, v := range rawItem {
			item[k] = &ddbtypes.AttributeValueMemberS{Value: fmt.Sprintf("%v", v)}
		}
		result, err := world.DynamoDBClient().PutItem(context.Background(), &dynamodb.PutItemInput{
			TableName: aws.String(tableName), Item: item,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get item with key "([^"]*)" from DynamoDB table "([^"]*)"$`, func(keyJSON, tableName string) error {
		var rawKey map[string]interface{}
		json.Unmarshal([]byte(keyJSON), &rawKey)
		key := make(map[string]ddbtypes.AttributeValue)
		for k, v := range rawKey {
			key[k] = &ddbtypes.AttributeValueMemberS{Value: fmt.Sprintf("%v", v)}
		}
		result, err := world.DynamoDBClient().GetItem(context.Background(), &dynamodb.GetItemInput{
			TableName: aws.String(tableName), Key: key,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I scan DynamoDB table "([^"]*)"$`, func(tableName string) error {
		result, err := world.DynamoDBClient().Scan(context.Background(), &dynamodb.ScanInput{TableName: aws.String(tableName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete item with key "([^"]*)" from DynamoDB table "([^"]*)"$`, func(keyJSON, tableName string) error {
		var rawKey map[string]interface{}
		json.Unmarshal([]byte(keyJSON), &rawKey)
		key := make(map[string]ddbtypes.AttributeValue)
		for k, v := range rawKey {
			key[k] = &ddbtypes.AttributeValueMemberS{Value: fmt.Sprintf("%v", v)}
		}
		result, err := world.DynamoDBClient().DeleteItem(context.Background(), &dynamodb.DeleteItemInput{
			TableName: aws.String(tableName), Key: key,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the DynamoDB table "([^"]*)" will appear in the table list$`, func(tableName string) error {
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return err
		}
		for _, name := range result.TableNames {
			if name == tableName {
				return nil
			}
		}
		return fmt.Errorf("table %q not found in list: %v", tableName, result.TableNames)
	})

	sc.Then(`^the DynamoDB table "([^"]*)" will not appear in the table list$`, func(tableName string) error {
		result, err := world.DynamoDBClient().ListTables(context.Background(), &dynamodb.ListTablesInput{})
		if err != nil {
			return err
		}
		for _, name := range result.TableNames {
			if name == tableName {
				return fmt.Errorf("table %q found in list but should not be", tableName)
			}
		}
		return nil
	})

	sc.Then(`^the output will contain table "([^"]*)"$`, func(tableName string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), tableName) {
			return fmt.Errorf("expected output to contain %q but got: %s", tableName, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^the DynamoDB table "([^"]*)" will have (\d+) items?$`, func(tableName string, count int) error {
		result, err := world.DynamoDBClient().Scan(context.Background(), &dynamodb.ScanInput{TableName: aws.String(tableName)})
		if err != nil {
			return err
		}
		if int(result.Count) != count {
			return fmt.Errorf("expected %d items but got %d", count, result.Count)
		}
		return nil
	})
}
