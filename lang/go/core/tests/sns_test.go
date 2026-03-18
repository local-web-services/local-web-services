package tests

import (
	"context"
	"encoding/json"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	snstypes "github.com/aws/aws-sdk-go-v2/service/sns/types"
	"github.com/cucumber/godog"
)

func registerSNSSteps(sc *godog.ScenarioContext, world *World) {
	sc.Given(`^an SNS topic "([^"]*)" exists$`, func(topicName string) error {
		result, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{Name: aws.String(topicName)})
		if err != nil {
			return err
		}
		world.lastTopicArn = aws.ToString(result.TopicArn)
		return nil
	})

	sc.When(`^I create an SNS topic "([^"]*)"$`, func(topicName string) error {
		result, err := world.SNSClient().CreateTopic(context.Background(), &sns.CreateTopicInput{Name: aws.String(topicName)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastTopicArn = aws.ToString(result.TopicArn)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I delete the SNS topic "([^"]*)"$`, func(topicArn string) error {
		result, err := world.SNSClient().DeleteTopic(context.Background(), &sns.DeleteTopicInput{TopicArn: aws.String(topicArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list SNS topics$`, func() error {
		result, err := world.SNSClient().ListTopics(context.Background(), &sns.ListTopicsInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I publish message "([^"]*)" to SNS topic "([^"]*)"$`, func(message, topicArn string) error {
		result, err := world.SNSClient().Publish(context.Background(), &sns.PublishInput{
			TopicArn: aws.String(topicArn), Message: aws.String(message),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I subscribe to SNS topic "([^"]*)" with protocol "([^"]*)" and endpoint "([^"]*)"$`, func(topicArn, protocol, endpoint string) error {
		result, err := world.SNSClient().Subscribe(context.Background(), &sns.SubscribeInput{
			TopicArn: aws.String(topicArn), Protocol: aws.String(protocol), Endpoint: aws.String(endpoint),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastSubscriptionArn = aws.ToString(result.SubscriptionArn)
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list SNS subscriptions$`, func() error {
		result, err := world.SNSClient().ListSubscriptions(context.Background(), &sns.ListSubscriptionsInput{})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list SNS subscriptions by topic "([^"]*)"$`, func(topicArn string) error {
		result, err := world.SNSClient().ListSubscriptionsByTopic(context.Background(), &sns.ListSubscriptionsByTopicInput{TopicArn: aws.String(topicArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I get SNS topic attributes for "([^"]*)"$`, func(topicArn string) error {
		result, err := world.SNSClient().GetTopicAttributes(context.Background(), &sns.GetTopicAttributesInput{TopicArn: aws.String(topicArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I set SNS topic attributes for "([^"]*)"$`, func(topicArn string) error {
		result, err := world.SNSClient().SetTopicAttributes(context.Background(), &sns.SetTopicAttributesInput{
			TopicArn: aws.String(topicArn), AttributeName: aws.String("DisplayName"), AttributeValue: aws.String("test"),
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I tag SNS resource "([^"]*)" with tags "([^"]*)"$`, func(resourceArn, tagsJSON string) error {
		var rawTags []struct {
			Key   string `json:"Key"`
			Value string `json:"Value"`
		}
		json.Unmarshal([]byte(tagsJSON), &rawTags)
		var tags []snstypes.Tag
		for _, t := range rawTags {
			k, v := t.Key, t.Value
			tags = append(tags, snstypes.Tag{Key: &k, Value: &v})
		}
		result, err := world.SNSClient().TagResource(context.Background(), &sns.TagResourceInput{
			ResourceArn: aws.String(resourceArn), Tags: tags,
		})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	sc.When(`^I list SNS tags for resource "([^"]*)"$`, func(resourceArn string) error {
		result, err := world.SNSClient().ListTagsForResource(context.Background(), &sns.ListTagsForResourceInput{ResourceArn: aws.String(resourceArn)})
		if err != nil {
			world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
		} else {
			world.lastResult = LastResult{Success: true, Output: result}
		}
		return nil
	})

	// Then
	sc.Then(`^the SNS topic "([^"]*)" will appear in the topic list$`, func(topicName string) error {
		result, err := world.SNSClient().ListTopics(context.Background(), &sns.ListTopicsInput{})
		if err != nil {
			return err
		}
		for _, t := range result.Topics {
			if strings.Contains(aws.ToString(t.TopicArn), topicName) {
				return nil
			}
		}
		return fmt.Errorf("topic %q not found in list", topicName)
	})

	sc.Then(`^the output will contain topic "([^"]*)"$`, func(topicName string) error {
		actualOutput, _ := json.Marshal(world.lastResult.Output)
		if !strings.Contains(string(actualOutput), topicName) {
			return fmt.Errorf("expected output to contain %q but got: %s", topicName, string(actualOutput))
		}
		return nil
	})
}
