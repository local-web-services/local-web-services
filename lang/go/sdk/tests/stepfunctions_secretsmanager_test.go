package tests

// registerStepfunctionsSecretsmanagerSteps registers step definitions specific
// to the stepfunctions_secretsmanager cross-service feature file.
//
// Feature: lang/specification/core/informal/stepfunctions_secretsmanager/sequences.feature
// Safety invariants: RunningExecutionReferencesActiveStateMachine,
//                    SucceededExecutionRecordedWhichSecretItRead
//
// Precondition steps (smid in sm_status, smid not in sm_status, eid in exec_status,
// sid in secret_status, sid not in secret_status) are registered centrally in
// sequences_test.go.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/cucumber/godog"
)

func registerStepfunctionsSecretsmanagerSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — Secrets Manager lifecycle
	// -------------------------------------------------------------------------

	sc.Step(`^a secret is created in Secrets Manager$`, func() error {
		_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(seqSecretName),
			SecretString: aws.String("test-secret-value"),
		})
		if err != nil && !isAlreadyExists(err) {
			return err
		}
		return nil
	})

	sc.Step(`^a secret is scheduled for deletion$`, func() error {
		// Ensure the secret exists before attempting deletion.
		_, _ = world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(seqSecretName),
			SecretString: aws.String("test-secret-value"),
		})
		_, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:                   aws.String(seqSecretName),
			ForceDeleteWithoutRecovery: aws.Bool(true),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — Step Functions reading secrets
	// -------------------------------------------------------------------------

	sc.Step(`^a running execution reads an "ACTIVE" secret and the task succeeds$`, func() error {
		_, _ = world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name:         aws.String(seqSecretName),
			SecretString: aws.String("test-secret-value"),
		})
		def := fmt.Sprintf(`{
  "Comment": "SecretsManager GetSecretValue task",
  "StartAt": "GetSecret",
  "States": {
    "GetSecret": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:secretsmanager:getSecretValue",
      "Parameters": {
        "SecretId": "%s"
      },
      "End": true
    }
  }
}`, seqSecretName)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnSmGetSMArn(world)
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

	sc.Step(`^a running execution fails to read the secret because it is pending deletion$`, func() error {
		def := fmt.Sprintf(`{
  "Comment": "SecretsManager GetSecretValue task for deleted secret",
  "StartAt": "GetSecret",
  "States": {
    "GetSecret": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:secretsmanager:getSecretValue",
      "Parameters": {
        "SecretId": "%s"
      },
      "End": true
    }
  }
}`, seqSecretName)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnSmGetSMArn(world)
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

func sfnSmGetSMArn(world *World) (string, error) {
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
