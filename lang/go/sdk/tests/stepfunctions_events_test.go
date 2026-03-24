package tests

// registerStepfunctionsEventsSteps registers step definitions specific to the
// stepfunctions_events cross-service feature file.
//
// Feature: lang/specification/core/informal/stepfunctions_events/sequences.feature
// Safety invariants: RunningExecutionReferencesActiveStateMachine,
//                    DeliveredEventReferencesExecutionThatExists
//
// Precondition steps (busid not in bus_status, busid in bus_status,
// smid in sm_status, smid not in sm_status, eid in exec_status) are registered
// centrally in sequences_test.go.

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/cucumber/godog"
)

func registerStepfunctionsEventsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — configuration
	// -------------------------------------------------------------------------

	sc.Step(`^the state machine is configured to publish execution events to the event bus$`, func() error {
		// Ensure the bus exists. The local fake does not natively publish
		// Step Functions execution lifecycle events to EventBridge — this step
		// simply verifies the bus is reachable.
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — execution lifecycle
	// -------------------------------------------------------------------------

	sc.Step(`^an execution starts and Step Functions delivers a "STARTED" event to the EventBridge bus$`, func() error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		st := &seqState{}
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		_ = seqWaitForTerminal(world, *res.ExecutionArn)
		return nil
	})

	sc.Step(`^an execution starts but the "STARTED" event delivery fails because the bus is deleted$`, func() error {
		// Delete the bus then start an execution; delivery failure is silently absorbed.
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(seqBusName),
		})
		st := &seqState{}
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		_ = seqWaitForTerminal(world, *res.ExecutionArn)
		return nil
	})

	sc.Step(`^a running execution succeeds and Step Functions delivers a "SUCCEEDED" event to the bus$`, func() error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(seqBusName),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		st := &seqState{}
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		return seqWaitForExecution(world, *res.ExecutionArn, "SUCCEEDED")
	})

	sc.Step(`^a running execution succeeds but the "SUCCEEDED" event delivery fails because the bus is deleted$`, func() error {
		// Delete the bus then run an execution; delivery failure is silently absorbed.
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(seqBusName),
		})
		st := &seqState{}
		if err := seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(st.smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		return seqWaitForExecution(world, *res.ExecutionArn, "SUCCEEDED")
	})

	// Shared steps (the EventBridge event bus is deleted, safety invariants)
	// are registered centrally in sequences_test.go.
}
