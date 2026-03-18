package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/cucumber/godog"
)

const passStateMachineDefinition = `{"StartAt":"Pass","States":{"Pass":{"Type":"Pass","End":true}}}`

func registerStepFunctionsSteps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^a state machine "([^"]*)" exists$`, func(smName string) error {
		result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
			Name:       aws.String(smName),
			Definition: aws.String(passStateMachineDefinition),
			RoleArn:    aws.String("arn:aws:iam::000000000000:role/StepFunctionsRole"),
			Type:       "STANDARD",
		})
		if err != nil {
			return err
		}
		world.lastStateMachineArn = aws.ToString(result.StateMachineArn)
		return nil
	})

	sc.Given(`^an execution has been started for state machine "([^"]*)"$`, func(_ string) error {
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(world.lastStateMachineArn),
			Input:           aws.String("{}"),
		})
		if err != nil {
			return err
		}
		world.lastExecutionArn = aws.ToString(result.ExecutionArn)
		return nil
	})

	sc.When(`^I create a state machine "([^"]*)"$`, func(smName string) error {
		result, err := world.SFNClient().CreateStateMachine(context.Background(), &sfn.CreateStateMachineInput{
			Name:       aws.String(smName),
			Definition: aws.String(passStateMachineDefinition),
			RoleArn:    aws.String("arn:aws:iam::000000000000:role/StepFunctionsRole"),
			Type:       "STANDARD",
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastStateMachineArn = aws.ToString(result.StateMachineArn)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the state machine "([^"]*)"$`, func(smArn string) error {
		result, err := world.SFNClient().DeleteStateMachine(context.Background(), &sfn.DeleteStateMachineInput{StateMachineArn: aws.String(smArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list state machines$`, func() error {
		result, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I describe the state machine "([^"]*)"$`, func(smArn string) error {
		result, err := world.SFNClient().DescribeStateMachine(context.Background(), &sfn.DescribeStateMachineInput{StateMachineArn: aws.String(smArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I start an execution of state machine "([^"]*)" with input "([^"]*)"$`, func(smArn, input string) error {
		result, err := world.SFNClient().StartExecution(context.Background(), &sfn.StartExecutionInput{
			StateMachineArn: aws.String(smArn), Input: aws.String(input),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastExecutionArn = aws.ToString(result.ExecutionArn)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I describe the last execution$`, func() error {
		result, err := world.SFNClient().DescribeExecution(context.Background(), &sfn.DescribeExecutionInput{ExecutionArn: aws.String(world.lastExecutionArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list executions for state machine "([^"]*)"$`, func(smArn string) error {
		result, err := world.SFNClient().ListExecutions(context.Background(), &sfn.ListExecutionsInput{StateMachineArn: aws.String(smArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I stop the last execution$`, func() error {
		result, err := world.SFNClient().StopExecution(context.Background(), &sfn.StopExecutionInput{ExecutionArn: aws.String(world.lastExecutionArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I validate state machine definition "([^"]*)"$`, func(_ string) error {
		result, err := world.SFNClient().ValidateStateMachineDefinition(context.Background(), &sfn.ValidateStateMachineDefinitionInput{
			Definition: aws.String(passStateMachineDefinition),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the state machine "([^"]*)" will appear in the state machine list$`, func(smName string) error {
		result, err := world.SFNClient().ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
		if err != nil {
			return err
		}
		for _, sm := range result.StateMachines {
			if aws.ToString(sm.Name) == smName || strings.Contains(aws.ToString(sm.StateMachineArn), smName) {
				return nil
			}
		}
		return fmt.Errorf("state machine %q not found", smName)
	})

	sc.Then(`^the output will contain state machine "([^"]*)"$`, func(smName string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), smName) {
			return fmt.Errorf("expected output to contain %q but got: %s", smName, string(actualOutput))
		}
		return nil
	})
}
