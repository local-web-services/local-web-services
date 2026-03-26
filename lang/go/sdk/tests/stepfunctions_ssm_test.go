package tests

// registerStepfunctionsSsmSteps registers step definitions specific to the
// stepfunctions_ssm cross-service feature file.
//
// Feature: lang/specification/core/informal/stepfunctions_ssm/sequences.feature
// Safety invariants: RunningExecutionReferencesActiveStateMachine,
//                    SucceededExecutionRecordedWhichParameterItRead
//
// Precondition steps (smid in sm_status, smid not in sm_status, eid in exec_status,
// pid in param_status, pid not in param_status) are registered centrally in
// sequences_test.go.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/cucumber/godog"
)

func registerStepfunctionsSsmSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — SSM Parameter Store lifecycle
	// -------------------------------------------------------------------------

	sc.Step(`^a parameter is created in "SSM" Parameter Store$`, func() error {
		// Arrange: create the primary SSM parameter
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(seqParamName),
			Value: aws.String("test-param-value"),
			Type:  "String",
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		// Also create the cross-service parameter name used by lambda_ssm tests
		_, _ = world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String("/e2e/test/param/1"),
			Value: aws.String("test-param-value"),
			Type:  "String",
		})
		return nil
	})

	sc.Step(`^a parameter is deleted from "SSM" Parameter Store$`, func() error {
		_, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{
			Name: aws.String(seqParamName),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — Step Functions reading parameters
	// -------------------------------------------------------------------------

	sc.Step(`^a running execution reads an existing parameter and the task succeeds$`, func() error {
		_, _ = world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(seqParamName),
			Value: aws.String("test-param-value"),
			Type:  "String",
		})
		def := fmt.Sprintf(`{
  "Comment": "SSM GetParameter task",
  "StartAt": "GetParam",
  "States": {
    "GetParam": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:ssm:getParameter",
      "Parameters": {
        "Name": "%s"
      },
      "End": true
    }
  }
}`, seqParamName)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnSsmGetSMArn(world)
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
		_ = seqWaitForTerminal(world, *res.ExecutionArn)
		return nil
	})

	sc.Step(`^a running execution fails to read the parameter because it has been deleted$`, func() error {
		def := fmt.Sprintf(`{
  "Comment": "SSM GetParameter task for deleted parameter",
  "StartAt": "GetParam",
  "States": {
    "GetParam": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:ssm:getParameter",
      "Parameters": {
        "Name": "%s"
      },
      "End": true
    }
  }
}`, seqParamName)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnSsmGetSMArn(world)
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
		_ = seqWaitForTerminal(world, *res.ExecutionArn)
		return nil
	})

	// Safety invariant assertions are registered centrally in sequences_test.go.
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func sfnSsmGetSMArn(world *World) (string, error) {
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
