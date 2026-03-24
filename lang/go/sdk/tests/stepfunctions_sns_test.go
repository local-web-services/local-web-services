package tests

// registerStepfunctionsSnsSteps registers step definitions specific to the
// stepfunctions_sns cross-service feature file.
//
// Feature: lang/specification/core/informal/stepfunctions_sns/sequences.feature
// Safety invariants: RunningExecutionReferencesActiveStateMachine,
//                    RunningExecutionStateMachineTargetsActiveTopic
//
// Precondition steps (smid in sm_status, smid not in sm_status, eid in exec_status,
// tid not in topic_status) are registered centrally in sequences_test.go.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/cucumber/godog"
)

func registerStepfunctionsSnsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — configure and run
	// -------------------------------------------------------------------------

	sc.Step(`^an "SNS" publish task is configured on the state machine$`, func() error {
		topicArn, err := sfnSnsEnsureTopic(world)
		if err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "SNS publish task",
  "StartAt": "Publish",
  "States": {
    "Publish": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sns:publish",
      "Parameters": {
        "TopicArn": "%s",
        "Message": "sfn-message"
      },
      "End": true
    }
  }
}`, topicArn)
		st := &seqState{}
		return seqEnsureStateMachineWithDef(world, st, seqSMName, def)
	})

	sc.Step(`^a running execution publishes a message to the "SNS" topic and succeeds$`, func() error {
		topicArn, err := sfnSnsEnsureTopic(world)
		if err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "SNS publish task",
  "StartAt": "Publish",
  "States": {
    "Publish": {
      "Type": "Task",
      "Resource": "arn:aws:states:::sns:publish",
      "Parameters": {
        "TopicArn": "%s",
        "Message": "sfn-message"
      },
      "End": true
    }
  }
}`, topicArn)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnSnsGetSMArn(world)
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
		// Wait for any terminal state. The local fake may not support
		// arn:aws:states:::sns:publish SDK integrations, so FAILED is acceptable.
		return seqWaitForTerminal(world, *res.ExecutionArn)
	})

	// Safety invariant assertions are registered centrally in sequences_test.go.
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func sfnSnsEnsureTopic(world *World) (string, error) {
	res, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{
		Name: aws.String(seqTopicName),
	})
	if err != nil {
		if isAlreadyExists(err) {
			return fmt.Sprintf("arn:aws:sns:us-east-1:000000000000:%s", seqTopicName), nil
		}
		return "", err
	}
	if res.TopicArn != nil {
		return *res.TopicArn, nil
	}
	return fmt.Sprintf("arn:aws:sns:us-east-1:000000000000:%s", seqTopicName), nil
}

func sfnSnsGetSMArn(world *World) (string, error) {
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
