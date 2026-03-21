package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"
	"github.com/cucumber/godog"
)

func registerSSMSteps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^an SSM parameter "([^"]*)" with value "([^"]*)" exists$`, func(name, value string) error {
		_, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:  aws.String(name),
			Value: aws.String(value),
			Type:  ssmtypes.ParameterTypeString,
		})
		return err
	})

	sc.When(`^I put an SSM parameter "([^"]*)" with value "([^"]*)"$`, func(name, value string) error {
		result, err := world.SSMClient().PutParameter(context.Background(), &ssm.PutParameterInput{
			Name:      aws.String(name),
			Value:     aws.String(value),
			Type:      ssmtypes.ParameterTypeString,
			Overwrite: aws.Bool(true),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get the SSM parameter "([^"]*)"$`, func(name string) error {
		result, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{Name: aws.String(name)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get SSM parameters "([^"]*)"$`, func(namesJSON string) error {
		var names []string
		json.Unmarshal([]byte(namesJSON), &names)
		result, err := world.SSMClient().GetParameters(context.Background(), &ssm.GetParametersInput{Names: names})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get SSM parameters by path "([^"]*)"$`, func(path string) error {
		result, err := world.SSMClient().GetParametersByPath(context.Background(), &ssm.GetParametersByPathInput{Path: aws.String(path)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the SSM parameter "([^"]*)"$`, func(name string) error {
		result, err := world.SSMClient().DeleteParameter(context.Background(), &ssm.DeleteParameterInput{Name: aws.String(name)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I describe SSM parameters$`, func() error {
		result, err := world.SSMClient().DescribeParameters(context.Background(), &ssm.DescribeParametersInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the SSM parameter "([^"]*)" will have value "([^"]*)"$`, func(name, expectedValue string) error {
		result, err := world.SSMClient().GetParameter(context.Background(), &ssm.GetParameterInput{Name: aws.String(name)})
		if err != nil {
			return err
		}
		actualValue := aws.ToString(result.Parameter.Value)
		if actualValue != expectedValue {
			return fmt.Errorf("expected parameter %q = %q but got %q", name, expectedValue, actualValue)
		}
		return nil
	})

	sc.Then(`^the output will contain parameter "([^"]*)"$`, func(name string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), name) {
			return fmt.Errorf("expected output to contain %q but got: %s", name, string(actualOutput))
		}
		return nil
	})
}
