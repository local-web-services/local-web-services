package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"strconv"
	"time"

	lambdaruntime "github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
)

var ddbClient *dynamodb.Client
var snsClient *sns.Client
var ssmClient *ssm.Client
var smClient *secretsmanager.Client

func init() {
	cfg, _ := config.LoadDefaultConfig(context.Background())
	ddbClient = dynamodb.NewFromConfig(cfg)
	snsClient = sns.NewFromConfig(cfg)
	ssmClient = ssm.NewFromConfig(cfg)
	smClient = secretsmanager.NewFromConfig(cfg)
}

type SQSRecord struct {
	Body string `json:"body"`
}

type SQSEvent struct {
	Records []SQSRecord `json:"Records"`
}

func handler(ctx context.Context, event json.RawMessage) (map[string]interface{}, error) {
	var sqsEvent SQSEvent
	json.Unmarshal(event, &sqsEvent)

	var records []SQSRecord
	if len(sqsEvent.Records) > 0 {
		records = sqsEvent.Records
	} else {
		records = []SQSRecord{{Body: string(event)}}
	}

	maxItemsParam := os.Getenv("MAX_ITEMS_PARAM")
	if maxItemsParam == "" {
		maxItemsParam = "/orders/config/max-items"
	}
	maxItemsResp, _ := ssmClient.GetParameter(ctx, &ssm.GetParameterInput{
		Name: aws.String(maxItemsParam),
	})
	maxItems := 100
	if maxItemsResp != nil && maxItemsResp.Parameter != nil {
		maxItems, _ = strconv.Atoi(aws.ToString(maxItemsResp.Parameter.Value))
	}

	secretID := os.Getenv("NOTIFICATION_SECRET_ARN")
	if secretID == "" {
		secretID = "orders/notification-api-key"
	}
	secretResp, _ := smClient.GetSecretValue(ctx, &secretsmanager.GetSecretValueInput{
		SecretId: aws.String(secretID),
	})
	notificationKey := "default"
	if secretResp != nil && secretResp.SecretString != nil {
		var s map[string]string
		json.Unmarshal([]byte(*secretResp.SecretString), &s)
		if v, ok := s["apiKey"]; ok {
			notificationKey = v
		}
	}

	var results []map[string]interface{}

	for _, record := range records {
		var order map[string]interface{}
		json.Unmarshal([]byte(record.Body), &order)
		orderID, _ := order["orderId"].(string)
		if orderID == "" {
			continue
		}

		ddbClient.UpdateItem(ctx, &dynamodb.UpdateItemInput{
			TableName: aws.String(os.Getenv("TABLE_NAME")),
			Key: map[string]types.AttributeValue{
				"orderId": &types.AttributeValueMemberS{Value: orderID},
			},
			UpdateExpression:          aws.String("SET #status = :status"),
			ExpressionAttributeNames:  map[string]string{"#status": "status"},
			ExpressionAttributeValues: map[string]types.AttributeValue{":status": &types.AttributeValueMemberS{Value: "PROCESSED"}},
		})

		keyPreview := notificationKey
		if len(keyPreview) > 4 {
			keyPreview = keyPreview[:4]
		}

		notification := map[string]interface{}{
			"orderId":         orderID,
			"status":          "PROCESSED",
			"timestamp":       time.Now().UTC().Format(time.RFC3339Nano),
			"maxItems":        maxItems,
			"notificationKey": keyPreview + "****",
		}
		notifJSON, _ := json.Marshal(notification)

		snsClient.Publish(ctx, &sns.PublishInput{
			TopicArn: aws.String(os.Getenv("TOPIC_ARN")),
			Subject:  aws.String(fmt.Sprintf("Order %s processed", orderID)),
			Message:  aws.String(string(notifJSON)),
		})

		results = append(results, map[string]interface{}{"orderId": orderID, "status": "PROCESSED"})
	}

	return map[string]interface{}{"processed": len(results), "results": results}, nil
}

func main() {
	lambdaruntime.Start(handler)
}
