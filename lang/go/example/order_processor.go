package main

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/aws/aws-sdk-go-v2/service/sfn"
)

// OrderProcessor starts a Step Functions execution for an order and polls until it completes.
type OrderProcessor struct {
	sfnClient *sfn.Client
}

// NewOrderProcessor creates a processor with the given SFN client.
func NewOrderProcessor(client *sfn.Client) *OrderProcessor {
	return &OrderProcessor{sfnClient: client}
}

// ProcessOrder starts an execution for the given order ID and returns the parsed output.
func (p *OrderProcessor) ProcessOrder(ctx context.Context, orderId, stateMachineArn string) (map[string]any, error) {
	input, _ := json.Marshal(map[string]string{"orderId": orderId})

	started, err := p.sfnClient.StartExecution(ctx, &sfn.StartExecutionInput{
		StateMachineArn: &stateMachineArn,
		Input:           strPtr(string(input)),
	})
	if err != nil {
		return nil, fmt.Errorf("StartExecution failed: %w", err)
	}

	return p.pollUntilComplete(ctx, *started.ExecutionArn)
}

func (p *OrderProcessor) pollUntilComplete(ctx context.Context, executionArn string) (map[string]any, error) {
	for {
		result, err := p.sfnClient.DescribeExecution(ctx, &sfn.DescribeExecutionInput{
			ExecutionArn: &executionArn,
		})
		if err != nil {
			return nil, fmt.Errorf("DescribeExecution failed: %w", err)
		}

		switch string(result.Status) {
		case "SUCCEEDED":
			var output map[string]any
			if err := json.Unmarshal([]byte(*result.Output), &output); err != nil {
				return nil, fmt.Errorf("failed to parse output: %w", err)
			}
			return output, nil
		case "FAILED", "TIMED_OUT", "ABORTED":
			return nil, fmt.Errorf("execution ended with status: %s", result.Status)
		default:
			time.Sleep(100 * time.Millisecond)
		}
	}
}

func strPtr(s string) *string { return &s }
