package tests

import (
	"github.com/cucumber/godog"
	core "github.com/local-web-services/local-web-services-go-core/lws"
	"github.com/local-web-services/local-web-services-go-sdk/lws"
)

func registerIAMSteps(sc *godog.ScenarioContext, world *World) {
	// Given IAM is in enforce mode with identity "test-user" allowed all "states:*" actions
	sc.Given(`^IAM is in enforce mode with identity "([^"]*)" allowed all "([^"]*)" actions$`, func(identity, actions string) error {
		sess := managementSession()
		return sess.Iam().
			Mode("enforce").
			DefaultIdentity(identity).
			Identity(identity).
			Allow([]string{actions}, "*").
			Apply().
			Apply()
	})

	// Given IAM is in enforce mode with identity "test-user" and no permissions
	sc.Given(`^IAM is in enforce mode with identity "([^"]*)" and no permissions$`, func(identity string) error {
		sess := managementSession()
		return sess.Iam().
			Mode("enforce").
			DefaultIdentity(identity).
			Identity(identity).
			Apply().
			Apply()
	})

	// Given a running session with IAM enforce mode active
	sc.Given(`^a running session with IAM enforce mode active$`, func() error {
		world.sessionOpen = true
		// Register a dummy identity in enforce mode
		return core.IamSet(world.managementPort, "all", "enforce")
	})

	// When I set IAM mode to "disabled"
	sc.When(`^I set IAM mode to "([^"]*)"$`, func(mode string) error {
		sess := managementSession()
		return sess.Iam().Mode(mode).Apply()
	})
}

// ensure lws is used
var _ *lws.IamBuilder
