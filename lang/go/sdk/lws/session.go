package lws

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"strings"
	"testing"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go-v2/service/docdb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/elasticache"
	"github.com/aws/aws-sdk-go-v2/service/elasticsearchservice"
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
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"

	core "github.com/local-web-services/local-web-services-go-core/lws"
)

// serviceOffsets maps service names to their port offset from the base port.
var serviceOffsets = map[string]int{
	"dynamodb":       1,
	"sqs":            2,
	"s3":             3,
	"sns":            4,
	"stepfunctions":  6,
	"cognitoidp":     7,
	"lambda":         8,
	"apigateway":     9,
	"rds":            10,
	"docdb":          11,
	"ssm":            12,
	"secretsmanager": 13,
	"elasticache":    14,
	"neptune":        15,
	"memorydb":       16,
	"glacier":        17,
	"elasticsearch":  18,
	"opensearch":     19,
	"s3tables":       20,
	"organizations":  50,
}

// serviceEnvVars maps service names to AWS SDK endpoint URL environment variables.
// Setting these redirects any SDK client created in the process to the local LWS
// service — no production-code changes required (drop-in mode).
var serviceEnvVars = map[string]string{
	"dynamodb":       "AWS_ENDPOINT_URL_DYNAMODB",
	"sqs":            "AWS_ENDPOINT_URL_SQS",
	"s3":             "AWS_ENDPOINT_URL_S3",
	"sns":            "AWS_ENDPOINT_URL_SNS",
	"stepfunctions":  "AWS_ENDPOINT_URL_STEPFUNCTIONS",
	"cognitoidp":     "AWS_ENDPOINT_URL_COGNITO_IDP",
	"lambda":         "AWS_ENDPOINT_URL_LAMBDA",
	"apigateway":     "AWS_ENDPOINT_URL_API_GATEWAY",
	"rds":            "AWS_ENDPOINT_URL_RDS",
	"docdb":          "AWS_ENDPOINT_URL_RDS",
	"ssm":            "AWS_ENDPOINT_URL_SSM",
	"secretsmanager": "AWS_ENDPOINT_URL_SECRETSMANAGER",
	"elasticache":    "AWS_ENDPOINT_URL_ELASTICACHE",
	"neptune":        "AWS_ENDPOINT_URL_NEPTUNE",
	"memorydb":       "AWS_ENDPOINT_URL_MEMORY_DB",
	"glacier":        "AWS_ENDPOINT_URL_GLACIER",
	"elasticsearch":  "AWS_ENDPOINT_URL_ELASTICSEARCH",
	"opensearch":     "AWS_ENDPOINT_URL_OPENSEARCH",
	"s3tables":       "AWS_ENDPOINT_URL_S3_TABLES",
}

// Session is a local AWS session backed by an in-process LWS server.
// Call Close or defer session.Close() after the test to stop the server.
type Session struct {
	basePort int
	srv      *core.Server // nil when created via NewInProcessSession
	awsCfg   aws.Config
	bgLogs   *LogCapture
	savedEnv map[string]string
}

// ── Functional options ────────────────────────────────────────────────────────

// Option configures the resources pre-created in a Session.
type Option func(*SessionSpec)

// DynamoTable adds a DynamoDB table with the given name and hash key to the session.
func DynamoTable(name, hashKey string) Option {
	return func(s *SessionSpec) {
		s.Tables = append(s.Tables, TableSpec{Name: name, PartitionKey: hashKey})
	}
}

// SQSQueue adds an SQS queue to the session.
func SQSQueue(name string) Option {
	return func(s *SessionSpec) {
		s.Queues = append(s.Queues, name)
	}
}

// S3Bucket adds an S3 bucket to the session.
func S3Bucket(name string) Option {
	return func(s *SessionSpec) {
		s.Buckets = append(s.Buckets, name)
	}
}

// SNSTopic adds an SNS topic to the session.
func SNSTopic(name string) Option {
	return func(s *SessionSpec) {
		s.Topics = append(s.Topics, name)
	}
}

// StepFunction adds a Step Functions state machine to the session.
func StepFunction(name, definition string) Option {
	return func(s *SessionSpec) {
		s.StateMachines = append(s.StateMachines, StateMachineSpec{
			Name:       name,
			Definition: definition,
		})
	}
}

// SSMParameter adds an SSM Parameter Store parameter to the session.
func SSMParameter(name string) Option {
	return func(s *SessionSpec) {
		s.Parameters = append(s.Parameters, name)
	}
}

// SecretValue adds a Secrets Manager secret to the session.
func SecretValue(name string) Option {
	return func(s *SessionSpec) {
		s.Secrets = append(s.Secrets, name)
	}
}

func buildSpec(opts ...Option) SessionSpec {
	var spec SessionSpec
	for _, opt := range opts {
		opt(&spec)
	}
	return spec
}

// ── Entry points ──────────────────────────────────────────────────────────────

// Start creates an in-process session, pre-creates resources, and registers
// t.Cleanup to reset and close. Each test calling Start gets its own isolated
// server — no shared state between tests.
func Start(t *testing.T, opts ...Option) *Session {
	t.Helper()
	spec := buildSpec(opts...)
	s, err := New(spec)
	if err != nil {
		t.Fatalf("lws.Start: %v", err)
	}
	t.Cleanup(func() {
		if err := s.Reset(); err != nil {
			t.Logf("lws.Reset: %v", err)
		}
	})
	t.Cleanup(s.Close)
	return s
}

// NewShared creates an in-process session without binding to a *testing.T.
// Use this in TestMain or BDD suites that start once and reset per scenario.
func NewShared(opts ...Option) (*Session, error) {
	return New(buildSpec(opts...))
}

// New creates an in-process session with explicitly declared resources.
func New(spec SessionSpec) (*Session, error) {
	basePort, err := core.FindFreePort()
	if err != nil {
		return nil, fmt.Errorf("failed to find free port: %w", err)
	}

	srv, err := core.StartServer(basePort)
	if err != nil {
		return nil, fmt.Errorf("failed to start server: %w", err)
	}

	awsCfg, err := config.LoadDefaultConfig(context.Background(),
		config.WithRegion("us-east-1"),
		config.WithCredentialsProvider(
			credentials.NewStaticCredentialsProvider("test", "test", ""),
		),
	)
	if err != nil {
		srv.Close()
		return nil, fmt.Errorf("failed to load AWS config: %w", err)
	}

	session := &Session{
		basePort: basePort,
		srv:      srv,
		awsCfg:   awsCfg,
		savedEnv: make(map[string]string),
	}

	if err := session.preCreateResources(spec); err != nil {
		srv.Close()
		return nil, err
	}

	session.patchEnv()

	if bgLogs, err := newLogCapture(session); err == nil {
		session.bgLogs = bgLogs
	}

	return session, nil
}

// FromHcl creates a session by discovering resources from Terraform HCL files
// in the given directory.
func FromHcl(projectDir string) (*Session, error) {
	spec, err := DiscoverHcl(projectDir)
	if err != nil {
		return nil, fmt.Errorf("HCL discovery failed: %w", err)
	}
	return New(spec)
}

// NewInProcessSession creates a Session that points at an already-running
// in-process server at the given base port. No new server is started.
//
// Deprecated: use Start or NewShared instead, which start their own in-process
// server and manage its lifecycle automatically.
func NewInProcessSession(basePort int) *Session {
	awsCfg, _ := config.LoadDefaultConfig(context.Background(),
		config.WithRegion("us-east-1"),
		config.WithCredentialsProvider(
			credentials.NewStaticCredentialsProvider("test", "test", ""),
		),
	)
	s := &Session{basePort: basePort, awsCfg: awsCfg, savedEnv: make(map[string]string)}
	if bgLogs, err := newLogCapture(s); err == nil {
		s.bgLogs = bgLogs
	}
	return s
}

// ── Environment patching ──────────────────────────────────────────────────────

// patchEnv sets AWS SDK endpoint env vars so any SDK client created in this
// process automatically hits the local LWS service (drop-in mode).
func (s *Session) patchEnv() {
	for service, envVar := range serviceEnvVars {
		port := s.basePort + serviceOffsets[service]
		s.savedEnv[envVar] = os.Getenv(envVar)
		os.Setenv(envVar, fmt.Sprintf("http://127.0.0.1:%d", port)) //nolint:errcheck
	}
	testCreds := map[string]string{
		"AWS_ACCESS_KEY_ID":     "test",
		"AWS_SECRET_ACCESS_KEY": "test",
		"AWS_DEFAULT_REGION":    "us-east-1",
	}
	for k, v := range testCreds {
		s.savedEnv[k] = os.Getenv(k)
		os.Setenv(k, v) //nolint:errcheck
	}
}

// restoreEnv undoes all env var changes made by patchEnv.
func (s *Session) restoreEnv() {
	for k, saved := range s.savedEnv {
		if saved == "" {
			os.Unsetenv(k) //nolint:errcheck
		} else {
			os.Setenv(k, saved) //nolint:errcheck
		}
	}
	s.savedEnv = make(map[string]string)
}

// ── Port / URL helpers ────────────────────────────────────────────────────────

// PortFor returns the port number for the named service.
func (s *Session) PortFor(service string) (int, error) {
	offset, ok := serviceOffsets[service]
	if !ok {
		return 0, fmt.Errorf("unknown service: %s", service)
	}
	return s.basePort + offset, nil
}

// QueueURL returns the local SQS queue URL for the given queue name.
func (s *Session) QueueURL(queueName string) string {
	port, _ := s.PortFor("sqs")
	return fmt.Sprintf("http://127.0.0.1:%d/000000000000/%s", port, queueName)
}

// ── AWS client factory ────────────────────────────────────────────────────────

// DynamoDBClient returns a pre-configured DynamoDB client.
func (s *Session) DynamoDBClient() *dynamodb.Client {
	port, _ := s.PortFor("dynamodb")
	return dynamodb.NewFromConfig(s.awsCfg, func(o *dynamodb.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// SQSClient returns a pre-configured SQS client.
func (s *Session) SQSClient() *sqs.Client {
	port, _ := s.PortFor("sqs")
	return sqs.NewFromConfig(s.awsCfg, func(o *sqs.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// S3Client returns a pre-configured S3 client.
func (s *Session) S3Client() *s3.Client {
	port, _ := s.PortFor("s3")
	return s3.NewFromConfig(s.awsCfg, func(o *s3.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
		o.UsePathStyle = true
	})
}

// SFNClient returns a pre-configured Step Functions client.
func (s *Session) SFNClient() *sfn.Client {
	port, _ := s.PortFor("stepfunctions")
	return sfn.NewFromConfig(s.awsCfg, func(o *sfn.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// SNSClient returns a pre-configured SNS client.
func (s *Session) SNSClient() *sns.Client {
	port, _ := s.PortFor("sns")
	return sns.NewFromConfig(s.awsCfg, func(o *sns.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// SSMClient returns a pre-configured SSM client.
func (s *Session) SSMClient() *ssm.Client {
	port, _ := s.PortFor("ssm")
	return ssm.NewFromConfig(s.awsCfg, func(o *ssm.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// SecretsManagerClient returns a pre-configured Secrets Manager client.
func (s *Session) SecretsManagerClient() *secretsmanager.Client {
	port, _ := s.PortFor("secretsmanager")
	return secretsmanager.NewFromConfig(s.awsCfg, func(o *secretsmanager.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// CognitoIdentityProviderClient returns a pre-configured Cognito Identity Provider client.
func (s *Session) CognitoIdentityProviderClient() *cognitoidentityprovider.Client {
	port, _ := s.PortFor("cognitoidp")
	return cognitoidentityprovider.NewFromConfig(s.awsCfg, func(o *cognitoidentityprovider.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// APIGatewayClient returns a pre-configured API Gateway client.
func (s *Session) APIGatewayClient() *apigateway.Client {
	port, _ := s.PortFor("apigateway")
	return apigateway.NewFromConfig(s.awsCfg, func(o *apigateway.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// LambdaClient returns a pre-configured Lambda client.
func (s *Session) LambdaClient() *lambda.Client {
	port, _ := s.PortFor("lambda")
	return lambda.NewFromConfig(s.awsCfg, func(o *lambda.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// RDSClient returns a pre-configured RDS client.
func (s *Session) RDSClient() *rds.Client {
	port, _ := s.PortFor("rds")
	return rds.NewFromConfig(s.awsCfg, func(o *rds.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// DocDBClient returns a pre-configured DocumentDB client.
func (s *Session) DocDBClient() *docdb.Client {
	port, _ := s.PortFor("docdb")
	return docdb.NewFromConfig(s.awsCfg, func(o *docdb.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// NeptuneClient returns a pre-configured Neptune client.
func (s *Session) NeptuneClient() *neptune.Client {
	port, _ := s.PortFor("neptune")
	return neptune.NewFromConfig(s.awsCfg, func(o *neptune.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// ElastiCacheClient returns a pre-configured ElastiCache client.
func (s *Session) ElastiCacheClient() *elasticache.Client {
	port, _ := s.PortFor("elasticache")
	return elasticache.NewFromConfig(s.awsCfg, func(o *elasticache.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// MemoryDBClient returns a pre-configured MemoryDB client.
func (s *Session) MemoryDBClient() *memorydb.Client {
	port, _ := s.PortFor("memorydb")
	return memorydb.NewFromConfig(s.awsCfg, func(o *memorydb.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// GlacierClient returns a pre-configured Glacier client.
func (s *Session) GlacierClient() *glacier.Client {
	port, _ := s.PortFor("glacier")
	return glacier.NewFromConfig(s.awsCfg, func(o *glacier.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// ElasticsearchClient returns a pre-configured Elasticsearch Service client.
func (s *Session) ElasticsearchClient() *elasticsearchservice.Client {
	port, _ := s.PortFor("elasticsearch")
	return elasticsearchservice.NewFromConfig(s.awsCfg, func(o *elasticsearchservice.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// OpenSearchClient returns a pre-configured OpenSearch client.
func (s *Session) OpenSearchClient() *opensearch.Client {
	port, _ := s.PortFor("opensearch")
	return opensearch.NewFromConfig(s.awsCfg, func(o *opensearch.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// S3TablesClient returns a pre-configured S3 Tables client.
func (s *Session) S3TablesClient() *s3tables.Client {
	port, _ := s.PortFor("s3tables")
	return s3tables.NewFromConfig(s.awsCfg, func(o *s3tables.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// OrganizationsClient returns a pre-configured Organizations client.
func (s *Session) OrganizationsClient() *organizations.Client {
	port, _ := s.PortFor("organizations")
	return organizations.NewFromConfig(s.awsCfg, func(o *organizations.Options) {
		o.BaseEndpoint = aws.String(fmt.Sprintf("http://127.0.0.1:%d", port))
	})
}

// ── Lifecycle ─────────────────────────────────────────────────────────────────

// Reset resets all provider state via the management API.
func (s *Session) Reset() error {
	url := fmt.Sprintf("http://127.0.0.1:%d/_ldk/reset", s.basePort)
	resp, err := http.Post(url, "application/json", nil) //nolint:noctx
	if err != nil {
		return fmt.Errorf("reset: %w", err)
	}
	resp.Body.Close()
	return nil
}

// Close stops the background log capture, restores env vars, and shuts down
// the in-process server.
func (s *Session) Close() {
	if s.bgLogs != nil {
		s.bgLogs.Stop()
		s.bgLogs = nil
	}
	s.restoreEnv()
	if s.srv != nil {
		s.srv.Close()
	}
}

// ── Builders ──────────────────────────────────────────────────────────────────

// Chaos returns a ChaosBuilder for the given service (e.g. "stepfunctions").
func (s *Session) Chaos(service string) *ChaosBuilder {
	return &ChaosBuilder{session: s, service: service}
}

// Capacity returns a CapacityBuilder for the given service (e.g. "stepfunctions").
func (s *Session) Capacity(service string) *CapacityBuilder {
	return newCapacityBuilder(s, service)
}

// StartLogCapture connects to the WebSocket log stream and begins recording entries.
func (s *Session) StartLogCapture() (*LogCapture, error) {
	return newLogCapture(s)
}

// Iam returns an IamBuilder for configuring IAM authentication mode.
func (s *Session) Iam() *IamBuilder {
	return &IamBuilder{
		session:    s,
		updates:    make(map[string]any),
		identities: make(map[string]*IdentityBuilder),
	}
}

// ── Resource helpers ──────────────────────────────────────────────────────────

// DynamoDB returns a DynamoDBHelper bound to the given table name.
func (s *Session) DynamoDB(tableName string) *DynamoDBHelper {
	return &DynamoDBHelper{tableName: tableName, client: s.DynamoDBClient()}
}

// SQS returns an SQSHelper bound to the given queue name.
func (s *Session) SQS(queueName string) *SQSHelper {
	return &SQSHelper{
		queueName: queueName,
		queueURL:  s.QueueURL(queueName),
		client:    s.SQSClient(),
	}
}

// S3 returns an S3Helper bound to the given bucket name.
func (s *Session) S3(bucketName string) *S3Helper {
	return &S3Helper{bucket: bucketName, client: s.S3Client()}
}

// RecentLogs returns a snapshot of all log entries recorded since session start.
// Returns nil if the background log capture is not running.
func (s *Session) RecentLogs() []LogEntry {
	if s.bgLogs == nil {
		return nil
	}
	return s.bgLogs.Entries()
}

// ── Resource pre-creation ─────────────────────────────────────────────────────

func (s *Session) preCreateResources(spec SessionSpec) error {
	ctx := context.Background()

	if len(spec.Tables) > 0 {
		ddb := s.DynamoDBClient()
		for _, t := range spec.Tables {
			keySchema := []dynamodbtypes.KeySchemaElement{
				{AttributeName: aws.String(t.PartitionKey), KeyType: dynamodbtypes.KeyTypeHash},
			}
			attrDefs := []dynamodbtypes.AttributeDefinition{
				{AttributeName: aws.String(t.PartitionKey), AttributeType: dynamodbtypes.ScalarAttributeTypeS},
			}
			if t.SortKey != "" {
				keySchema = append(keySchema, dynamodbtypes.KeySchemaElement{
					AttributeName: aws.String(t.SortKey), KeyType: dynamodbtypes.KeyTypeRange,
				})
				attrDefs = append(attrDefs, dynamodbtypes.AttributeDefinition{
					AttributeName: aws.String(t.SortKey), AttributeType: dynamodbtypes.ScalarAttributeTypeS,
				})
			}
			if _, err := ddb.CreateTable(ctx, &dynamodb.CreateTableInput{
				TableName:            aws.String(t.Name),
				KeySchema:            keySchema,
				AttributeDefinitions: attrDefs,
				BillingMode:          dynamodbtypes.BillingModePayPerRequest,
			}); err != nil {
				return fmt.Errorf("create table %q: %w", t.Name, err)
			}
		}
	}

	if len(spec.Queues) > 0 {
		sqsc := s.SQSClient()
		for _, q := range spec.Queues {
			if _, err := sqsc.CreateQueue(ctx, &sqs.CreateQueueInput{
				QueueName: aws.String(q),
			}); err != nil {
				return fmt.Errorf("create queue %q: %w", q, err)
			}
		}
	}

	if len(spec.Buckets) > 0 {
		s3c := s.S3Client()
		for _, b := range spec.Buckets {
			if _, err := s3c.CreateBucket(ctx, &s3.CreateBucketInput{
				Bucket: aws.String(b),
			}); err != nil {
				return fmt.Errorf("create bucket %q: %w", b, err)
			}
		}
	}

	if len(spec.Topics) > 0 {
		snsc := s.SNSClient()
		for _, t := range spec.Topics {
			if _, err := snsc.CreateTopic(ctx, &sns.CreateTopicInput{
				Name: aws.String(t),
			}); err != nil {
				return fmt.Errorf("create topic %q: %w", t, err)
			}
		}
	}

	if len(spec.StateMachines) > 0 {
		port, _ := s.PortFor("stepfunctions")
		sfnURL := fmt.Sprintf("http://127.0.0.1:%d", port)
		client := &http.Client{Timeout: 10 * time.Second}
		for _, sm := range spec.StateMachines {
			roleArn := sm.RoleArn
			if roleArn == "" {
				roleArn = "arn:aws:iam::000000000000:role/StepFunctionsRole"
			}
			body := fmt.Sprintf(
				`{"name":%q,"definition":%s,"roleArn":%q,"type":"STANDARD"}`,
				sm.Name, sm.Definition, roleArn,
			)
			req, err := http.NewRequestWithContext(ctx, http.MethodPost, sfnURL, strings.NewReader(body))
			if err != nil {
				return err
			}
			req.Header.Set("Content-Type", "application/x-amz-json-1.0")
			req.Header.Set("X-Amz-Target", "AWSStepFunctions.CreateStateMachine")
			resp, err := client.Do(req)
			if err != nil {
				return err
			}
			resp.Body.Close()
		}
	}

	if len(spec.Parameters) > 0 {
		ssmc := s.SSMClient()
		for _, p := range spec.Parameters {
			if _, err := ssmc.PutParameter(ctx, &ssm.PutParameterInput{
				Name:  aws.String(p),
				Value: aws.String(""),
				Type:  ssmtypes.ParameterTypeString,
			}); err != nil {
				return fmt.Errorf("put parameter %q: %w", p, err)
			}
		}
	}

	if len(spec.Secrets) > 0 {
		smc := s.SecretsManagerClient()
		for _, sec := range spec.Secrets {
			if _, err := smc.CreateSecret(ctx, &secretsmanager.CreateSecretInput{
				Name:         aws.String(sec),
				SecretString: aws.String(""),
			}); err != nil {
				return fmt.Errorf("create secret %q: %w", sec, err)
			}
		}
	}

	return nil
}
