package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	"github.com/aws/aws-lambda-go/events"
	lambdaruntime "github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/google/uuid"
)

var ddbClient *dynamodb.Client
var sqsClient *sqs.Client

func init() {
	cfg, _ := config.LoadDefaultConfig(context.Background())
	ddbClient = dynamodb.NewFromConfig(cfg)
	sqsClient = sqs.NewFromConfig(cfg)
}

type OrderRequest struct {
	CustomerName string      `json:"customerName"`
	Items        interface{} `json:"items"`
	Total        float64     `json:"total"`
}

func handler(ctx context.Context, event events.APIGatewayV2HTTPRequest) (events.APIGatewayProxyResponse, error) {
	var body OrderRequest
	json.Unmarshal([]byte(event.Body), &body)

	orderID := uuid.New().String()
	now := time.Now().UTC().Format(time.RFC3339Nano)
	tableName := os.Getenv("TABLE_NAME")
	queueURL := os.Getenv("QUEUE_URL")

	itemsJSON, _ := json.Marshal(body.Items)
	if body.Items == nil {
		itemsJSON = []byte("[]")
	}

	customerName := body.CustomerName
	if customerName == "" {
		customerName = "Unknown"
	}

	ddbClient.PutItem(ctx, &dynamodb.PutItemInput{
		TableName: aws.String(tableName),
		Item: map[string]types.AttributeValue{
			"orderId":      &types.AttributeValueMemberS{Value: orderID},
			"customerName": &types.AttributeValueMemberS{Value: customerName},
			"items":        &types.AttributeValueMemberS{Value: string(itemsJSON)},
			"total":        &types.AttributeValueMemberN{Value: fmt.Sprintf("%g", body.Total)},
			"status":       &types.AttributeValueMemberS{Value: "CREATED"},
			"createdAt":    &types.AttributeValueMemberS{Value: now},
		},
	})

	msg := map[string]interface{}{
		"orderId":      orderID,
		"customerName": customerName,
		"items":        body.Items,
		"total":        body.Total,
	}
	msgJSON, _ := json.Marshal(msg)

	sqsClient.SendMessage(ctx, &sqs.SendMessageInput{
		QueueUrl:    aws.String(queueURL),
		MessageBody: aws.String(string(msgJSON)),
	})

	respBody := map[string]interface{}{
		"orderId":   orderID,
		"status":    "CREATED",
		"createdAt": now,
	}
	respJSON, _ := json.Marshal(respBody)

	return events.APIGatewayProxyResponse{
		StatusCode: 201,
		Headers:    map[string]string{"Content-Type": "application/json"},
		Body:       string(respJSON),
	}, nil
}

func main() {
	lambdaruntime.Start(handler)
}
