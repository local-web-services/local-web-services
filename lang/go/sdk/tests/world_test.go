package tests

import (
	"context"
	"fmt"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	core "github.com/local-web-services/local-web-services-go-core/lws"
	"github.com/local-web-services/local-web-services-go-sdk/lws"
)


const basePort = 19401

var sharedServer *core.Server

// LastResult stores the outcome of a service API call.
type LastResult struct {
	Success bool
	Output  interface{}
	Error   error
}

// World holds state for a BDD scenario.
type World struct {
	managementPort int
	awsCfg         aws.Config

	lastResult          LastResult
	lastStateMachineArn string
	lastExecArn         string
	lastLogCapture      *fakeCaptureAdapter // set by logs_test.go steps
	lastMessages        interface{}
	fakedResponseBody   string
	sessionOpen         bool
}

func newWorld() *World {
	awsCfg, _ := config.LoadDefaultConfig(context.Background(),
		config.WithRegion("us-east-1"),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider("test", "test", "")),
	)
	return &World{
		managementPort: basePort,
		awsCfg:         awsCfg,
	}
}

func (w *World) reset() {
	w.lastResult = LastResult{}
	w.lastStateMachineArn = ""
	w.lastExecArn = ""
	w.lastLogCapture = nil
	w.lastMessages = nil
	w.fakedResponseBody = ""
	w.sessionOpen = false
}

func (w *World) cleanup() {
	w.lastLogCapture = nil
}

func (w *World) DynamoDBClient() *dynamodb.Client {
	port := basePort + core.ServiceOffsets["dynamodb"]
	return dynamodb.NewFromConfig(w.awsCfg, func(o *dynamodb.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SQSClient() *sqs.Client {
	port := basePort + core.ServiceOffsets["sqs"]
	return sqs.NewFromConfig(w.awsCfg, func(o *sqs.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) S3Client() *s3.Client {
	port := basePort + core.ServiceOffsets["s3"]
	return s3.NewFromConfig(w.awsCfg, func(o *s3.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		o.UsePathStyle = true
	})
}

func (w *World) SNSClient() *sns.Client {
	port := basePort + core.ServiceOffsets["sns"]
	return sns.NewFromConfig(w.awsCfg, func(o *sns.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SFNClient() *sfn.Client {
	port := basePort + core.ServiceOffsets["stepfunctions"]
	return sfn.NewFromConfig(w.awsCfg, func(o *sfn.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SSMClient() *ssm.Client {
	port := basePort + core.ServiceOffsets["ssm"]
	return ssm.NewFromConfig(w.awsCfg, func(o *ssm.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SecretsManagerClient() *secretsmanager.Client {
	port := basePort + core.ServiceOffsets["secretsmanager"]
	return secretsmanager.NewFromConfig(w.awsCfg, func(o *secretsmanager.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SQSQueueURL(queueName string) string {
	port := basePort + core.ServiceOffsets["sqs"]
	return fmt.Sprintf("http://127.0.0.1:%d/000000000000/%s", port, queueName)
}

// setResult stores a service call outcome in the world.
func setResult(world *World, result interface{}, err error) {
	if err != nil {
		world.lastResult = LastResult{Success: false, Output: err.Error(), Error: err}
	} else {
		world.lastResult = LastResult{Success: true, Output: result}
	}
}

// managementSession returns an lws.Session backed by the shared in-process server.
// It does not start a new process; it simply creates a Session value pointing at basePort.
func managementSession() *lws.Session {
	return lws.NewInProcessSession(basePort)
}
