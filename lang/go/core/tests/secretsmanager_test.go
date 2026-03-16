package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/cucumber/godog"
)

func registerSecretsManagerSteps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^a secret "([^"]*)" with value "([^"]*)" exists$`, func(name, value string) error {
		_, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name: aws.String(name), SecretString: aws.String(value),
		})
		return err
	})

	sc.When(`^I create a secret "([^"]*)" with value "([^"]*)"$`, func(name, value string) error {
		result, err := world.SecretsManagerClient().CreateSecret(context.Background(), &secretsmanager.CreateSecretInput{
			Name: aws.String(name), SecretString: aws.String(value),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get the secret value "([^"]*)"$`, func(name string) error {
		result, err := world.SecretsManagerClient().GetSecretValue(context.Background(), &secretsmanager.GetSecretValueInput{SecretId: aws.String(name)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I describe the secret "([^"]*)"$`, func(name string) error {
		result, err := world.SecretsManagerClient().DescribeSecret(context.Background(), &secretsmanager.DescribeSecretInput{SecretId: aws.String(name)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I update the secret "([^"]*)" with value "([^"]*)"$`, func(name, value string) error {
		result, err := world.SecretsManagerClient().UpdateSecret(context.Background(), &secretsmanager.UpdateSecretInput{
			SecretId: aws.String(name), SecretString: aws.String(value),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the secret "([^"]*)"$`, func(name string) error {
		result, err := world.SecretsManagerClient().DeleteSecret(context.Background(), &secretsmanager.DeleteSecretInput{
			SecretId: aws.String(name), ForceDeleteWithoutRecovery: aws.Bool(true),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list secrets$`, func() error {
		result, err := world.SecretsManagerClient().ListSecrets(context.Background(), &secretsmanager.ListSecretsInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I restore the secret "([^"]*)"$`, func(name string) error {
		result, err := world.SecretsManagerClient().RestoreSecret(context.Background(), &secretsmanager.RestoreSecretInput{SecretId: aws.String(name)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the secret "([^"]*)" will have value "([^"]*)"$`, func(name, expectedValue string) error {
		result, err := world.SecretsManagerClient().GetSecretValue(context.Background(), &secretsmanager.GetSecretValueInput{SecretId: aws.String(name)})
		if err != nil {
			return err
		}
		actualValue := aws.ToString(result.SecretString)
		if actualValue != expectedValue {
			return fmt.Errorf("expected secret %q = %q but got %q", name, expectedValue, actualValue)
		}
		return nil
	})

	sc.Then(`^the output will contain secret "([^"]*)"$`, func(name string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), name) {
			return fmt.Errorf("expected output to contain %q but got: %s", name, string(actualOutput))
		}
		return nil
	})

	sc.Then(`^the secret "([^"]*)" will appear in the secret list$`, func(name string) error {
		result, err := world.SecretsManagerClient().ListSecrets(context.Background(), &secretsmanager.ListSecretsInput{})
		if err != nil {
			return err
		}
		for _, s := range result.SecretList {
			if aws.ToString(s.Name) == name {
				return nil
			}
		}
		return fmt.Errorf("secret %q not found in list", name)
	})
}
