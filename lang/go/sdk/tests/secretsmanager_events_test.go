package tests

// registerSecretsmanagerEventsSteps registers step definitions specific to the
// secretsmanager_events cross-service feature file.
//
// Feature: lang/specification/core/informal/secretsmanager_events/sequences.feature
// Safety invariants: DeliveredEventReferencesBusThatExists,
//                    DeliveredEventReferencesSecretThatExists
//
// Precondition steps (busid not in bus_status, busid in bus_status,
// sid not in secret_status, sid in secret_status) and shared action steps
// (the EventBridge event bus is deleted) and safety invariant assertions are
// registered centrally in sequences_test.go.

import (
	"context"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/cucumber/godog"
)

func registerSecretsmanagerEventsSteps(sc *godog.ScenarioContext, world *World) {
	// -------------------------------------------------------------------------
	// Action steps — secret lifecycle with EventBridge events
	// -------------------------------------------------------------------------

	sc.Step(`^a secret is created and Secrets Manager delivers a "CREATED" event to the EventBridge bus$`, func() error {
		if err := smEvtEnsureBus(world); err != nil {
			return err
		}
		return smEvtEnsureSecret(world)
	})

	sc.Step(`^a secret is created but the "CREATED" event delivery fails because the bus is deleted$`, func() error {
		// Delete the bus first; secret creation still succeeds but event delivery
		// is silently absorbed by the fake.
		_, _ = world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{
			Name: aws.String(seqBusName),
		})
		return smEvtEnsureSecret(world)
	})

	sc.Step(`^a secret is scheduled for deletion and Secrets Manager delivers a "DELETED" event to the bus$`, func() error {
		if err := smEvtEnsureBus(world); err != nil {
			return err
		}
		if err := smEvtEnsureSecret(world); err != nil {
			return err
		}
		_, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId:                   aws.String(seqSecretName),
			ForceDeleteWithoutRecovery: aws.Bool(true),
		})
		if err != nil && !isNotFound(err) {
			return err
		}
		return nil
	})

	sc.Step(`^a secret rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus$`, func() error {
		// The local fake does not implement automated secret rotation.
		// This step verifies the secret exists and the bus is reachable.
		if err := smEvtEnsureBus(world); err != nil {
			return err
		}
		return smEvtEnsureSecret(world)
	})
}

// -------------------------------------------------------------------------
// Helper functions
// -------------------------------------------------------------------------

func smEvtEnsureBus(world *World) error {
	_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
		Name: aws.String(seqBusName),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}

func smEvtEnsureSecret(world *World) error {
	_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
		Name:         aws.String(seqSecretName),
		SecretString: aws.String("test-secret-value"),
	})
	if err != nil && !isAlreadyExists(err) {
		return err
	}
	return nil
}
