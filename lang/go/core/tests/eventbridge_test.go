package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	ebtypes "github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/cucumber/godog"
)

func registerEventBridgeSteps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^an EventBridge bus "([^"]*)" exists$`, func(busName string) error {
		_, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{Name: aws.String(busName)})
		return err
	})

	sc.Given(`^an EventBridge rule "([^"]*)" exists on bus "([^"]*)"$`, func(ruleName, busName string) error {
		_, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(ruleName),
			EventBusName:       aws.String(busName),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		return err
	})

	sc.When(`^I create an EventBridge bus "([^"]*)"$`, func(busName string) error {
		result, err := world.EventBridgeClient().CreateEventBus(context.Background(), &eventbridge.CreateEventBusInput{Name: aws.String(busName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the EventBridge bus "([^"]*)"$`, func(busName string) error {
		result, err := world.EventBridgeClient().DeleteEventBus(context.Background(), &eventbridge.DeleteEventBusInput{Name: aws.String(busName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list EventBridge buses$`, func() error {
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I describe the EventBridge bus "([^"]*)"$`, func(busName string) error {
		result, err := world.EventBridgeClient().DescribeEventBus(context.Background(), &eventbridge.DescribeEventBusInput{Name: aws.String(busName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I put a rule "([^"]*)" on EventBridge bus "([^"]*)"$`, func(ruleName, busName string) error {
		result, err := world.EventBridgeClient().PutRule(context.Background(), &eventbridge.PutRuleInput{
			Name:               aws.String(ruleName),
			EventBusName:       aws.String(busName),
			ScheduleExpression: aws.String("rate(1 day)"),
			State:              ebtypes.RuleStateEnabled,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the EventBridge rule "([^"]*)" on bus "([^"]*)"$`, func(ruleName, busName string) error {
		result, err := world.EventBridgeClient().DeleteRule(context.Background(), &eventbridge.DeleteRuleInput{
			Name: aws.String(ruleName), EventBusName: aws.String(busName),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list EventBridge rules on bus "([^"]*)"$`, func(busName string) error {
		result, err := world.EventBridgeClient().ListRules(context.Background(), &eventbridge.ListRulesInput{EventBusName: aws.String(busName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I put events to EventBridge bus "([^"]*)"$`, func(busName string) error {
		result, err := world.EventBridgeClient().PutEvents(context.Background(), &eventbridge.PutEventsInput{
			Entries: []ebtypes.PutEventsRequestEntry{
				{EventBusName: aws.String(busName), Source: aws.String("test"), DetailType: aws.String("test"), Detail: aws.String("{}")},
			},
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I enable the EventBridge rule "([^"]*)" on bus "([^"]*)"$`, func(ruleName, busName string) error {
		result, err := world.EventBridgeClient().EnableRule(context.Background(), &eventbridge.EnableRuleInput{
			Name: aws.String(ruleName), EventBusName: aws.String(busName),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I disable the EventBridge rule "([^"]*)" on bus "([^"]*)"$`, func(ruleName, busName string) error {
		result, err := world.EventBridgeClient().DisableRule(context.Background(), &eventbridge.DisableRuleInput{
			Name: aws.String(ruleName), EventBusName: aws.String(busName),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the EventBridge bus "([^"]*)" will appear in the bus list$`, func(busName string) error {
		result, err := world.EventBridgeClient().ListEventBuses(context.Background(), &eventbridge.ListEventBusesInput{})
		if err != nil {
			return err
		}
		for _, b := range result.EventBuses {
			if strings.Contains(aws.ToString(b.Name), busName) {
				return nil
			}
		}
		return fmt.Errorf("bus %q not found in list", busName)
	})

	sc.Then(`^the output will contain bus "([^"]*)"$`, func(busName string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), busName) {
			return fmt.Errorf("expected output to contain %q but got: %s", busName, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^the EventBridge rule "([^"]*)" will be enabled$`, func(ruleName string) error {
		result, err := world.EventBridgeClient().DescribeRule(context.Background(), &eventbridge.DescribeRuleInput{
			Name: aws.String(ruleName), EventBusName: aws.String("default"),
		})
		if err != nil {
			return err
		}
		if result.State != ebtypes.RuleStateEnabled {
			return fmt.Errorf("expected rule %q to be ENABLED but got %s", ruleName, result.State)
		}
		return nil
	})

	sc.Then(`^the EventBridge rule "([^"]*)" will be disabled$`, func(ruleName string) error {
		result, err := world.EventBridgeClient().DescribeRule(context.Background(), &eventbridge.DescribeRuleInput{
			Name: aws.String(ruleName), EventBusName: aws.String("default"),
		})
		if err != nil {
			return err
		}
		if result.State != ebtypes.RuleStateDisabled {
			return fmt.Errorf("expected rule %q to be DISABLED but got %s", ruleName, result.State)
		}
		return nil
	})
}
