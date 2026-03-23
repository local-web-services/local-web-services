module github.com/local-web-services/local-web-services-sdk-go-example-project

go 1.24

require (
	github.com/aws/aws-sdk-go-v2 v1.41.4
	github.com/aws/aws-sdk-go-v2/service/dynamodb v1.34.0
	github.com/aws/aws-sdk-go-v2/service/sfn v1.30.0
	github.com/aws/aws-sdk-go-v2/service/sqs v1.34.0
	github.com/cucumber/godog v0.15.0
	github.com/local-web-services/local-web-services-go-sdk v0.2.2
)

replace github.com/local-web-services/local-web-services-go-sdk => ../sdk

replace github.com/local-web-services/local-web-services-go-core => ../core

require (
	github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream v1.7.7 // indirect
	github.com/aws/aws-sdk-go-v2/config v1.27.0 // indirect
	github.com/aws/aws-sdk-go-v2/credentials v1.17.0 // indirect
	github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.15.0 // indirect
	github.com/aws/aws-sdk-go-v2/internal/configsources v1.4.20 // indirect
	github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.7.20 // indirect
	github.com/aws/aws-sdk-go-v2/internal/ini v1.8.0 // indirect
	github.com/aws/aws-sdk-go-v2/internal/v4a v1.3.13 // indirect
	github.com/aws/aws-sdk-go-v2/service/apigateway v1.39.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider v1.59.2 // indirect
	github.com/aws/aws-sdk-go-v2/service/docdb v1.48.12 // indirect
	github.com/aws/aws-sdk-go-v2/service/elasticache v1.51.12 // indirect
	github.com/aws/aws-sdk-go-v2/service/elasticsearchservice v1.39.1 // indirect
	github.com/aws/aws-sdk-go-v2/service/glacier v1.32.5 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.13.7 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/checksum v1.3.15 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/endpoint-discovery v1.9.13 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.13.20 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/s3shared v1.17.13 // indirect
	github.com/aws/aws-sdk-go-v2/service/lambda v1.88.3 // indirect
	github.com/aws/aws-sdk-go-v2/service/memorydb v1.33.13 // indirect
	github.com/aws/aws-sdk-go-v2/service/neptune v1.44.2 // indirect
	github.com/aws/aws-sdk-go-v2/service/opensearch v1.60.1 // indirect
	github.com/aws/aws-sdk-go-v2/service/organizations v1.50.5 // indirect
	github.com/aws/aws-sdk-go-v2/service/rds v1.116.3 // indirect
	github.com/aws/aws-sdk-go-v2/service/s3 v1.58.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/s3tables v1.14.3 // indirect
	github.com/aws/aws-sdk-go-v2/service/secretsmanager v1.32.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/sns v1.31.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssm v1.52.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/sso v1.19.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssooidc v1.22.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/sts v1.27.0 // indirect
	github.com/aws/smithy-go v1.24.2 // indirect
	github.com/cucumber/gherkin/go/v26 v26.2.0 // indirect
	github.com/cucumber/messages/go/v21 v21.0.1 // indirect
	github.com/gofrs/uuid v4.3.1+incompatible // indirect
	github.com/gorilla/websocket v1.5.3 // indirect
	github.com/hashicorp/go-immutable-radix v1.3.1 // indirect
	github.com/hashicorp/go-memdb v1.3.4 // indirect
	github.com/hashicorp/golang-lru v0.5.4 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/local-web-services/local-web-services-go-core v0.0.0 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
)
