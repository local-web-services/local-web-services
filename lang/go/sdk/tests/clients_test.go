package tests

import (
	"context"
	"fmt"
	"strings"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/service/apigateway"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	"github.com/aws/aws-sdk-go-v2/service/docdb"
	"github.com/aws/aws-sdk-go-v2/service/dynamodb"
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
	"github.com/cucumber/godog"
)

func registerClientSteps(sc *godog.ScenarioContext, world *World) {
	// When I request a client for "<service>"
	sc.When(`^I request a client for "([^"]*)"$`, func(service string) error {
		world.lastResult = LastResult{Success: true, Output: service}
		return nil
	})

	// Then a configured client is returned
	sc.Then(`^a configured client is returned$`, func() error {
		if !world.lastResult.Success {
			return fmt.Errorf("expected a client to be returned but got error: %v", world.lastResult.Error)
		}
		return nil
	})

	// And the client can successfully call the <service> service
	sc.Then(`^the client can successfully call the ([^ ]+) service$`, func(service string) error {
		return callService(world, service)
	})
}

// callService makes a basic list/describe call against the named service to verify the client works.
func callService(world *World, service string) error {
	ctx := context.Background()
	service = strings.TrimSpace(service)

	switch service {
	case "dynamodb":
		_, err := world.DynamoDBClient().ListTables(ctx, &dynamodb.ListTablesInput{})
		return err
	case "sqs":
		_, err := world.SQSClient().ListQueues(ctx, &sqs.ListQueuesInput{})
		return err
	case "s3":
		_, err := world.S3Client().ListBuckets(ctx, &s3.ListBucketsInput{})
		return err
	case "sns":
		_, err := world.SNSClient().ListTopics(ctx, &sns.ListTopicsInput{})
		return err
	case "stepfunctions":
		_, err := world.SFNClient().ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		return err
	case "ssm":
		_, err := world.SSMClient().DescribeParameters(ctx, &ssm.DescribeParametersInput{})
		return err
	case "secretsmanager":
		_, err := world.SecretsManagerClient().ListSecrets(ctx, &secretsmanager.ListSecretsInput{})
		return err
	case "cognitoidp":
		_, err := world.CognitoIDPClient().ListUserPools(ctx, &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(10),
		})
		return err
	case "apigateway":
		_, err := world.APIGatewayClient().GetRestApis(ctx, &apigateway.GetRestApisInput{})
		return err
	case "lambda":
		_, err := world.LambdaClient().ListFunctions(ctx, &lambda.ListFunctionsInput{})
		return err
	case "organizations":
		_, err := world.OrganizationsClient().ListAccounts(ctx, &organizations.ListAccountsInput{})
		return err
	case "rds":
		_, err := world.RDSClient().DescribeDBInstances(ctx, &rds.DescribeDBInstancesInput{})
		return err
	case "docdb":
		_, err := world.DocDBClient().DescribeDBClusters(ctx, &docdb.DescribeDBClustersInput{})
		return err
	case "neptune":
		_, err := world.NeptuneClient().DescribeDBClusters(ctx, &neptune.DescribeDBClustersInput{})
		return err
	case "elasticache":
		_, err := world.ElastiCacheClient().DescribeCacheClusters(ctx, &elasticache.DescribeCacheClustersInput{})
		return err
	case "memorydb":
		_, err := world.MemoryDBClient().DescribeClusters(ctx, &memorydb.DescribeClustersInput{})
		return err
	case "glacier":
		_, err := world.GlacierClient().ListVaults(ctx, &glacier.ListVaultsInput{
			AccountId: aws.String("-"),
		})
		return err
	case "elasticsearch":
		_, err := world.ElasticsearchClient().ListDomainNames(ctx, &elasticsearchservice.ListDomainNamesInput{})
		return err
	case "opensearch":
		_, err := world.OpenSearchClient().ListDomainNames(ctx, &opensearch.ListDomainNamesInput{})
		return err
	case "s3tables":
		_, err := world.S3TablesClient().ListTableBuckets(ctx, &s3tables.ListTableBucketsInput{})
		return err
	default:
		return fmt.Errorf("unknown service: %s", service)
	}
}

// dispatchServiceCall makes a named service call and stores the result in world.lastResult.
// This is shared by chaos, fake, IAM, and log capture test steps.
func dispatchServiceCall(world *World, service, operation string) error {
	ctx := context.Background()

	switch service {
	case "dynamodb":
		return callDynamoDBOp(world, ctx, operation)
	case "sqs":
		return callSQSOp(world, ctx, operation)
	case "s3":
		return callS3Op(world, ctx, operation)
	case "sns":
		return callSNSOp(world, ctx, operation)
	case "stepfunctions":
		return callSFNOp(world, ctx, operation)
	case "ssm":
		return callSSMOp(world, ctx, operation)
	case "secretsmanager":
		return callSecretsManagerOp(world, ctx, operation)
	case "cognitoidp":
		return callCognitoIDPOp(world, ctx, operation)
	case "apigateway":
		return callAPIGatewayOp(world, ctx, operation)
	case "lambda":
		return callLambdaOp(world, ctx, operation)
	case "organizations":
		return callOrganizationsOp(world, ctx, operation)
	case "rds":
		return callRDSOp(world, ctx, operation)
	case "docdb":
		return callDocDBOp(world, ctx, operation)
	case "neptune":
		return callNeptuneOp(world, ctx, operation)
	case "elasticache":
		return callElastiCacheOp(world, ctx, operation)
	case "memorydb":
		return callMemoryDBOp(world, ctx, operation)
	case "glacier":
		return callGlacierOp(world, ctx, operation)
	case "elasticsearch":
		return callElasticsearchOp(world, ctx, operation)
	case "opensearch":
		return callOpenSearchOp(world, ctx, operation)
	case "s3tables":
		return callS3TablesOp(world, ctx, operation)
	default:
		return fmt.Errorf("unsupported service: %s", service)
	}
}

func callDynamoDBOp(world *World, ctx context.Context, operation string) error {
	client := world.DynamoDBClient()
	switch operation {
	case "ListTables":
		result, err := client.ListTables(ctx, &dynamodb.ListTablesInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported dynamodb operation: %s", operation)
	}
	return nil
}

func callSQSOp(world *World, ctx context.Context, operation string) error {
	client := world.SQSClient()
	switch operation {
	case "ListQueues":
		result, err := client.ListQueues(ctx, &sqs.ListQueuesInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported sqs operation: %s", operation)
	}
	return nil
}

func callS3Op(world *World, ctx context.Context, operation string) error {
	client := world.S3Client()
	switch operation {
	case "ListBuckets":
		result, err := client.ListBuckets(ctx, &s3.ListBucketsInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported s3 operation: %s", operation)
	}
	return nil
}

func callSNSOp(world *World, ctx context.Context, operation string) error {
	client := world.SNSClient()
	switch operation {
	case "ListTopics":
		result, err := client.ListTopics(ctx, &sns.ListTopicsInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported sns operation: %s", operation)
	}
	return nil
}

func callSFNOp(world *World, ctx context.Context, operation string) error {
	client := world.SFNClient()
	smArn := world.lastStateMachineArn
	if smArn == "" {
		smArn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
	}

	switch operation {
	case "StartExecution":
		result, err := client.StartExecution(ctx, &sfn.StartExecutionInput{
			StateMachineArn: aws.String(smArn),
			Input:           aws.String("{}"),
		})
		setResult(world, result, err)
		if err == nil && result.ExecutionArn != nil {
			world.lastExecArn = *result.ExecutionArn
		}
	case "ListStateMachines":
		result, err := client.ListStateMachines(ctx, &sfn.ListStateMachinesInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported stepfunctions operation: %s", operation)
	}
	return nil
}

func callSSMOp(world *World, ctx context.Context, operation string) error {
	client := world.SSMClient()
	switch operation {
	case "DescribeParameters":
		result, err := client.DescribeParameters(ctx, &ssm.DescribeParametersInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported ssm operation: %s", operation)
	}
	return nil
}

func callSecretsManagerOp(world *World, ctx context.Context, operation string) error {
	client := world.SecretsManagerClient()
	switch operation {
	case "ListSecrets":
		result, err := client.ListSecrets(ctx, &secretsmanager.ListSecretsInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported secretsmanager operation: %s", operation)
	}
	return nil
}

func callCognitoIDPOp(world *World, ctx context.Context, operation string) error {
	client := world.CognitoIDPClient()
	switch operation {
	case "ListUserPools":
		result, err := client.ListUserPools(ctx, &cognitoidentityprovider.ListUserPoolsInput{
			MaxResults: aws.Int32(10),
		})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported cognitoidp operation: %s", operation)
	}
	return nil
}

func callAPIGatewayOp(world *World, ctx context.Context, operation string) error {
	client := world.APIGatewayClient()
	switch operation {
	case "GetRestApis":
		result, err := client.GetRestApis(ctx, &apigateway.GetRestApisInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported apigateway operation: %s", operation)
	}
	return nil
}

func callLambdaOp(world *World, ctx context.Context, operation string) error {
	client := world.LambdaClient()
	switch operation {
	case "ListFunctions":
		result, err := client.ListFunctions(ctx, &lambda.ListFunctionsInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported lambda operation: %s", operation)
	}
	return nil
}

func callOrganizationsOp(world *World, ctx context.Context, operation string) error {
	client := world.OrganizationsClient()
	switch operation {
	case "ListAccounts":
		result, err := client.ListAccounts(ctx, &organizations.ListAccountsInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported organizations operation: %s", operation)
	}
	return nil
}

func callRDSOp(world *World, ctx context.Context, operation string) error {
	client := world.RDSClient()
	switch operation {
	case "DescribeDBInstances":
		result, err := client.DescribeDBInstances(ctx, &rds.DescribeDBInstancesInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported rds operation: %s", operation)
	}
	return nil
}

func callDocDBOp(world *World, ctx context.Context, operation string) error {
	client := world.DocDBClient()
	switch operation {
	case "DescribeDBClusters":
		result, err := client.DescribeDBClusters(ctx, &docdb.DescribeDBClustersInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported docdb operation: %s", operation)
	}
	return nil
}

func callNeptuneOp(world *World, ctx context.Context, operation string) error {
	client := world.NeptuneClient()
	switch operation {
	case "DescribeDBClusters":
		result, err := client.DescribeDBClusters(ctx, &neptune.DescribeDBClustersInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported neptune operation: %s", operation)
	}
	return nil
}

func callElastiCacheOp(world *World, ctx context.Context, operation string) error {
	client := world.ElastiCacheClient()
	switch operation {
	case "DescribeCacheClusters":
		result, err := client.DescribeCacheClusters(ctx, &elasticache.DescribeCacheClustersInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported elasticache operation: %s", operation)
	}
	return nil
}

func callMemoryDBOp(world *World, ctx context.Context, operation string) error {
	client := world.MemoryDBClient()
	switch operation {
	case "DescribeClusters":
		result, err := client.DescribeClusters(ctx, &memorydb.DescribeClustersInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported memorydb operation: %s", operation)
	}
	return nil
}

func callGlacierOp(world *World, ctx context.Context, operation string) error {
	client := world.GlacierClient()
	switch operation {
	case "ListVaults":
		result, err := client.ListVaults(ctx, &glacier.ListVaultsInput{
			AccountId: aws.String("-"),
		})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported glacier operation: %s", operation)
	}
	return nil
}

func callElasticsearchOp(world *World, ctx context.Context, operation string) error {
	client := world.ElasticsearchClient()
	switch operation {
	case "ListDomainNames":
		result, err := client.ListDomainNames(ctx, &elasticsearchservice.ListDomainNamesInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported elasticsearch operation: %s", operation)
	}
	return nil
}

func callOpenSearchOp(world *World, ctx context.Context, operation string) error {
	client := world.OpenSearchClient()
	switch operation {
	case "ListDomainNames":
		result, err := client.ListDomainNames(ctx, &opensearch.ListDomainNamesInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported opensearch operation: %s", operation)
	}
	return nil
}

func callS3TablesOp(world *World, ctx context.Context, operation string) error {
	client := world.S3TablesClient()
	switch operation {
	case "ListTableBuckets":
		result, err := client.ListTableBuckets(ctx, &s3tables.ListTableBucketsInput{})
		setResult(world, result, err)
	default:
		return fmt.Errorf("unsupported s3tables operation: %s", operation)
	}
	return nil
}
