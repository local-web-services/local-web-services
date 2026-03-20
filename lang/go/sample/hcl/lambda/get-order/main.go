package main

import (
	"context"
	"encoding/json"
	"os"
	"strconv"

	"github.com/aws/aws-lambda-go/events"
	lambdaruntime "github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
)

var ddbClient *dynamodb.Client

func init() {
	cfg, _ := config.LoadDefaultConfig(context.Background())
	ddbClient = dynamodb.NewFromConfig(cfg)
}

func handler(ctx context.Context, event events.APIGatewayV2HTTPRequest) (events.APIGatewayProxyResponse, error) {
	orderID := event.PathParameters["id"]
	if orderID == "" {
		return events.APIGatewayProxyResponse{
			StatusCode: 400,
			Headers:    map[string]string{"Content-Type": "application/json"},
			Body:       `{"error":"Missing orderId"}`,
		}, nil
	}

	tableName := os.Getenv("TABLE_NAME")

	result, err := ddbClient.GetItem(ctx, &dynamodb.GetItemInput{
		TableName: aws.String(tableName),
		Key: map[string]types.AttributeValue{
			"orderId": &types.AttributeValueMemberS{Value: orderID},
		},
	})
	if err != nil || result.Item == nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 404,
			Headers:    map[string]string{"Content-Type": "application/json"},
			Body:       `{"error":"Order not found"}`,
		}, nil
	}

	var items interface{}
	json.Unmarshal([]byte(result.Item["items"].(*types.AttributeValueMemberS).Value), &items)
	total, _ := strconv.ParseFloat(result.Item["total"].(*types.AttributeValueMemberN).Value, 64)

	order := map[string]interface{}{
		"orderId":      result.Item["orderId"].(*types.AttributeValueMemberS).Value,
		"customerName": result.Item["customerName"].(*types.AttributeValueMemberS).Value,
		"items":        items,
		"total":        total,
		"status":       result.Item["status"].(*types.AttributeValueMemberS).Value,
		"createdAt":    result.Item["createdAt"].(*types.AttributeValueMemberS).Value,
	}

	respJSON, _ := json.Marshal(order)

	return events.APIGatewayProxyResponse{
		StatusCode: 200,
		Headers:    map[string]string{"Content-Type": "application/json"},
		Body:       string(respJSON),
	}, nil
}

func main() {
	lambdaruntime.Start(handler)
}
