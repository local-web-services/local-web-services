package tests

// registerEventsStepfunctionsSteps registers step definitions specific to the
// events_stepfunctions cross-service feature file.
//
// Feature: lang/specification/core/informal/events_stepfunctions/sequences.feature
// Safety invariants: RunningExecutionReferencesActiveStateMachine,
//                    RunningExecutionReferencesActiveEventBus,
//                    RunningExecutionWasStartedByEnabledRule
//
// Precondition steps (bid not in bus_status, bid in bus_status, smid not in sm_status,
// eid in exec_status, rid not in rule_status) are registered centrally in
// sequences_test.go to avoid duplicate-pattern panics.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/cucumber/godog"
)

const (
	esfSMDefinitionFail = `{"Comment":"esf-fail","StartAt":"Fail","States":{"Fail":{"Type":"Fail","Error":"TestError","Cause":"forced"}}}`
)

func registerEventsStepfunctionsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — EventBridge rule targeting Step Functions
	// -------------------------------------------------------------------------

	sc.Step(`^an EventBridge rule is created to start a Step Functions execution on matching events$`, func() error {
		if err := esfEnsureBusAndSM(world); err != nil {
			return err
		}
		smArn, err := esfGetSMArn(world)
		if err != nil {
			return err
		}
		return esfPutRuleTargetingSFN(world, smArn)
	})

	sc.Step(`^an event is published to the bus and triggers a new Step Functions execution$`, func() error {
		if err := esfEnsureBusAndSM(world); err != nil {
			return err
		}
		smArn, err := esfGetSMArn(world)
		if err != nil {
			return err
		}
		if err := esfPutRuleTargetingSFN(world, smArn); err != nil {
			return err
		}
		_, err = world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{
					EventBusName: aws.String(seqBusName),
					Source:       aws.String("test.source"),
					DetailType:   aws.String("TestEvent"),
					Detail:       aws.String(`{"key":"value"}`),
				},
			},
		})
		return err
	})

	// -------------------------------------------------------------------------
	// Action steps — Step Functions execution lifecycle
	// -------------------------------------------------------------------------

	sc.Step(`^a running execution completes successfully$`, func() error {
		if err := seqEnsureStateMachineWithDef(world, &seqState{}, seqSMName, seqSMDefinitionPass); err != nil {
			return err
		}
		smArn, err := esfGetSMArn(world)
		if err != nil {
			return err
		}
		res, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		return seqWaitForExecution(world, *res.ExecutionArn, "SUCCEEDED")
	})

	sc.Step(`^a running execution fails$`, func() error {
		failSMName := seqSMName + "-esf-fail"
		res, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
			Name:       aws.String(failSMName),
			Definition: aws.String(esfSMDefinitionFail),
			RoleArn:    aws.String(sfnRoleArn),
			Type:       "STANDARD",
		})
		smArn := ""
		if err != nil {
			if !isAlreadyExists(err) {
				return err
			}
			list, lerr := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
			if lerr != nil {
				return lerr
			}
			for _, sm := range list.StateMachines {
				if sm.Name != nil && *sm.Name == failSMName && sm.StateMachineArn != nil {
					smArn = *sm.StateMachineArn
					break
				}
			}
		} else if res.StateMachineArn != nil {
			smArn = *res.StateMachineArn
		}
		if smArn == "" {
			return fmt.Errorf("could not obtain ARN for failing state machine")
		}
		execRes, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(smArn),
			Input:           aws.String(`{}`),
		})
		if err != nil {
			return err
		}
		return seqWaitForTerminal(world, *execRes.ExecutionArn)
	})

	// Safety invariant assertions are registered centrally in sequences_test.go.
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func esfEnsureBusAndSM(world *World) error {
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(seqBusName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	st := &seqState{}
	return seqEnsureStateMachine(world, st, seqSMName, seqSMDefinitionPass)
}

func esfGetSMArn(world *World) (string, error) {
	list, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
	if err != nil {
		return "", err
	}
	for _, sm := range list.StateMachines {
		if sm.Name != nil && *sm.Name == seqSMName && sm.StateMachineArn != nil {
			return *sm.StateMachineArn, nil
		}
	}
	return "", fmt.Errorf("state machine %q not found", seqSMName)
}

func esfPutRuleTargetingSFN(world *World, smArn string) error {
	_, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
		Name:         aws.String(seqRuleName),
		EventBusName: aws.String(seqBusName),
		EventPattern: aws.String(`{"source":["test.source"]}`),
		State:        ebtypes.RuleStateEnabled,
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	_, err = world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
		Rule:         aws.String(seqRuleName),
		EventBusName: aws.String(seqBusName),
		Targets: []ebtypes.Target{
			{Id: aws.String("target-1"), Arn: aws.String(smArn)},
		},
	})
	return err
}
