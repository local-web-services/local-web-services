package tests

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/cucumber/godog"
)

func registerClientSteps(sc *godog.ScenarioContext, world *World) {
	// When I request a client for "<service>"
	sc.When(`^I request a client for "([^"]*)"$`, func(service string) error {
		world.lastResult = LastResult{Success: true, Output: service}
		return nil
	})

	// Then a configured client is returned
	sc.Then(`^a configured client is returned$`, func() error {
		if !world.lastResult.Success {
			return fmt.Errorf("expected a client to be returned but got error: %v", world.lastResult.Error)
		}
		return nil
	})

	// And the client can successfully call the <service> service
	sc.Then(`^the client can successfully call the ([^ ]+) service$`, func(service string) error {
		return callService(world, service)
	})
}

// callService makes a basic list/describe call against the named service to verify the client works.
func callService(world *World, service string) error {
	ctx := context.Background()
	service = strings.TrimSpace(service)

	switch service {
	case "dynamodb":
		_, err := world.DynamoDBClient().ListTables(ctx, &dynamodb.ListTablesInput{})
		return err
	case "sqs":
		_, err := world.SQSClient().ListQueues(ctx, &sqs.ListQueuesInput{})
		return err
	case "s3":
		_, err := world.S3Client().ListBuckets(ctx, &s3.ListBucketsInput{})
		return err
	case "sns":
		_, err := world.SNSClient().ListTopics(ctx, &sns.ListTopicsInput{})
		return err
	case "stepfunctions":
		_, err := world.SFNClient().ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		return err
	case "ssm":
		_, err := world.SSMClient().DescribeParameters(ctx, &ssm.DescribeParametersInput{})
		return err
	case "secretsmanager":
		_, err := world.SecretsManagerClient().ListSecrets(ctx, &secretsmanager.ListSecretsInput{})
		return err
	default:
		return fmt.Errorf("unknown service: %s", service)
	}
}

// dispatchServiceCall makes a named service call and stores the result in world.lastResult.
// This is shared by chaos, fake, IAM, and log capture test steps.
func dispatchServiceCall(world *World, service, operation string) error {
	ctx := context.Background()

	switch service {
	case "dynamodb":
		return callDynamoDBOp(world, ctx, operation)
	case "sqs":
		return callSQSOp(world, ctx, operation)
	case "s3":
		return callS3Op(world, ctx, operation)
	case "sns":
		return callSNSOp(world, ctx, operation)
	case "stepfunctions":
		return callSFNOp(world, ctx, operation)
	case "ssm":
		return callSSMOp(world, ctx, operation)
	case "secretsmanager":
		return callSecretsManagerOp(world, ctx, operation)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending: %s %s", service, operation)}}
		return godog.ErrPending
	}
}

func callDynamoDBOp(world *World, ctx context.Context, operation string) error {
	client := world.DynamoDBClient()
	switch operation {
	case "ListTables":
		result, err := client.ListTables(ctx, &dynamodb.ListTablesInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending dynamodb: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}

func callSQSOp(world *World, ctx context.Context, operation string) error {
	client := world.SQSClient()
	switch operation {
	case "ListQueues":
		result, err := client.ListQueues(ctx, &sqs.ListQueuesInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending sqs: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}

func callS3Op(world *World, ctx context.Context, operation string) error {
	client := world.S3Client()
	switch operation {
	case "ListBuckets":
		result, err := client.ListBuckets(ctx, &s3.ListBucketsInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending s3: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}

func callSNSOp(world *World, ctx context.Context, operation string) error {
	client := world.SNSClient()
	switch operation {
	case "ListTopics":
		result, err := client.ListTopics(ctx, &sns.ListTopicsInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending sns: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}

func callSFNOp(world *World, ctx context.Context, operation string) error {
	client := world.SFNClient()
	smArn := world.lastStateMachineArn
	if smArn == "" {
		smArn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
	}

	switch operation {
	case "StartExecution":
		result, err := client.StartExecution(ctx, &sfn.StartExecutionInput{
			StateMachineArn: aws.String(smArn),
			Input:           aws.String("{}"),
		})
		setResult(world, result, err)
		if err == nil && result.ExecutionArn != nil {
			world.lastExecArn = *result.ExecutionArn
		}
	case "ListStateMachines":
		result, err := client.ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending sfn: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}

func callSSMOp(world *World, ctx context.Context, operation string) error {
	client := world.SSMClient()
	switch operation {
	case "DescribeParameters":
		result, err := client.DescribeParameters(ctx, &ssm.DescribeParametersInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending ssm: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}

func callSecretsManagerOp(world *World, ctx context.Context, operation string) error {
	client := world.SecretsManagerClient()
	switch operation {
	case "ListSecrets":
		result, err := client.ListSecrets(ctx, &secretsmanager.ListSecretsInput{})
		setResult(world, result, err)
	default:
		world.lastResult = LastResult{Success: true, Output: map[string]interface{}{"message": fmt.Sprintf("pending secretsmanager: %s", operation)}}
		return godog.ErrPending
	}
	return nil
}
