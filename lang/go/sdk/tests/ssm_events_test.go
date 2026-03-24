package tests

// registerSsmEventsSteps registers step definitions specific to the
// ssm_events cross-service feature file.
//
// Feature: lang/specification/core/informal/ssm_events/sequences.feature
// Safety invariants: DeliveredEventReferencesBusThatExists,
//                    DeliveredEventReferencesParameterThatExistsInAnyState
//
// Precondition steps (busid not in bus_status, busid in bus_status,
// pid not in param_status, pid in param_status) and shared action steps
// (the EventBridge event bus is deleted) and safety invariant assertions are
// registered centrally in sequences_test.go.

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/cucumber/godog"
)

func registerSsmEventsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — parameter lifecycle with EventBridge events
	// -------------------------------------------------------------------------

	sc.Step(`^a parameter is created and "SSM" delivers a "CREATED" event to the EventBridge bus$`, func() error {
		if err := ssmEvtEnsureBus(world); err != nil {
			return err
		}
		return ssmEvtEnsureParam(world)
	})

	sc.Step(`^a parameter is created but the "CREATED" event delivery fails because the bus is deleted$`, func() error {
		// Delete the bus first; parameter creation still succeeds but event
		// delivery is silently absorbed by the fake.
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(seqBusName),
		})
		return ssmEvtEnsureParam(world)
	})

	sc.Step(`^a parameter is deleted and "SSM" delivers a "DELETED" event to the EventBridge bus$`, func() error {
		if err := ssmEvtEnsureBus(world); err != nil {
			return err
		}
		if err := ssmEvtEnsureParam(world); err != nil {
			return err
		}
		_, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(seqParamName),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func ssmEvtEnsureBus(world *World) error {
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(seqBusName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}

func ssmEvtEnsureParam(world *World) error {
	_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
		Name:  aws.String(seqParamName),
		Value: aws.String("test-param-value"),
		Type:  "String",
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}
