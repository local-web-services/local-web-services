package tests

import (
	"context"
	"fmt"
	"net"
	"net/http"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	awshttp "github.com/aws/aws-sdk-go-v2/aws/transport/http"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go-v2/service/docdb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	"github.com/aws/aws-sdk-go-v2/service/elasticache"
	"github.com/aws/aws-sdk-go-v2/service/elasticsearchservice"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/glacier"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	"github.com/aws/aws-sdk-go-v2/service/memorydb"
	"github.com/aws/aws-sdk-go-v2/service/neptune"
	"github.com/aws/aws-sdk-go-v2/service/opensearch"
	"github.com/aws/aws-sdk-go-v2/service/organizations"
	"github.com/aws/aws-sdk-go-v2/service/rds"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/s3tables"
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

// sharedHTTPClient is a single http.Client shared across all scenarios to
// keep connections alive and avoid exhausting macOS ephemeral ports when
// running thousands of scenarios sequentially.
var sharedHTTPClient = awshttp.NewBuildableClient().WithTransportOptions(func(tr *http.Transport) {
	tr.MaxIdleConns = 100
	tr.MaxIdleConnsPerHost = 20
	tr.IdleConnTimeout = 90 * time.Second
	tr.DialContext = (&net.Dialer{
		Timeout:   10 * time.Second,
		KeepAlive: 30 * time.Second,
	}).DialContext
})

// sharedAWSConfig is loaded once and reused for all clients.
var sharedAWSConfig = func() aws.Config {
	cfg, _ := config.LoadDefaultConfig(context.Background(),
		config.WithRegion("us-east-1"),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider("test", "test", "")),
		config.WithHTTPClient(sharedHTTPClient),
	)
	return cfg
}()

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
	lastLogCapture      *lws.LogCapture
	lastMessages        interface{}
	fakedResponseBody   string
	sessionOpen         bool

	// Cached service clients — reused within a scenario to avoid creating
	// new http.Transport instances (and thus new ephemeral TCP connections)
	// for every API call.
	dynamodbClient             *dynamodb.Client
	sqsClient                  *sqs.Client
	s3Client                   *s3.Client
	snsClient                  *sns.Client
	eventbridgeClient          *eventbridge.Client
	sfnClient                  *sfn.Client
	ssmClient                  *ssm.Client
	secretsmanagerClient       *secretsmanager.Client
	cognitoIDPClient           *cognitoidentityprovider.Client
	apigatewayClient           *apigateway.Client
	lambdaClient               *lambda.Client
	organizationsClient        *organizations.Client
	rdsClient                  *rds.Client
	docdbClient                *docdb.Client
	neptuneClient              *neptune.Client
	elasticacheClient          *elasticache.Client
	memorydbClient             *memorydb.Client
	glacierClient              *glacier.Client
	elasticsearchserviceClient *elasticsearchservice.Client
	opensearchClient           *opensearch.Client
	s3tablesClient             *s3tables.Client
}

func newWorld() *World {
	return &World{
		managementPort: basePort,
		awsCfg:         sharedAWSConfig,
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
	// Keep cached clients — they share the persistent sharedHTTPClient
	// transport and can safely be reused across scenarios.
}

func (w *World) cleanup() {
	if w.lastLogCapture != nil {
		w.lastLogCapture.Stop()
		w.lastLogCapture = nil
	}
}

func (w *World) DynamoDBClient() *dynamodb.Client {
	if w.dynamodbClient == nil {
		port := basePort + core.ServiceOffsets["dynamodb"]
		w.dynamodbClient = dynamodb.NewFromConfig(w.awsCfg, func(o *dynamodb.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.dynamodbClient
}

func (w *World) SQSClient() *sqs.Client {
	if w.sqsClient == nil {
		port := basePort + core.ServiceOffsets["sqs"]
		w.sqsClient = sqs.NewFromConfig(w.awsCfg, func(o *sqs.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.sqsClient
}

func (w *World) S3Client() *s3.Client {
	if w.s3Client == nil {
		port := basePort + core.ServiceOffsets["s3"]
		w.s3Client = s3.NewFromConfig(w.awsCfg, func(o *s3.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
			o.UsePathStyle = true
		})
	}
	return w.s3Client
}

func (w *World) SNSClient() *sns.Client {
	if w.snsClient == nil {
		port := basePort + core.ServiceOffsets["sns"]
		w.snsClient = sns.NewFromConfig(w.awsCfg, func(o *sns.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.snsClient
}

func (w *World) EventBridgeClient() *eventbridge.Client {
	if w.eventbridgeClient == nil {
		port := basePort + core.ServiceOffsets["eventbridge"]
		w.eventbridgeClient = eventbridge.NewFromConfig(w.awsCfg, func(o *eventbridge.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.eventbridgeClient
}

func (w *World) SFNClient() *sfn.Client {
	if w.sfnClient == nil {
		port := basePort + core.ServiceOffsets["stepfunctions"]
		w.sfnClient = sfn.NewFromConfig(w.awsCfg, func(o *sfn.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.sfnClient
}

func (w *World) SSMClient() *ssm.Client {
	if w.ssmClient == nil {
		port := basePort + core.ServiceOffsets["ssm"]
		w.ssmClient = ssm.NewFromConfig(w.awsCfg, func(o *ssm.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.ssmClient
}

func (w *World) SecretsManagerClient() *secretsmanager.Client {
	if w.secretsmanagerClient == nil {
		port := basePort + core.ServiceOffsets["secretsmanager"]
		w.secretsmanagerClient = secretsmanager.NewFromConfig(w.awsCfg, func(o *secretsmanager.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.secretsmanagerClient
}

func (w *World) CognitoIDPClient() *cognitoidentityprovider.Client {
	if w.cognitoIDPClient == nil {
		port := basePort + core.ServiceOffsets["cognitoidp"]
		w.cognitoIDPClient = cognitoidentityprovider.NewFromConfig(w.awsCfg, func(o *cognitoidentityprovider.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.cognitoIDPClient
}

func (w *World) APIGatewayClient() *apigateway.Client {
	if w.apigatewayClient == nil {
		port := basePort + core.ServiceOffsets["apigateway"]
		w.apigatewayClient = apigateway.NewFromConfig(w.awsCfg, func(o *apigateway.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.apigatewayClient
}

func (w *World) LambdaClient() *lambda.Client {
	if w.lambdaClient == nil {
		port := basePort + core.ServiceOffsets["lambda"]
		w.lambdaClient = lambda.NewFromConfig(w.awsCfg, func(o *lambda.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.lambdaClient
}

func (w *World) OrganizationsClient() *organizations.Client {
	if w.organizationsClient == nil {
		port := basePort + core.ServiceOffsets["organizations"]
		w.organizationsClient = organizations.NewFromConfig(w.awsCfg, func(o *organizations.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.organizationsClient
}

func (w *World) RDSClient() *rds.Client {
	if w.rdsClient == nil {
		port := basePort + core.ServiceOffsets["rds"]
		w.rdsClient = rds.NewFromConfig(w.awsCfg, func(o *rds.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.rdsClient
}

func (w *World) DocDBClient() *docdb.Client {
	if w.docdbClient == nil {
		port := basePort + core.ServiceOffsets["docdb"]
		w.docdbClient = docdb.NewFromConfig(w.awsCfg, func(o *docdb.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.docdbClient
}

func (w *World) NeptuneClient() *neptune.Client {
	if w.neptuneClient == nil {
		port := basePort + core.ServiceOffsets["neptune"]
		w.neptuneClient = neptune.NewFromConfig(w.awsCfg, func(o *neptune.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.neptuneClient
}

func (w *World) ElastiCacheClient() *elasticache.Client {
	if w.elasticacheClient == nil {
		port := basePort + core.ServiceOffsets["elasticache"]
		w.elasticacheClient = elasticache.NewFromConfig(w.awsCfg, func(o *elasticache.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.elasticacheClient
}

func (w *World) MemoryDBClient() *memorydb.Client {
	if w.memorydbClient == nil {
		port := basePort + core.ServiceOffsets["memorydb"]
		w.memorydbClient = memorydb.NewFromConfig(w.awsCfg, func(o *memorydb.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.memorydbClient
}

func (w *World) GlacierClient() *glacier.Client {
	if w.glacierClient == nil {
		port := basePort + core.ServiceOffsets["glacier"]
		w.glacierClient = glacier.NewFromConfig(w.awsCfg, func(o *glacier.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.glacierClient
}

func (w *World) ElasticsearchClient() *elasticsearchservice.Client {
	if w.elasticsearchserviceClient == nil {
		port := basePort + core.ServiceOffsets["elasticsearch"]
		w.elasticsearchserviceClient = elasticsearchservice.NewFromConfig(w.awsCfg, func(o *elasticsearchservice.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.elasticsearchserviceClient
}

func (w *World) OpenSearchClient() *opensearch.Client {
	if w.opensearchClient == nil {
		port := basePort + core.ServiceOffsets["opensearch"]
		w.opensearchClient = opensearch.NewFromConfig(w.awsCfg, func(o *opensearch.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.opensearchClient
}

func (w *World) S3TablesClient() *s3tables.Client {
	if w.s3tablesClient == nil {
		port := basePort + core.ServiceOffsets["s3tables"]
		w.s3tablesClient = s3tables.NewFromConfig(w.awsCfg, func(o *s3tables.Options) {
			o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		})
	}
	return w.s3tablesClient
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
