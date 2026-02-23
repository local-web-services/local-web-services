# local-web-services-go-sdk

Go testing SDK for [local-web-services](https://local-web-services.github.io) — spawns `ldk dev` as a subprocess and provides pre-configured AWS SDK v2 clients pointing at the local emulators. No AWS account or credentials required.

## Prerequisites

Install `local-web-services`:

```bash
pip install local-web-services
```

This installs the `ldk` binary that the SDK uses to start the local AWS emulators.

## Installation

```bash
go get github.com/local-web-services/local-web-services-go-sdk
```

## Quick start

### Auto-discover from Terraform

```go
import "github.com/local-web-services/local-web-services-go-sdk/lws"

func TestProcessOrder(t *testing.T) {
    // FromHcl reads your .tf files, starts ldk dev, and pre-creates
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

### Explicit resource declaration

```go
spec := lws.SessionSpec{
    Tables: []lws.TableSpec{
        {Name: "Orders", PartitionKey: "id"},
    },
    Queues: []string{"OrderQueue"},
    StateMachines: []lws.StateMachineSpec{
        {Name: "OrderProcessor", Definition: definitionJSON},
    },
}

session, err := lws.New(spec)
if err != nil {
    t.Fatal(err)
}
defer session.Close()

dynamoClient := session.DynamoDBClient()
sqsClient := session.SQSClient()
sfnClient := session.SFNClient()
```

## Go testing example

```go
// order_processor_test.go
package main

import (
    "context"
    "testing"

    "github.com/aws/aws-sdk-go-v2/service/sfn"
    "github.com/local-web-services/local-web-services-go-sdk/lws"
)

func TestProcessOrder_runsStateMachineAndReturnsResult(t *testing.T) {
    // Start ldk dev and discover resources from terraform/
    session, err := lws.FromHcl("terraform")
    if err != nil {
        t.Fatalf("failed to start lws session: %v", err)
    }
    defer session.Close()

    sfnClient := session.SFNClient()

    // Resolve the state machine ARN
    result, err := sfnClient.ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
    if err != nil || len(result.StateMachines) == 0 {
        t.Fatalf("could not list state machines: %v", err)
    }
    stateMachineArn := *result.StateMachines[0].StateMachineArn

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

### `Session`

| Method | Description |
|--------|-------------|
| `lws.FromHcl(projectDir)` | Auto-discover resources from Terraform `.tf` files and start `ldk dev` |
| `lws.New(spec)` | Start `ldk dev` with explicitly declared resources |
| `session.DynamoDBClient()` | Pre-configured `*dynamodb.Client` |
| `session.SQSClient()` | Pre-configured `*sqs.Client` |
| `session.S3Client()` | Pre-configured `*s3.Client` |
| `session.SNSClient()` | Pre-configured `*sns.Client` |
| `session.SFNClient()` | Pre-configured `*sfn.Client` |
| `session.SSMClient()` | Pre-configured `*ssm.Client` |
| `session.SecretsManagerClient()` | Pre-configured `*secretsmanager.Client` |
| `session.PortFor(service)` | Port number for a named service |
| `session.QueueURL(queueName)` | Local SQS queue URL |
| `session.Close()` | Stop `ldk dev` |

### `SessionSpec`

```go
type SessionSpec struct {
    Tables        []TableSpec
    Queues        []string
    StateMachines []StateMachineSpec
}

type TableSpec struct {
    Name         string
    PartitionKey string
    SortKey      string // optional
}

type StateMachineSpec struct {
    Name       string
    Definition string // JSON state machine definition
    RoleArn    string // optional, defaults to a local test ARN
}
```

### Supported services

`dynamodb`, `s3`, `sqs`, `sns`, `ssm`, `secretsmanager`, `stepfunctions`

## License

MIT
