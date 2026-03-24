package tests

// registerStepfunctionsS3apiSteps registers step definitions specific to the
// stepfunctions_s3api cross-service feature file.
//
// Feature: lang/specification/core/informal/stepfunctions_s3api/sequences.feature
// Safety invariants: RunningExecutionReferencesActiveStateMachine,
//                    ExistingObjectBelongsToActiveBucket
//
// Precondition steps (smid in sm_status, smid not in sm_status, eid in exec_status,
// bid not in bucket_status) are registered centrally in sequences_test.go.

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/cucumber/godog"
)

const (
	sfnS3ObjectKeyLocal = "sfn-s3-object.txt"
)

func registerStepfunctionsS3apiSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — configuration
	// -------------------------------------------------------------------------

	sc.Step(`^an S3 task is configured on the state machine$`, func() error {
		if err := sfnS3EnsureBucket(world); err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "S3 GetObject task",
  "StartAt": "GetObject",
  "States": {
    "GetObject": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:s3:getObject",
      "Parameters": {
        "Bucket": "%s",
        "Key": "%s"
      },
      "End": true
    }
  }
}`, seqBucketName, sfnS3ObjectKeyLocal)
		st := &seqState{}
		return seqEnsureStateMachineWithDef(world, st, seqSMName, def)
	})

	// -------------------------------------------------------------------------
	// Action steps — execution
	// -------------------------------------------------------------------------

	sc.Step(`^a running execution writes an object to the S3 bucket and succeeds$`, func() error {
		if err := sfnS3EnsureBucket(world); err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "S3 PutObject task",
  "StartAt": "PutObject",
  "States": {
    "PutObject": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:s3:putObject",
      "Parameters": {
        "Bucket": "%s",
        "Key": "%s",
        "Body": "sfn-object-content"
      },
      "End": true
    }
  }
}`, seqBucketName, sfnS3ObjectKeyLocal)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnS3GetSMArn(world)
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

	sc.Step(`^a running execution reads an existing object from the S3 bucket and succeeds$`, func() error {
		if err := sfnS3EnsureBucket(world); err != nil {
			return err
		}
		if err := sfnS3UploadObject(world); err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "S3 GetObject task",
  "StartAt": "GetObject",
  "States": {
    "GetObject": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:s3:getObject",
      "Parameters": {
        "Bucket": "%s",
        "Key": "%s"
      },
      "End": true
    }
  }
}`, seqBucketName, sfnS3ObjectKeyLocal)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnS3GetSMArn(world)
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

	sc.Step(`^a running execution fails to read because no object exists in the bucket$`, func() error {
		if err := sfnS3EnsureBucket(world); err != nil {
			return err
		}
		def := fmt.Sprintf(`{
  "Comment": "S3 GetObject task for missing key",
  "StartAt": "GetObject",
  "States": {
    "GetObject": {
      "Type": "Task",
      "Resource": "arn:aws:states:::aws-sdk:s3:getObject",
      "Parameters": {
        "Bucket": "%s",
        "Key": "nonexistent-key.txt"
      },
      "End": true
    }
  }
}`, seqBucketName)
		st := &seqState{}
		if err := seqEnsureStateMachineWithDef(world, st, seqSMName, def); err != nil {
			return err
		}
		smArn, err := sfnS3GetSMArn(world)
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

func sfnS3EnsureBucket(world *World) error {
	_, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
		Bucket: aws.String(seqBucketName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}

func sfnS3UploadObject(world *World) error {
	_, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
		Bucket: aws.String(seqBucketName),
		Key:    aws.String(sfnS3ObjectKeyLocal),
		Body:   strings.NewReader("sfn-s3-content"),
	})
	return err
}

func sfnS3GetSMArn(world *World) (string, error) {
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
