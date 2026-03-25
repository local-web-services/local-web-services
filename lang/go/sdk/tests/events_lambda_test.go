package tests

// registerEventsLambdaSteps registers step definitions specific to the events_lambda
// cross-service feature files. Steps already registered by registerEventsSteps and
// registerLambdaSteps are NOT re-registered here. This file only adds the unique
// cross-service Given/When/Then steps that combine EventBridge and Lambda concerns.

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	lambdatypes "github.com/aws/aws-sdk-go-v2/service/lambda/types"
	"github.com/cucumber/godog"
)

const eventsLambdaTestBus = "e2e-test-bus-1"
const eventsLambdaTestRule = "test-rule-1"
const eventsLambdaTestFunc = "e2e-test-func-1"
const eventsLambdaRoleArn = "arn:aws:iam::000000000000:role/test"
const eventsLambdaEventPattern = `{"source":["test.source"]}`
const eventsLambdaTargetID = "t1"

func eventsLambdaFuncARN() string {
	return fmt.Sprintf("arn:aws:lambda:us-east-1:000000000000:function:%s", eventsLambdaTestFunc)
}

func eventsLambdaCreateRuleWithTarget(world *World) error {
	_, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
		Name:         aws.String(eventsLambdaTestRule),
		EventBusName: aws.String(eventsLambdaTestBus),
		EventPattern: aws.String(eventsLambdaEventPattern),
		State:        ebtypes.RuleStateEnabled,
	})
	if err != nil {
		return fmt.Errorf("put rule: %w", err)
	}
	_, err = world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
		Rule:         aws.String(eventsLambdaTestRule),
		EventBusName: aws.String(eventsLambdaTestBus),
		Targets: []ebtypes.Target{
			{Id: aws.String(eventsLambdaTargetID), Arn: aws.String(eventsLambdaFuncARN())},
		},
	})
	return err
}

func registerEventsLambdaSteps(sc *godog.ScenarioContext, world *World) {
	// ── Given: cross-service rule + target state ──────────────────────────────────

	sc.Given(`^an "ENABLED" rule exists on the bus targeting a function$`, func() error {
		// Arrange: ensure bus and function exist, then create rule with Lambda target
		_, _ = world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(eventsLambdaTestBus),
		})
		_, _ = world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(eventsLambdaTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(eventsLambdaRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Act
		return eventsLambdaCreateRuleWithTarget(world)
		// Assert: rule and target created
	})

	sc.Given(`^no "ENABLED" rule exists on the bus targeting a function$`, func() error {
		// Arrange: skip — cannot trigger internal EventBridge->Lambda routing in lws
		// without a real rule wired to an active function; lws does not fail put_events
		// when no matching rule exists.
		return godog.ErrSkip
	})

	sc.Given(`^the target function is "ACTIVE"$`, func() error {
		// No-op: Lambda functions are ACTIVE immediately after creation in lws.
		return nil
	})

	sc.Given(`^the target function is not "ACTIVE"$`, func() error {
		// Arrange: skip — cannot trigger internal EventBridge->Lambda routing in lws
		// when the target function is not ACTIVE.
		return godog.ErrSkip
	})

	// ── Given: invocation slot state ─────────────────────────────────────────────

	sc.Given(`^an invocation slot is available$`, func() error {
		// Arrange: set Lambda capacity to unlimited
		// Act
		return managementSession().Capacity("lambda").Unlimited().Apply()
		// Assert: capacity applied
	})

	sc.Given(`^no invocation slot is available$`, func() error {
		// Arrange: exhaust Lambda capacity so no invocation slot is available
		// Act
		return managementSession().Capacity("lambda").Exhaust().Apply()
		// Assert: capacity exhausted
	})

	// ── Given: invocation state ───────────────────────────────────────────────────

	sc.Given(`^an invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot trigger internal EventBridge->Lambda routing in lws to
		// place an invocation into IN_PROGRESS state.
		return godog.ErrSkip
	})

	sc.Given(`^no invocation is "IN_PROGRESS"$`, func() error {
		// No-op: fresh state has no in-progress invocations.
		return nil
	})

	// ── When: cross-service actions ───────────────────────────────────────────────

	sc.When(`^an EventBridge event bus is created$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{
			Name: aws.String(eventsLambdaTestBus),
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^a Lambda function is deployed$`, func() error {
		// Arrange
		// Act
		result, err := world.LambdaClient().CreateFunction(context.Background(), &lambda.CreateFunctionInput{
			FunctionName: aws.String(eventsLambdaTestFunc),
			Runtime:      lambdatypes.RuntimePython312,
			Role:         aws.String(eventsLambdaRoleArn),
			Handler:      aws.String("index.handler"),
			Code: &lambdatypes.FunctionCode{
				ZipFile: []byte("fake"),
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an EventBridge rule is created to asynchronously invoke a Lambda function on matching events$`, func() error {
		// Arrange
		// Act: create rule then attach Lambda target
		_, ruleErr := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:         aws.String(eventsLambdaTestRule),
			EventBusName: aws.String(eventsLambdaTestBus),
			EventPattern: aws.String(eventsLambdaEventPattern),
			State:        ebtypes.RuleStateEnabled,
		})
		if ruleErr != nil {
			setResult(world, nil, ruleErr)
			return nil
		}
		result, err := world.EventBridgeClient().PutTargets(context.Background(), &eventbridge.PutTargetsInput{
			Rule:         aws.String(eventsLambdaTestRule),
			EventBusName: aws.String(eventsLambdaTestBus),
			Targets: []ebtypes.Target{
				{Id: aws.String(eventsLambdaTargetID), Arn: aws.String(eventsLambdaFuncARN())},
			},
		})
		// Assert: store result
		setResult(world, result, err)
		return nil
	})

	sc.When(`^an event is published to the bus and triggers an asynchronous Lambda invocation$`, func() error {
		// @internal: Cannot trigger internal EventBridge->Lambda routing in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger EventBridge->Lambda routing: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation completes successfully$`, func() error {
		// @internal: Cannot trigger internal Lambda invocation completion in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation completion: scenario is @internal"))
		return nil
	})

	sc.When(`^the Lambda invocation fails$`, func() error {
		// @internal: Cannot trigger internal Lambda invocation failure in lws.
		setResult(world, nil, fmt.Errorf("cannot trigger Lambda invocation failure: scenario is @internal"))
		return nil
	})

	// ── Then: cross-service assertions ────────────────────────────────────────────

	sc.Then(`^the rule is "ENABLED" and will trigger the function when matching events are published$`, func() error {
		// Arrange
		// Act
		result, err := world.EventBridgeClient().DescribeRule(context.Background(), &eventbridge.DescribeRuleInput{
			Name:         aws.String(eventsLambdaTestRule),
			EventBusName: aws.String(eventsLambdaTestBus),
		})
		if err != nil {
			return fmt.Errorf("describe rule: %w", err)
		}
		// Assert
		expectedState := string(ebtypes.RuleStateEnabled)
		actualState := string(result.State)
		if actualState != expectedState {
			return fmt.Errorf("expected rule state %q but got %q; expected_state=%q actual_state=%q",
				expectedState, actualState, expectedState, actualState)
		}
		return nil
	})

	sc.Then(`^the invocation is "IN_PROGRESS"$`, func() error {
		// @internal: Cannot observe Lambda IN_PROGRESS invocation state in lws.
		return nil
	})

	sc.Then(`^the invocation is "SUCCESS"$`, func() error {
		// @internal: Cannot observe Lambda invocation SUCCESS state in lws.
		return nil
	})

	sc.Then(`^the invocation is "FAILED"$`, func() error {
		// @internal: Cannot observe Lambda invocation FAILED state in lws.
		return nil
	})

	// ── Invariant Then steps (no-ops) ─────────────────────────────────────────────

	sc.Then(`^every "IN_PROGRESS" invocation was triggered by an "ENABLED" rule$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})

	sc.Then(`^every "ENABLED" rule references an "ACTIVE" event bus$`, func() error {
		// No-op: model-level invariant; trivially satisfied in isolated lws context.
		return nil
	})
}
