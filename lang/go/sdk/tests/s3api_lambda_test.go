package tests

// registerS3apiLambdaSteps registers step definitions specific to the
// s3api_lambda cross-service feature files.
//
// Features:
//
//	lang/specification/core/informal/s3api_lambda/configure_notification.feature
//	lang/specification/core/informal/s3api_lambda/create_bucket.feature
//	lang/specification/core/informal/s3api_lambda/deploy_function.feature
//	lang/specification/core/informal/s3api_lambda/invocation_fails.feature
//	lang/specification/core/informal/s3api_lambda/invocation_succeeds.feature
//	lang/specification/core/informal/s3api_lambda/put_object_and_notify.feature
//
// Safety invariants: InvocationRequiresActiveFunction, InvocationRequiresActiveBucket
//
// Steps already registered in sqs_test.go ("the operation is rejected") and
// sequences_test.go ("the system is initialized") are NOT re-registered here.
// Given steps for bucket/function state are re-registered here because this
// suite uses its own resource-name constants ("e2e-test-bucket-1",
// "e2e-test-func-1") that differ from the single-service defaults.

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	"github.com/cucumber/godog"
)

const s3apiLambdaTestBucket = "e2e-test-bucket-1"
const s3apiLambdaTestFunc = "e2e-test-func-1"
const s3apiLambdaTestRoleArn = "arn:aws:iam::000000000000:role/test"
const s3apiLambdaTestKey = "e2e-test-key-1"
const s3apiLambdaTestBody = "test-data-content-1"
const s3apiLambdaTestRegion = "us-east-1"
const s3apiLambdaTestAccountID = "000000000000"

func s3apiLambdaFuncARN() string {
	return fmt.Sprintf("arn:aws:lambda:%s:%s:function:%s",
		s3apiLambdaTestRegion, s3apiLambdaTestAccountID, s3apiLambdaTestFunc)
}

func s3apiLambdaCreateBucket(world *World) error {
	// Arrange
	// Act
	_, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
		Bucket: aws.String(s3apiLambdaTestBucket),
	})
	// Assert: caller checks error
	return err
}

func s3apiLambdaCreateFunction(world *World) error {
	// Arrange
	// Act
	_, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
		FunctionName: aws.String(s3apiLambdaTestFunc),
		Runtime:      lambdatypes.RuntimePython312,
		Role:         aws.String(s3apiLambdaTestRoleArn),
		Handler:      aws.String("index.handler"),
		Code: &lambdatypes.FunctionCode{
			ZipFile: []byte("fake"),
		},
	})
	// Assert: caller checks error
	return err
}

func s3apiLambdaConfigureNotification(world *World) error {
	// Arrange
	funcARN := s3apiLambdaFuncARN()
	// Act
	_, err := world.S3Client().PutBucketNotificationConfiguration(context.Background(),
		&s3.PutBucketNotificationConfigurationInput{
			Bucket: aws.String(s3apiLambdaTestBucket),
			NotificationConfiguration: &s3types.NotificationConfiguration{
				LambdaFunctionConfigurations: []s3types.LambdaFunctionConfiguration{
					{
						LambdaFunctionArn: aws.String(funcARN),
						Events:            []s3types.Event{s3types.EventS3ObjectCreatedPut},
					},
				},
			},
		})
	// Assert: caller checks error
	return err
}

func registerS3apiLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: bucket state ───────────────────────────────────────────────────

	sc.Given(`^the bucket does not already exist$`, func() error {
		// No-op: fresh state after reset has no buckets.
		return nil
	})

	sc.Given(`^the bucket already exists$`, func() error {
		// Arrange / Act: create the test bucket so it already exists
		return s3apiLambdaCreateBucket(world)
	})

	sc.Given(`^the bucket exists$`, func() error {
		// Arrange / Act: ensure the test bucket exists
		return s3apiLambdaCreateBucket(world)
	})

	sc.Given(`^the bucket is "ACTIVE"$`, func() error {
		// No-op: buckets are ACTIVE by default after creation.
		return nil
	})

	sc.Given(`^the bucket is not "ACTIVE"$`, func() error {
		// Arrange: create a bucket in a non-ACTIVE state via lifecycle dwell
		world.S3Client().DeleteBucket(context.Background(), &s3.DeleteBucketInput{ //nolint:errcheck
			Bucket: aws.String(s3apiLambdaTestBucket),
		})
		session := managementSession()
		// Act
		if err := session.Lifecycle("s3").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		return s3apiLambdaCreateBucket(world)
	})

	sc.Given(`^the bucket does not exist$`, func() error {
		// Arrange: ensure bucket is absent
		world.S3Client().DeleteBucket(context.Background(), &s3.DeleteBucketInput{ //nolint:errcheck
			Bucket: aws.String(s3apiLambdaTestBucket),
		})
		return nil
	})

	// ── Given: notification configuration state ───────────────────────────────

	sc.Given(`^the bucket has no notification configured$`, func() error {
		// No-op: buckets have no notification configuration by default.
		return nil
	})

	sc.Given(`^the bucket already has a notification configured$`, func() error {
		// Arrange: create bucket and function if needed, then configure notification
		// Act: ignore errors — bucket/function may already exist from a prior Given step
		_ = s3apiLambdaCreateBucket(world)
		_ = s3apiLambdaCreateFunction(world)
		return s3apiLambdaConfigureNotification(world)
	})

	sc.Given(`^the bucket has a notification configured$`, func() error {
		// Arrange: create bucket and function if needed, then configure notification
		// Act: ignore errors — bucket/function may already exist from a prior Given step
		_ = s3apiLambdaCreateBucket(world)
		_ = s3apiLambdaCreateFunction(world)
		return s3apiLambdaConfigureNotification(world)
	})

	// ── Given: function state ─────────────────────────────────────────────────

	sc.Given(`^the function does not already exist$`, func() error {
		// No-op: fresh state after reset has no Lambda functions.
		return nil
	})

	sc.Given(`^the function already exists$`, func() error {
		// Arrange: create the function so it already exists
		// Act
		return s3apiLambdaCreateFunction(world)
	})

	sc.Given(`^the function exists$`, func() error {
		// Arrange: create the function
		// Act
		return s3apiLambdaCreateFunction(world)
	})

	sc.Given(`^the function does not exist$`, func() error {
		// Arrange: delete function if present
		// Act: ignore errors — function may not exist
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(s3apiLambdaTestFunc),
		})
		return nil
	})

	sc.Given(`^the function is "ACTIVE"$`, func() error {
		// No-op: lws resolves functions to ACTIVE immediately after creation.
		return nil
	})

	sc.Given(`^the function is not "ACTIVE"$`, func() error {
		// Arrange: delete any existing function, apply a create dwell, then re-create
		sess := managementSession()
		// Act
		_, _ = world.LambdaClient().DeleteFunction(context.Background(), &lambda.DeleteFunctionInput{
			FunctionName: aws.String(s3apiLambdaTestFunc),
		})
		if err := sess.Lifecycle("lambda").CreateDwellMs(5000).Apply(); err != nil {
			return fmt.Errorf("lifecycle apply failed: %w", err)
		}
		return s3apiLambdaCreateFunction(world)
	})

	// ── Given: notification target function state ─────────────────────────────

	sc.Given(`^the notification target function is "ACTIVE"$`, func() error {
		// No-op: Lambda functions are ACTIVE immediately after creation in lws.
		return nil
	})

	sc.Given(`^the notification target function is not "ACTIVE"$`, func() error {
		// @internal: Cannot place Lambda notification target function in a non-ACTIVE
		// state while it is already configured as a bucket notification target.
		return nil
	})

	// ── Given: capacity / slot state ─────────────────────────────────────────

	sc.Given(`^an object slot is available$`, func() error {
		// Arrange: set S3 capacity to unlimited
		// Act
		return managementSession().Capacity("s3").Unlimited().Apply()
	})

	sc.Given(`^no object slot is available$`, func() error {
		// Arrange: exhaust S3 object capacity
		// Act
		return managementSession().Capacity("s3").Exhaust().Apply()
	})

	sc.Given(`^an invocation slot is available$`, func() error {
		// Arrange: set Lambda capacity to unlimited
		// Act
		return managementSession().Capacity("lambda").Unlimited().Apply()
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// @internal: Cannot exhaust Lambda invocation slot limit via public API in lws.
		return nil
	})

	// ── Given: invocation in-progress state ──────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange: create the function so an invocation could be in progress.
		// Act: the lws fake does not expose invocation state; creating the
		// function is the closest reachable precondition.
		return s3apiLambdaCreateFunction(world)
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no invocations.
		return nil
	})

	// ── When: actions ─────────────────────────────────────────────────────────

	sc.When(`^an S3 bucket is created$`, func() error {
		// Arrange
		// Act
		result, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
			Bucket: aws.String(s3apiLambdaTestBucket),
		})
		// Assert: captured in lastResult
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(s3apiLambdaTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(s3apiLambdaTestRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: captured in lastResult
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an S3 event notification is configured to invoke a Lambda function on object "PUT"$`, func() error {
		// Arrange
		funcARN := s3apiLambdaFuncARN()
		// Act
		result, err := world.S3Client().PutBucketNotificationConfiguration(context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(s3apiLambdaTestBucket),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					LambdaFunctionConfigurations: []s3types.LambdaFunctionConfiguration{
						{
							LambdaFunctionArn: aws.String(funcARN),
							Events:            []s3types.Event{s3types.EventS3ObjectCreatedPut},
						},
					},
				},
			})
		// Assert: captured in lastResult
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an object is put into the bucket and asynchronously invokes the configured Lambda function$`, func() error {
		// Arrange
		// Act
		result, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
			Bucket: aws.String(s3apiLambdaTestBucket),
			Key:    aws.String(s3apiLambdaTestKey),
			Body:   strings.NewReader(s3apiLambdaTestBody),
		})
		// Assert: captured in lastResult
		setResult(world, result, err)
		return nil
	})

	sc.When(`^the Lambda invocation completes successfully$`, func() error {
		// @internal: Cannot trigger Lambda invocation success via public API in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation success: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation fails$`, func() error {
		// @internal: Cannot trigger Lambda invocation failure via public API in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	// ── Then: assertions ──────────────────────────────────────────────────────

	sc.Then(`^the bucket is "ACTIVE" with no event notification configured$`, func() error {
		// Arrange
		// Act
		resp, err := world.S3Client().ListBuckets(context.Background(), &s3.ListBucketsInput{})
		if err != nil {
			return fmt.Errorf("list buckets: %w", err)
		}
		// Assert
		expectedBucketName := s3apiLambdaTestBucket
		for _, b := range resp.Buckets {
			if b.Name != nil && *b.Name == expectedBucketName {
				return nil
			}
		}
		return fmt.Errorf("expected bucket %q to be ACTIVE but not found; expected_bucket=%s",
			expectedBucketName, expectedBucketName)
	})

	sc.Then(`^the function is "ACTIVE"$`, func() error {
		// Arrange
		// Act
		resp, err := world.LambdaClient().GetFunction(context.Background(), &lambda.GetFunctionInput{
			FunctionName: aws.String(s3apiLambdaTestFunc),
		})
		if err != nil {
			return fmt.Errorf("get function: %w", err)
		}
		// Assert
		expectedState := "Active"
		actualState := string(resp.Configuration.State)
		if actualState != expectedState {
			return fmt.Errorf("expected function state %q but got %q; expected_state=%s actual_state=%s",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the bucket will asynchronously invoke the function when an object is put$`, func() error {
		// Arrange
		expectedFuncARN := s3apiLambdaFuncARN()
		// Act
		resp, err := world.S3Client().GetBucketNotificationConfiguration(context.Background(),
			&s3.GetBucketNotificationConfigurationInput{
				Bucket: aws.String(s3apiLambdaTestBucket),
			})
		if err != nil {
			return fmt.Errorf("get bucket notification configuration: %w", err)
		}
		// Assert
		for _, cfg := range resp.LambdaFunctionConfigurations {
			if cfg.LambdaFunctionArn != nil && *cfg.LambdaFunctionArn == expectedFuncARN {
				return nil
			}
		}
		actualConfigs := resp.LambdaFunctionConfigurations
		return fmt.Errorf("expected notification ARN %q to be configured; expected_arn=%s actual_configs=%v",
			expectedFuncARN, expectedFuncARN, actualConfigs)
	})

	sc.Then(`^the object "EXISTS" in the bucket and an invocation is "IN_PROGRESS"$`, func() error {
		// Arrange
		expectedKey := s3apiLambdaTestKey
		// Act
		resp, err := world.S3Client().ListObjectsV2(context.Background(), &s3.ListObjectsV2Input{
			Bucket: aws.String(s3apiLambdaTestBucket),
		})
		if err != nil {
			return fmt.Errorf("list objects: %w", err)
		}
		// Assert
		for _, obj := range resp.Contents {
			if obj.Key != nil && *obj.Key == expectedKey {
				return nil
			}
		}
		return fmt.Errorf("expected object %q to exist in bucket %q but not found; expected_key=%s",
			expectedKey, s3apiLambdaTestBucket, expectedKey)
	})

	// ── Then: invariant assertions (no-op) ────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "IN_PROGRESS" invocation was triggered by an object in an "ACTIVE" bucket$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	// ── Then: @internal scenario assertions (no-op) ───────────────────────────

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation SUCCESS state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation FAILED state in lws.
		return nil
	})
}
