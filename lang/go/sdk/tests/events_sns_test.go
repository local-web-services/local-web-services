package tests

// registerEventsSnsSteps registers step definitions specific to the events_sns
// cross-service feature file. All action and precondition steps for this
// suite are generic and already registered by registerSequenceSteps.
// This file exists to document suite ownership; no unique steps are needed.

import (
	"github.com/cucumber/godog"
)

func registerEventsSnsSteps(sc *godog.ScenarioContext, _ *World) {
	// All steps required by
	// lang/specification/core/informal/events_sns/sequences.feature
	// are already registered in sequences_test.go via registerSequenceSteps.
	_ = sc
}
