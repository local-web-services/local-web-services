package tests

import (
	"github.com/cucumber/godog"
)

func registerAllSteps(sc *godog.ScenarioContext, world *World) {
	registerSessionSteps(sc, world)
	registerResourceSteps(sc, world)
	registerClientSteps(sc, world)
	registerChaosSteps(sc, world)
	registerFakeSteps(sc, world)
	registerIAMSteps(sc, world)
	registerLogsSteps(sc, world)
	registerDynamoDBHelperSteps(sc, world)
	registerSQSHelperSteps(sc, world)
	registerDiscoverySteps(sc, world)
	registerSequenceSteps(sc, world)
	// Cross-service suites — suite-specific steps
	registerSnsSqsSteps(sc, world)
	registerEventsSqsSteps(sc, world)
	registerEventsSnsSteps(sc, world)
	registerEventsDynamodbSteps(sc, world)
	registerEventsStepfunctionsSteps(sc, world)
	registerStepfunctionsSqsSteps(sc, world)
	registerStepfunctionsDynamodbSteps(sc, world)
	registerStepfunctionsSnsSteps(sc, world)
	registerStepfunctionsS3apiSteps(sc, world)
	registerStepfunctionsSecretsmanagerSteps(sc, world)
	registerStepfunctionsSsmSteps(sc, world)
	registerStepfunctionsEventsSteps(sc, world)
	registerS3apiSnsSteps(sc, world)
	registerS3apiSqsSteps(sc, world)
	registerS3apiEventsSteps(sc, world)
	registerSecretsmanagerEventsSteps(sc, world)
	registerSsmEventsSteps(sc, world)
}
