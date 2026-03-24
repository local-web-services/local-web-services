package lws

import (
	"context"
	"fmt"
	"net"
	"net/http"

	"github.com/local-web-services/local-web-services-go-core/lws/providers/apigateway"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/cognitoidp"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/docdb"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/dynamodb"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/elasticache"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/elasticsearch"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/eventbridge"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/glacier"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/lambda"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/memorydb"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/neptune"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/opensearch"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/organizations"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/rds"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/s3"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/s3tables"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/secretsmanager"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/sns"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/sqs"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/ssm"
	"github.com/local-web-services/local-web-services-go-core/lws/providers/stepfunctions"
)

// ServiceOffsets defines port offsets for each service.
var ServiceOffsets = map[string]int{
	"dynamodb":       1,
	"sqs":            2,
	"s3":             3,
	"sns":            4,
	"eventbridge":    5,
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

// Server represents a running local AWS services server.
type Server struct {
	BasePort   int
	State      *ServerState
	listeners  []net.Listener
	servers    []*http.Server
	shutdownCh chan struct{}
}

// StartServer starts all service HTTP servers on basePort offsets.
func StartServer(basePort int) (*Server, error) {
	state := NewServerState()
	shutdownCh := make(chan struct{}, 1)

	srv := &Server{
		BasePort:   basePort,
		State:      state,
		shutdownCh: shutdownCh,
	}

	// Management server
	mgmtMux := http.NewServeMux()
	RegisterManagementAPI(mgmtMux, state, shutdownCh)
	if err := srv.startService(mgmtMux, basePort); err != nil {
		srv.Close()
		return nil, fmt.Errorf("management server: %w", err)
	}

	// DynamoDB
	ddbMux := http.NewServeMux()
	ddbMux.Handle("/", dynamodb.NewHandler(state))
	if err := srv.startService(ddbMux, basePort+ServiceOffsets["dynamodb"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("dynamodb server: %w", err)
	}

	// SQS
	sqsPort := basePort + ServiceOffsets["sqs"]
	sqsMux := http.NewServeMux()
	sqsMux.Handle("/", sqs.NewHandler(state, sqsPort))
	if err := srv.startService(sqsMux, sqsPort); err != nil {
		srv.Close()
		return nil, fmt.Errorf("sqs server: %w", err)
	}

	// S3
	ebPort := basePort + ServiceOffsets["eventbridge"]
	s3Mux := http.NewServeMux()
	s3Mux.Handle("/", s3.NewHandler(state, sqsPort, ebPort, basePort+ServiceOffsets["sns"]))
	if err := srv.startService(s3Mux, basePort+ServiceOffsets["s3"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("s3 server: %w", err)
	}

	// SNS
	snsPort := basePort + ServiceOffsets["sns"]
	snsMux := http.NewServeMux()
	snsMux.Handle("/", sns.NewHandler(state, sqsPort))
	if err := srv.startService(snsMux, snsPort); err != nil {
		srv.Close()
		return nil, fmt.Errorf("sns server: %w", err)
	}

	// EventBridge
	sfnPort := basePort + ServiceOffsets["stepfunctions"]
	ebMux := http.NewServeMux()
	ebMux.Handle("/", eventbridge.NewHandler(state, sqsPort, snsPort, sfnPort, basePort+ServiceOffsets["dynamodb"]))
	if err := srv.startService(ebMux, ebPort); err != nil {
		srv.Close()
		return nil, fmt.Errorf("eventbridge server: %w", err)
	}

	// Step Functions
	sfnMux := http.NewServeMux()
	sfnMux.Handle("/", stepfunctions.NewHandler(state, stepfunctions.ServicePorts{
		DynamoDB:       basePort + ServiceOffsets["dynamodb"],
		SQS:            sqsPort,
		S3:             basePort + ServiceOffsets["s3"],
		SNS:            snsPort,
		SecretsManager: basePort + ServiceOffsets["secretsmanager"],
		SSM:            basePort + ServiceOffsets["ssm"],
		EventBridge:    ebPort,
	}))
	if err := srv.startService(sfnMux, sfnPort); err != nil {
		srv.Close()
		return nil, fmt.Errorf("stepfunctions server: %w", err)
	}

	// Cognito IDP
	cognitoMux := http.NewServeMux()
	cognitoMux.Handle("/", cognitoidp.NewHandler(state))
	if err := srv.startService(cognitoMux, basePort+ServiceOffsets["cognitoidp"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("cognitoidp server: %w", err)
	}

	// Lambda
	lambdaMux := http.NewServeMux()
	lambdaMux.Handle("/", lambda.NewHandler(state))
	if err := srv.startService(lambdaMux, basePort+ServiceOffsets["lambda"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("lambda server: %w", err)
	}

	// API Gateway
	apigwMux := http.NewServeMux()
	apigwMux.Handle("/", apigateway.NewHandler(state))
	if err := srv.startService(apigwMux, basePort+ServiceOffsets["apigateway"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("apigateway server: %w", err)
	}

	// SSM
	ssmMux := http.NewServeMux()
	ssmMux.Handle("/", ssm.NewHandler(state))
	if err := srv.startService(ssmMux, basePort+ServiceOffsets["ssm"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("ssm server: %w", err)
	}

	// SecretsManager
	smMux := http.NewServeMux()
	smMux.Handle("/", secretsmanager.NewHandler(state))
	if err := srv.startService(smMux, basePort+ServiceOffsets["secretsmanager"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("secretsmanager server: %w", err)
	}

	// RDS
	rdsMux := http.NewServeMux()
	rdsMux.Handle("/", rds.NewHandler(state))
	if err := srv.startService(rdsMux, basePort+ServiceOffsets["rds"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("rds server: %w", err)
	}

	// DocDB
	docdbMux := http.NewServeMux()
	docdbMux.Handle("/", docdb.NewHandler(state))
	if err := srv.startService(docdbMux, basePort+ServiceOffsets["docdb"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("docdb server: %w", err)
	}

	// ElastiCache
	ecMux := http.NewServeMux()
	ecMux.Handle("/", elasticache.NewHandler(state))
	if err := srv.startService(ecMux, basePort+ServiceOffsets["elasticache"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("elasticache server: %w", err)
	}

	// Neptune
	neptuneMux := http.NewServeMux()
	neptuneMux.Handle("/", neptune.NewHandler(state))
	if err := srv.startService(neptuneMux, basePort+ServiceOffsets["neptune"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("neptune server: %w", err)
	}

	// MemoryDB
	memorydbMux := http.NewServeMux()
	memorydbMux.Handle("/", memorydb.NewHandler(state))
	if err := srv.startService(memorydbMux, basePort+ServiceOffsets["memorydb"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("memorydb server: %w", err)
	}

	// Glacier
	glacierMux := http.NewServeMux()
	glacierMux.Handle("/", glacier.NewHandler(state))
	if err := srv.startService(glacierMux, basePort+ServiceOffsets["glacier"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("glacier server: %w", err)
	}

	// Elasticsearch
	esMux := http.NewServeMux()
	esMux.Handle("/", elasticsearch.NewHandler(state))
	if err := srv.startService(esMux, basePort+ServiceOffsets["elasticsearch"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("elasticsearch server: %w", err)
	}

	// OpenSearch
	osMux := http.NewServeMux()
	osMux.Handle("/", opensearch.NewHandler(state))
	if err := srv.startService(osMux, basePort+ServiceOffsets["opensearch"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("opensearch server: %w", err)
	}

	// S3 Tables
	s3tablesMux := http.NewServeMux()
	s3tablesMux.Handle("/", s3tables.NewHandler(state))
	if err := srv.startService(s3tablesMux, basePort+ServiceOffsets["s3tables"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("s3tables server: %w", err)
	}

	// Organizations
	orgsMux := http.NewServeMux()
	orgsMux.Handle("/", organizations.NewHandler(state))
	if err := srv.startService(orgsMux, basePort+ServiceOffsets["organizations"]); err != nil {
		srv.Close()
		return nil, fmt.Errorf("organizations server: %w", err)
	}

	return srv, nil
}

func (s *Server) startService(handler http.Handler, port int) error {
	ln, err := net.Listen("tcp", fmt.Sprintf("127.0.0.1:%d", port))
	if err != nil {
		return err
	}
	s.listeners = append(s.listeners, ln)

	httpSrv := &http.Server{Handler: handler}
	s.servers = append(s.servers, httpSrv)

	go httpSrv.Serve(ln) //nolint:errcheck

	return nil
}

// Close shuts down all service servers.
func (s *Server) Close() {
	for _, srv := range s.servers {
		srv.Shutdown(context.Background()) //nolint:errcheck
	}
	for _, ln := range s.listeners {
		ln.Close() //nolint:errcheck
	}
}

// ManagementURL returns the management API base URL.
func (s *Server) ManagementURL() string {
	return fmt.Sprintf("http://127.0.0.1:%d", s.BasePort)
}

// PortFor returns the port for a given service name.
func (s *Server) PortFor(service string) int {
	offset, ok := ServiceOffsets[service]
	if !ok {
		return 0
	}
	return s.BasePort + offset
}

// FindFreePort finds an available TCP port.
func FindFreePort() (int, error) {
	ln, err := net.Listen("tcp", "127.0.0.1:0")
	if err != nil {
		return 0, err
	}
	defer ln.Close()
	return ln.Addr().(*net.TCPAddr).Port, nil
}
