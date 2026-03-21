package tests

import (
	"context"
	"fmt"
	"path/filepath"
	"runtime"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/cucumber/godog"
	"github.com/local-web-services/local-web-services-go-sdk/lws"
)

// discoveredSession holds the session created by discovery steps so it can be
// closed at the end of the scenario.
var discoveredSession *lws.Session

func registerDiscoverySteps(sc *godog.ScenarioContext, world *World) {
	sc.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		if discoveredSession != nil {
			discoveredSession.Close()
			discoveredSession = nil
		}
		return ctx, nil
	})

	// CDK discovery feature
	sc.When(`^I create a session from the "([^"]*)" CDK directory$`, func(dir string) error {
		// Arrange — resolve the testdata directory relative to this test file
		_, filename, _, _ := runtime.Caller(0)
		testdataDir := filepath.Join(filepath.Dir(filename), "..", "lws", "testdata", "cdk-fixture")

		// Act
		sess, err := lws.FromCdk(testdataDir)
		if err != nil {
			return fmt.Errorf("FromCdk: %w", err)
		}

		// Assert (store for later steps)
		discoveredSession = sess
		world.sessionOpen = true
		return nil
	})

	sc.Then(`^the resources declared in the CDK stack are available$`, func() error {
		// Assert — verify representative resources exist in the discovered session
		if discoveredSession == nil {
			return fmt.Errorf("no discovered session")
		}
		ctx := context.Background()

		// Check DynamoDB table
		_, err := discoveredSession.DynamoDBClient().DescribeTable(ctx, &dynamodb.DescribeTableInput{
			TableName: aws.String("CdkTestTable"),
		})
		if err != nil {
			return fmt.Errorf("CdkTestTable not found: %w", err)
		}

		// Check SQS queue
		_, err = discoveredSession.SQSClient().GetQueueUrl(ctx, &sqs.GetQueueUrlInput{
			QueueName: aws.String("CdkTestQueue"),
		})
		if err != nil {
			return fmt.Errorf("CdkTestQueue not found: %w", err)
		}

		// Check S3 bucket
		_, err = discoveredSession.S3Client().HeadBucket(ctx, &s3.HeadBucketInput{
			Bucket: aws.String("cdk-test-bucket"),
		})
		if err != nil {
			return fmt.Errorf("cdk-test-bucket not found: %w", err)
		}

		// Check SNS topic
		topicsOut, err := discoveredSession.SNSClient().ListTopics(ctx, &sns.ListTopicsInput{})
		if err != nil {
			return fmt.Errorf("ListTopics: %w", err)
		}
		found := false
		for _, t := range topicsOut.Topics {
			if t.TopicArn != nil && len(*t.TopicArn) > 0 {
				found = true
				break
			}
		}
		if !found {
			return fmt.Errorf("no SNS topics found after CDK discovery")
		}

		// Check Step Functions state machine
		smsOut, err := discoveredSession.SFNClient().ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		if err != nil {
			return fmt.Errorf("ListStateMachines: %w", err)
		}
		foundSM := false
		for _, sm := range smsOut.StateMachines {
			if sm.Name != nil && *sm.Name == "CdkTestStateMachine" {
				foundSM = true
				break
			}
		}
		if !foundSM {
			return fmt.Errorf("CdkTestStateMachine not found")
		}

		return nil
	})

	// HCL discovery feature
	sc.When(`^I create a session from the "([^"]*)" HCL directory$`, func(dir string) error {
		// Arrange — resolve the testdata directory relative to this test file
		_, filename, _, _ := runtime.Caller(0)
		testdataDir := filepath.Join(filepath.Dir(filename), "..", "lws", "testdata", "terraform-fixture")

		// Act
		sess, err := lws.FromHcl(testdataDir)
		if err != nil {
			return fmt.Errorf("FromHcl: %w", err)
		}

		// Assert (store for later steps)
		discoveredSession = sess
		world.sessionOpen = true
		return nil
	})

	sc.Then(`^the resources declared in the HCL are available$`, func() error {
		// Assert — verify representative resources exist in the discovered session
		if discoveredSession == nil {
			return fmt.Errorf("no discovered session")
		}
		ctx := context.Background()

		// Check DynamoDB table
		_, err := discoveredSession.DynamoDBClient().DescribeTable(ctx, &dynamodb.DescribeTableInput{
			TableName: aws.String("TfTestTable"),
		})
		if err != nil {
			return fmt.Errorf("TfTestTable not found: %w", err)
		}

		// Check SQS queue
		_, err = discoveredSession.SQSClient().GetQueueUrl(ctx, &sqs.GetQueueUrlInput{
			QueueName: aws.String("TfTestQueue"),
		})
		if err != nil {
			return fmt.Errorf("TfTestQueue not found: %w", err)
		}

		// Check S3 bucket
		_, err = discoveredSession.S3Client().HeadBucket(ctx, &s3.HeadBucketInput{
			Bucket: aws.String("tf-test-bucket"),
		})
		if err != nil {
			return fmt.Errorf("tf-test-bucket not found: %w", err)
		}

		// Check SNS topic
		topicsOut, err := discoveredSession.SNSClient().ListTopics(ctx, &sns.ListTopicsInput{})
		if err != nil {
			return fmt.Errorf("ListTopics: %w", err)
		}
		found := false
		for _, t := range topicsOut.Topics {
			if t.TopicArn != nil && len(*t.TopicArn) > 0 {
				found = true
				break
			}
		}
		if !found {
			return fmt.Errorf("no SNS topics found after HCL discovery")
		}

		// Check Step Functions state machine
		smsOut, err := discoveredSession.SFNClient().ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		if err != nil {
			return fmt.Errorf("ListStateMachines: %w", err)
		}
		foundSM := false
		for _, sm := range smsOut.StateMachines {
			if sm.Name != nil && *sm.Name == "TfTestStateMachine" {
				foundSM = true
				break
			}
		}
		if !foundSM {
			return fmt.Errorf("TfTestStateMachine not found")
		}

		return nil
	})
}
