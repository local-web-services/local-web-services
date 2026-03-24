package tests

// registerSnsSqsSteps registers step definitions specific to the sns_sqs
// cross-service feature file. All action and precondition steps for this
// suite are generic and already registered by registerSequenceSteps.
// This file exists to document suite ownership; no unique steps are needed.

import (
	"github.com/cucumber/godog"
)

func registerSnsSqsSteps(sc *godog.ScenarioContext, _ *World) {
	// All steps required by
	// lang/specification/core/informal/sns_sqs/sequences.feature
	// are already registered in sequences_test.go via registerSequenceSteps.
	_ = sc
}
