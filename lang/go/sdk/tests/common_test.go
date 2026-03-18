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
}
