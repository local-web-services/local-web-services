package main

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	lambdaruntime "github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/s3"
)

var s3Client *s3.Client

func init() {
	cfg, _ := config.LoadDefaultConfig(context.Background())
	s3Client = s3.NewFromConfig(cfg)
}

func handler(ctx context.Context, event map[string]interface{}) (map[string]interface{}, error) {
	orderID := "unknown"
	if v, ok := event["orderId"].(string); ok {
		orderID = v
	}
	key := fmt.Sprintf("receipts/%s.json", orderID)

	receipt := map[string]interface{}{
		"orderId":     orderID,
		"generatedAt": time.Now().UTC().Format(time.RFC3339Nano),
		"items":       event["items"],
		"total":       event["total"],
		"status":      "RECEIPT_GENERATED",
	}

	receiptJSON, _ := json.MarshalIndent(receipt, "", "  ")

	s3Client.PutObject(ctx, &s3.PutObjectInput{
		Bucket:      aws.String(os.Getenv("BUCKET_NAME")),
		Key:         aws.String(key),
		Body:        bytes.NewReader(receiptJSON),
		ContentType: aws.String("application/json"),
	})

	return map[string]interface{}{"orderId": orderID, "receiptKey": key}, nil
}

func main() {
	lambdaruntime.Start(handler)
}
