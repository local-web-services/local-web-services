# local-web-services Go SDK — Example Project

An example project showing how to test an AWS Step Functions workflow using the [local-web-services Go SDK](https://github.com/local-web-services/local-web-services-go-sdk).

## What this example does

- Defines a simple `OrderProcessor` struct that starts a Step Functions execution and waits for it to complete
- Uses `lws.FromHcl()` to run a local Step Functions emulator during tests — no AWS account or credentials required
- Discovers the state machine definition from `terraform/main.tf` automatically
- Tests pass on any machine with Go and `local-web-services` installed

## Project structure

```
order_processor.go         # Production code — plain AWS SDK v2, no test-specific config
order_processor_test.go    # Go tests using lws.FromHcl()
terraform/
  main.tf                  # Terraform config declaring the OrderProcessor state machine
```

## Prerequisites

```bash
pip install local-web-services   # installs the ldk binary
```

## Running the tests

```bash
go test ./... -v
```

## How it works

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
    // Start ldk dev and discover resources declared in terraform/main.tf
    // The OrderProcessor state machine is created automatically
    session, err := lws.FromHcl("terraform")
    if err != nil {
        t.Fatalf("failed to start lws session: %v", err)
    }
    defer session.Close()  // stops ldk dev

    sfnClient := session.SFNClient()  // pre-configured client pointing at local SFN emulator

    // Resolve the ARN of the state machine provisioned from main.tf
    result, _ := sfnClient.ListStateMachines(context.Background(), &sfn.ListStateMachinesInput{})
    stateMachineArn := *result.StateMachines[0].StateMachineArn

    // Pass the local SFN client — production code accepts an optional client
    // for testability; in production it creates one with default AWS settings
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

## Links

- [local-web-services](https://github.com/local-web-services/local-web-services) — the core tool
- [Go SDK](https://github.com/local-web-services/local-web-services-go-sdk) — `github.com/local-web-services/local-web-services-go-sdk`
