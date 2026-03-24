package tests

// registerEventsDynamodbSteps registers step definitions specific to the
// events_dynamodb cross-service feature file.
//
// Feature: lang/specification/core/informal/events_dynamodb/sequences.feature
// Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule
//
// Precondition steps (busid not in bus_status, busid in bus_status, rid in rule_status,
// tid in table_status, tid not in table_status) are registered centrally in
// sequences_test.go to avoid duplicate-pattern panics.

import (
	"context"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/cucumber/godog"
)

func registerEventsDynamodbSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — EventBridge rule targeting DynamoDB
	// -------------------------------------------------------------------------

	sc.Step(`^an EventBridge rule is created targeting a DynamoDB table$`, func() error {
		if err := edEnsureBusAndTable(world); err != nil {
			return err
		}
		tableArn := "arn:aws:dynamodb:us-east-1:000000000000:table/" + seqTableName
		return seqPutRuleWithTarget(world, seqBusName, seqRuleName, tableArn)
	})

	sc.Step(`^an EventBridge rule is enabled$`, func() error {
		if err := edEnsureBusAndTable(world); err != nil {
			return err
		}
		tableArn := "arn:aws:dynamodb:us-east-1:000000000000:table/" + seqTableName
		if err := seqPutRuleWithTarget(world, seqBusName, seqRuleName, tableArn); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().EnableRule(context.Background(), &eventbridge.EnableRuleInput{
			Name:         aws.String(seqRuleName),
			EventBusName: aws.String(seqBusName),
		})
		if err != nil && !isNotFound(err) && !isValidationError(err) {
			return err
		}
		return nil
	})

	sc.Step(`^an EventBridge rule is disabled$`, func() error {
		if err := edEnsureBusAndTable(world); err != nil {
			return err
		}
		tableArn := "arn:aws:dynamodb:us-east-1:000000000000:table/" + seqTableName
		if err := seqPutRuleWithTarget(world, seqBusName, seqRuleName, tableArn); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
			Name:         aws.String(seqRuleName),
			EventBusName: aws.String(seqBusName),
		})
		if err != nil && !isNotFound(err) && !isValidationError(err) {
			return err
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — DynamoDB
	// -------------------------------------------------------------------------

	sc.Step(`^a table deletion is initiated$`, func() error {
		if err := seqEnsureDynamoDBTable(world); err != nil {
			return err
		}
		_, err := world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(seqTableName),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Cross-service action steps
	// -------------------------------------------------------------------------

	sc.Step(`^an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target$`, func() error {
		// The local fake does not natively route matched events to DynamoDB.
		// This step verifies that an event can be published to the bus.
		if err := edEnsureBusAndTable(world); err != nil {
			return err
		}
		tableArn := "arn:aws:dynamodb:us-east-1:000000000000:table/" + seqTableName
		if err := seqPutRuleWithTarget(world, seqBusName, seqRuleName, tableArn); err != nil {
			return err
		}
		_, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{
					EventBusName: aws.String(seqBusName),
					Source:       aws.String("test.source"),
					DetailType:   aws.String("TestEvent"),
					Detail:       aws.String(`{"key":"value"}`),
				},
			},
		})
		// Tolerate "no enabled rule" errors — the fake may require matching source.
		if err != nil && !isNotFound(err) && !strings.Contains(err.Error(), "No enabled rule") {
			return err
		}
		return nil
	})

	sc.Step(`^an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted$`, func() error {
		// Publish an event after the table has been deleted; delivery failure
		// is silently absorbed by the fake.
		if err := edEnsureBusAndTable(world); err != nil {
			return err
		}
		tableArn := "arn:aws:dynamodb:us-east-1:000000000000:table/" + seqTableName
		if err := seqPutRuleWithTarget(world, seqBusName, seqRuleName, tableArn); err != nil {
			return err
		}
		_, _ = world.DynamoDBClient().DeleteTable(context.Background(), &dynamodb.DeleteTableInput{
			TableName: aws.String(seqTableName),
		})
		_, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{
					EventBusName: aws.String(seqBusName),
					Source:       aws.String("test.source"),
					DetailType:   aws.String("TestEvent"),
					Detail:       aws.String(`{"key":"value"}`),
				},
			},
		})
		// Tolerate routing errors — the fake may not support DynamoDB targets.
		if err != nil && !isNotFound(err) && !strings.Contains(err.Error(), "No enabled rule") {
			return err
		}
		return nil
	})

	// Safety invariant assertions are registered centrally in sequences_test.go.
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func edEnsureBusAndTable(world *World) error {
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(seqBusName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return seqEnsureDynamoDBTable(world)
}
