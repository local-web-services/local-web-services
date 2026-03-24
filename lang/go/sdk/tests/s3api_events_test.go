package tests

// registerS3apiEventsSteps registers step definitions specific to the
// s3api_events cross-service feature file.
//
// Feature: lang/specification/core/informal/s3api_events/sequences.feature
// Safety invariants: DeliveredEventReferencesBusThatExists,
//                    DeliveredEventReferencesObjectThatExists
//
// Precondition steps (bid not in bucket_status, bid in bucket_status,
// busid not in bus_status, busid in bus_status) and shared action steps
// (the EventBridge event bus is deleted) and safety invariant assertions are
// registered centrally in sequences_test.go.

import (
	"context"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	s3types "github.com/aws/aws-sdk-go-v2/service/s3/types"
	"github.com/cucumber/godog"
)

func registerS3apiEventsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — EventBridge notification configuration on S3 bucket
	// -------------------------------------------------------------------------

	sc.Step(`^EventBridge notifications are enabled on the bucket targeting a specific bus$`, func() error {
		if err := s3EvtEnsureBucketAndBus(world); err != nil {
			return err
		}
		_, err := world.S3Client().PutBucketNotificationConfiguration(context.Background(),
			&s3.PutBucketNotificationConfigurationInput{
				Bucket: aws.String(seqBucketName),
				NotificationConfiguration: &s3types.NotificationConfiguration{
					EventBridgeConfiguration: &s3types.EventBridgeConfiguration{},
				},
			})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	// -------------------------------------------------------------------------
	// Action steps — object uploads with event delivery
	// -------------------------------------------------------------------------

	sc.Step(`^an object is uploaded and S3 delivers an event to the EventBridge bus$`, func() error {
		if err := s3EvtEnsureBucketAndBus(world); err != nil {
			return err
		}
		return s3EvtUploadObject(world)
	})

	sc.Step(`^an object is uploaded but event delivery fails because the bus has been deleted$`, func() error {
		// Upload succeeds; delivery failure is silently absorbed.
		if err := s3EvtEnsureBucket(world); err != nil {
			return err
		}
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(seqBusName),
		})
		return s3EvtUploadObject(world)
	})
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func s3EvtEnsureBucket(world *World) error {
	_, err := world.S3Client().CreateBucket(context.Background(), &s3.CreateBucketInput{
		Bucket: aws.String(seqBucketName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}

func s3EvtEnsureBucketAndBus(world *World) error {
	if err := s3EvtEnsureBucket(world); err != nil {
		return err
	}
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(seqBusName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}

func s3EvtUploadObject(world *World) error {
	_, err := world.S3Client().PutObject(context.Background(), &s3.PutObjectInput{
		Bucket: aws.String(seqBucketName),
		Key:    aws.String(seqObjectKey),
		Body:   strings.NewReader("s3-evt-content"),
	})
	return err
}
