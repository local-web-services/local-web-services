# local-web-services-go-sdk

Go testing SDK for [local-web-services](https://local-web-services.github.io) — starts an
in-process LWS server and provides pre-configured AWS SDK v2 clients pointing at the local
emulators. No AWS account, credentials, or Docker required.

## Installation

```bash
go get github.com/local-web-services/local-web-services-go-sdk
```

## Quick start

### Auto-discover from Terraform

```go
import "github.com/local-web-services/local-web-services-go-sdk/lws"

func TestProcessOrder(t *testing.T) {
    // FromHcl reads your .tf files, starts the in-process server, and pre-creates
    // all declared resources (tables, queues, state machines, etc.)
    session, err := lws.FromHcl("terraform")
    if err != nil {
        t.Fatal(err)
    }
    defer session.Close()

    sfnClient := session.SFNClient()
    // state machine already exists — run your test
}
```

### Auto-discover from CDK

```go
session, err := lws.FromCdk("../my-cdk-project")
if err != nil {
    t.Fatal(err)
}
defer session.Close()
```

### Explicit resource declaration

```go
spec := lws.SessionSpec{
    Tables: []lws.TableSpec{
        {Name: "Orders", PartitionKey: "id"},
    },
    Queues:  []string{"OrderQueue"},
    Buckets: []string{"ReceiptsBucket"},
}

session, err := lws.New(spec)
if err != nil {
    t.Fatal(err)
}
defer session.Close()

dynamoClient := session.DynamoDBClient()
sqsClient    := session.SQSClient()
s3Client     := session.S3Client()
```

## Full test example

```go
package orders_test

import (
    "context"
    "testing"

    "github.com/aws/aws-sdk-go-v2/aws"
    "github.com/aws/aws-sdk-go-v2/service/sfn"
    "github.com/local-web-services/local-web-services-go-sdk/lws"
)

func TestProcessOrder_runsStateMachineAndReturnsResult(t *testing.T) {
    session, err := lws.FromHcl("terraform")
    if err != nil {
        t.Fatalf("failed to start lws session: %v", err)
    }
    defer session.Close()

    sfnClient := session.SFNClient()

    result, err := sfnClient.ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
    if err != nil || len(result.StateMachines) == 0 {
        t.Fatalf("could not list state machines: %v", err)
    }
    stateMachineArn := aws.ToString(result.StateMachines[0].StateMachineArn)

    processor := NewOrderProcessor(sfnClient)
    output, err := processor.ProcessOrder(context.Background(), "order-001", stateMachineArn)
    if err != nil {
        t.Fatalf("ProcessOrder returned error: %v", err)
    }
    if output["orderId"] != "order-001" {
        t.Errorf("got orderId %q, want %q", output["orderId"], "order-001")
    }
}
```

## API

### Session constructors

| Constructor | Description |
|---|---|
| `lws.FromHcl(projectDir)` | Auto-discover resources from Terraform `.tf` files |
| `lws.FromCdk(projectDir)` | Auto-discover resources from CDK cloud assembly |
| `lws.New(spec)` | Start with explicitly declared resources |
| `lws.NewInProcessSession()` | Start a bare session with no pre-created resources |

### Client methods

| Method | Returns |
|---|---|
| `session.DynamoDBClient()` | `*dynamodb.Client` |
| `session.SQSClient()` | `*sqs.Client` |
| `session.S3Client()` | `*s3.Client` |
| `session.SNSClient()` | `*sns.Client` |
| `session.SFNClient()` | `*sfn.Client` |
| `session.SSMClient()` | `*ssm.Client` |
| `session.SecretsManagerClient()` | `*secretsmanager.Client` |

### Helpers

| Method | Description |
|---|---|
| `session.PortFor(service)` | Port number for a named service |
| `session.QueueURL(queueName)` | Local SQS queue URL |
| `session.Close()` | Stop the in-process server |

## Supported services

All 20 services are available. Use `session.PortFor(name)` to get the port for any service
not yet covered by a typed client method:

| Service | Name |
|---|---|
| DynamoDB | `"dynamodb"` |
| SQS | `"sqs"` |
| S3 | `"s3"` |
| SNS | `"sns"` |
| EventBridge | `"eventbridge"` |
| Step Functions | `"stepfunctions"` |
| Cognito IDP | `"cognitoidp"` |
| Lambda | `"lambda"` |
| API Gateway | `"apigateway"` |
| RDS | `"rds"` |
| DocumentDB | `"docdb"` |
| SSM Parameter Store | `"ssm"` |
| Secrets Manager | `"secretsmanager"` |
| ElastiCache | `"elasticache"` |
| Neptune | `"neptune"` |
| MemoryDB | `"memorydb"` |
| Glacier | `"glacier"` |
| Elasticsearch | `"elasticsearch"` |
| OpenSearch | `"opensearch"` |
| S3 Tables | `"s3tables"` |

## How it works

`lws.New` / `lws.FromHcl` starts the Go LWS core as an in-process goroutine on a randomly
chosen base port. Each service listens at `basePort + offset`. The session returns AWS SDK v2
clients pre-configured with `http://127.0.0.1:<port>` endpoint overrides and stub credentials
(`AWS_ACCESS_KEY_ID=test`). When `Close()` is called the server shuts down cleanly.

## License

MIT
