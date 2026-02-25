package lws

import (
	"bytes"
	"context"
	"fmt"
	"io"
	"net"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
	dynamodbtypes "github.com/aws/aws-sdk-go-v2/service/dynamodb/types"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
	"github.com/aws/aws-sdk-go-v2/service/sfn"
	"github.com/aws/aws-sdk-go-v2/service/sns"
	"github.com/aws/aws-sdk-go-v2/service/sqs"
	"github.com/aws/aws-sdk-go-v2/service/ssm"
	ssmtypes "github.com/aws/aws-sdk-go-v2/service/ssm/types"
)

// serviceOffsets maps service names to their port offset from the base port.
var serviceOffsets = map[string]int{
	"dynamodb":       1,
	"sqs":            2,
	"s3":             3,
	"sns":            4,
	"stepfunctions":  6,
	"ssm":            12,
	"secretsmanager": 13,
}

// Session is a local AWS session that wraps an ldk dev subprocess.
// Call Close or defer session.Close() to stop the process after the test.
type Session struct {
	basePort int
	cmd      *exec.Cmd
	awsCfg   aws.Config
	bgLogs   *LogCapture
}

// New creates a session with explicitly declared resources.
// It creates a temporary directory with a minimal Terraform stub so ldk
// can start without requiring a real project directory.
func New(spec SessionSpec) (*Session, error) {
	tmpDir, err := os.MkdirTemp("", "lws-testing-")
	if err != nil {
		return nil, fmt.Errorf("failed to create temp dir: %w", err)
	}
	// ldk.yaml: empty services block
	if err := os.WriteFile(filepath.Join(tmpDir, "ldk.yaml"), []byte("services:\n"), 0600); err != nil {
		os.RemoveAll(tmpDir) //nolint:errcheck
		return nil, fmt.Errorf("failed to write ldk.yaml: %w", err)
	}
	// ldk requires at least one .tf file to detect the project as Terraform mode
	if err := os.WriteFile(filepath.Join(tmpDir, "main.tf"), []byte("# local-web-services testing session\n"), 0600); err != nil {
		os.RemoveAll(tmpDir) //nolint:errcheck
		return nil, fmt.Errorf("failed to write main.tf: %w", err)
	}
	return newSession(tmpDir, spec)
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

func newSession(projectDir string, spec SessionSpec) (*Session, error) {
	basePort, err := findFreePort()
	if err != nil {
		return nil, fmt.Errorf("failed to find free port: %w", err)
	}

	cmd := exec.Command("ldk", "dev",
		"--project-dir", projectDir,
		"--port", fmt.Sprintf("%d", basePort),
	)
	cmd.Stdout = io.Discard
	cmd.Stderr = io.Discard
	if err := cmd.Start(); err != nil {
		return nil, fmt.Errorf("failed to start ldk: %w", err)
	}

	awsCfg, err := config.LoadDefaultConfig(context.Background(),
		config.WithRegion("us-east-1"),
		config.WithCredentialsProvider(
			credentials.NewStaticCredentialsProvider("test", "test", ""),
		),
	)
	if err != nil {
		cmd.Process.Kill() //nolint:errcheck
		return nil, fmt.Errorf("failed to load AWS config: %w", err)
	}

	session := &Session{basePort: basePort, cmd: cmd, awsCfg: awsCfg}

	if err := session.awaitReady(); err != nil {
		cmd.Process.Kill() //nolint:errcheck
		return nil, err
	}

	if err := session.preCreateResources(spec); err != nil {
		cmd.Process.Kill() //nolint:errcheck
		return nil, err
	}

	if bgLogs, err := newLogCapture(session); err == nil {
		session.bgLogs = bgLogs
	}

	return session, nil
}

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

// Chaos returns a ChaosBuilder for the given service (e.g. "stepfunctions").
func (s *Session) Chaos(service string) *ChaosBuilder {
	return &ChaosBuilder{session: s, service: service}
}

// StartLogCapture connects to the WebSocket log stream and begins recording entries.
func (s *Session) StartLogCapture() (*LogCapture, error) {
	return newLogCapture(s)
}

// Close stops the background log capture and the ldk dev process.
func (s *Session) Close() {
	if s.bgLogs != nil {
		s.bgLogs.Stop()
		s.bgLogs = nil
	}
	if s.cmd != nil && s.cmd.Process != nil {
		s.cmd.Process.Kill() //nolint:errcheck
		s.cmd.Wait()         //nolint:errcheck
	}
}

// Iam returns an IamBuilder for configuring IAM authentication mode.
func (s *Session) Iam() *IamBuilder {
	return &IamBuilder{
		session:    s,
		updates:    make(map[string]any),
		identities: make(map[string]*IdentityBuilder),
	}
}

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

func (s *Session) awaitReady() error {
	statusURL := fmt.Sprintf("http://127.0.0.1:%d/_ldk/status", s.basePort)
	for {
		deadline := time.Now().Add(30 * time.Second)
		for time.Now().Before(deadline) {
			if s.cmd.ProcessState != nil {
				return fmt.Errorf("ldk dev process exited unexpectedly")
			}
			resp, err := http.Get(statusURL) //nolint:noctx
			if err == nil && resp.StatusCode < 400 {
				body, readErr := io.ReadAll(resp.Body)
				resp.Body.Close()
				if readErr == nil && bytes.Contains(body, []byte(`"running":true`)) {
					return nil
				}
			} else if resp != nil {
				resp.Body.Close()
			}
			time.Sleep(500 * time.Millisecond)
		}
		// Not ready within the window — wait 15 s and try again rather than failing.
		fmt.Println("[lws] ldk dev not ready after 30 s, retrying in 15 s...")
		time.Sleep(15 * time.Second)
	}
}

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
				Name:      aws.String(p),
				Value:     aws.String(""),
				Type:      ssmtypes.ParameterTypeString,
				Overwrite: aws.Bool(true),
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

func findFreePort() (int, error) {
	l, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		return 0, err
	}
	defer l.Close()
	return l.Addr().(*net.TCPAddr).Port, nil
}
