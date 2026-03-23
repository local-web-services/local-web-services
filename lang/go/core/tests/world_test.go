package tests

import (
	"context"
	"fmt"
	"net"
	"net/http"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/organizations"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	"github.com/local-web-services/local-web-services-go-core/lws"
)

// syncStripTransport is a custom HTTP transport that strips "sync-" from the hostname.
// The AWS SDK v2 for SFN uses "sync-<endpoint>" for StartSyncExecution, so we need to
// strip the prefix to route to our local server.
type syncStripTransport struct {
	base http.RoundTripper
}

func (t *syncStripTransport) RoundTrip(req *http.Request) (*http.Response, error) {
	cloned := req.Clone(req.Context())
	host := cloned.URL.Host
	if strings.HasPrefix(host, "sync-") {
		cloned.URL.Host = strings.TrimPrefix(host, "sync-")
	}
	// Also fix the Host header if it has the "sync-" prefix
	if strings.HasPrefix(cloned.Host, "sync-") {
		cloned.Host = strings.TrimPrefix(cloned.Host, "sync-")
	}
	return t.base.RoundTrip(cloned)
}

func newSyncStripHTTPClient() *http.Client {
	base := &http.Transport{
		DialContext: (&net.Dialer{}).DialContext,
	}
	return &http.Client{Transport: &syncStripTransport{base: base}}
}

const basePort = 19301

var sharedServer *lws.Server

type LastResult struct {
	Success bool
	Output  interface{}
	Error   error
}

type TimedResult struct {
	Success   bool
	Output    interface{}
	ElapsedMs int64
}

type World struct {
	managementPort int
	lastResult     LastResult
	timedResult    TimedResult

	// Multi-step storage
	lastReceiptHandle   string
	lastQueueUrl        string
	lastUploadId        string
	lastBucket          string
	lastKey             string
	lastETag            string
	lastExecutionArn    string
	lastStateMachineArn string
	lastSubscriptionArn string
	lastTopicArn        string

	// Organizations multi-step storage
	orgsOrgId          string
	orgsRootId         string
	orgsAccountId      string
	orgsOuId           string
	orgsOuName         string
	orgsPolicyId       string
	orgsTargetId       string
	orgsSourceParentId string
	orgsDestParentId   string

	// uploadNoParts indicates that the current multipart upload scenario
	// should NOT auto-upload parts before completing (tests the "no parts" failure case).
	uploadNoParts bool

	// sqsQueueCreated tracks whether the main SQS test queue has been created (for cross-service validation).
	sqsQueueCreated bool

	// s3NotificationConfigured tracks whether the S3 bucket notification configuration has been set up (for cross-service validation).
	s3NotificationConfigured bool

	// sfnNoTaskConfigured tracks when a scenario explicitly states "no X task configured"
	// (used to make StartExecution fail for cross-service validation).
	sfnNoTaskConfigured bool

	// s3BucketCreated tracks whether the main S3 test bucket has been explicitly created
	// in the Given steps (used for stepfunctions_s3api bucket-validation scenarios).
	s3BucketCreated bool

	// s3ObjectExists tracks whether an object has been pre-placed in the target bucket
	// in the Given steps (used for stepfunctions_s3api get-object scenarios).
	s3ObjectExists bool

	// ebBusIsDeleted tracks whether the EventBridge bus has been explicitly deleted
	// in a Given step (used for stepfunctions_events and related cross-service scenarios).
	ebBusIsDeleted bool

	// ebBusNotActive tracks whether the EventBridge bus is unavailable (does not exist or not ACTIVE)
	// in a Given step (used for configure_event_publishing bus-validation scenarios).
	ebBusNotActive bool

	// ebRuleCreated tracks whether an EventBridge rule has been enabled (used for events_dynamodb).
	ebRuleCreated bool

	// snsTopicHasMessage tracks whether the SNS topic has an AVAILABLE message (used for events_sns).
	snsTopicHasMessage bool

	// s3TargetBusDeleted tracks whether the target EventBridge bus has been deleted
	// (used for s3api_events cross-service scenarios).
	s3TargetBusDeleted bool

	// s3TargetTopicDeleted tracks whether the target SNS topic has been deleted
	// (used for s3api_sns cross-service scenarios).
	s3TargetTopicDeleted bool

	// s3TargetQueueDeleted tracks whether the target SQS queue has been deleted
	// (used for s3api_sqs cross-service scenarios).
	s3TargetQueueDeleted bool

	awsCfg aws.Config
}

func newWorld() *World {
	// Use "test" as access key (same as TypeScript world) so that IAM tests
	// that rely on default_identity work correctly: "test" is not registered
	// as an identity, so IAM falls back to the configured default_identity.
	awsCfg, _ := config.LoadDefaultConfig(context.Background(),
		config.WithRegion("us-east-1"),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider("test", "test", "")),
	)
	return &World{
		managementPort: basePort,
		awsCfg:         awsCfg,
	}
}

func (w *World) DynamoDBClient() *dynamodb.Client {
	port := basePort + lws.ServiceOffsets["dynamodb"]
	return dynamodb.NewFromConfig(w.awsCfg, func(o *dynamodb.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SQSClient() *sqs.Client {
	port := basePort + lws.ServiceOffsets["sqs"]
	return sqs.NewFromConfig(w.awsCfg, func(o *sqs.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) S3Client() *s3.Client {
	port := basePort + lws.ServiceOffsets["s3"]
	return s3.NewFromConfig(w.awsCfg, func(o *s3.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		o.UsePathStyle = true
	})
}

func (w *World) SNSClient() *sns.Client {
	port := basePort + lws.ServiceOffsets["sns"]
	return sns.NewFromConfig(w.awsCfg, func(o *sns.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) EventBridgeClient() *eventbridge.Client {
	port := basePort + lws.ServiceOffsets["eventbridge"]
	return eventbridge.NewFromConfig(w.awsCfg, func(o *eventbridge.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SFNClient() *sfn.Client {
	port := basePort + lws.ServiceOffsets["stepfunctions"]
	return sfn.NewFromConfig(w.awsCfg, func(o *sfn.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		o.HTTPClient = newSyncStripHTTPClient()
	})
}

func (w *World) SSMClient() *ssm.Client {
	port := basePort + lws.ServiceOffsets["ssm"]
	return ssm.NewFromConfig(w.awsCfg, func(o *ssm.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SecretsManagerClient() *secretsmanager.Client {
	port := basePort + lws.ServiceOffsets["secretsmanager"]
	return secretsmanager.NewFromConfig(w.awsCfg, func(o *secretsmanager.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) OrganizationsClient() *organizations.Client {
	port := basePort + lws.ServiceOffsets["organizations"]
	return organizations.NewFromConfig(w.awsCfg, func(o *organizations.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

func (w *World) SQSQueueURL(queueName string) string {
	port := basePort + lws.ServiceOffsets["sqs"]
	return fmt.Sprintf("http://127.0.0.1:%d/000000000000/%s", port, queueName)
}
