package io.localwebservices.lws;

import com.sun.net.httpserver.HttpServer;
import io.localwebservices.lws.management.ManagementHandler;
import io.localwebservices.lws.providers.dynamodb.DynamoDbHandler;
import io.localwebservices.lws.providers.eventbridge.EventBridgeHandler;
import io.localwebservices.lws.providers.s3.S3Handler;
import io.localwebservices.lws.providers.secretsmanager.SecretsManagerHandler;
import io.localwebservices.lws.providers.sns.SnsHandler;
import io.localwebservices.lws.providers.sqs.SqsHandler;
import io.localwebservices.lws.providers.ssm.SsmHandler;
import io.localwebservices.lws.providers.apigateway.ApiGatewayHandler;
import io.localwebservices.lws.providers.cognitoidp.CognitoIdpHandler;
import io.localwebservices.lws.providers.lambda.LambdaHandler;
import io.localwebservices.lws.providers.stepfunctions.StepFunctionsHandler;
import io.localwebservices.lws.providers.rds.RdsHandler;
import io.localwebservices.lws.providers.docdb.DocDbHandler;
import io.localwebservices.lws.providers.neptune.NeptuneHandler;
import io.localwebservices.lws.providers.elasticache.ElastiCacheHandler;
import io.localwebservices.lws.providers.memorydb.MemoryDbHandler;
import io.localwebservices.lws.providers.glacier.GlacierHandler;
import io.localwebservices.lws.providers.elasticsearch.ElasticsearchHandler;
import io.localwebservices.lws.providers.opensearch.OpenSearchHandler;
import io.localwebservices.lws.providers.s3tables.S3TablesHandler;

import java.net.InetSocketAddress;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executors;

/**
 * Multi-port in-process LWS server.
 * Start via {@link #start(int)} and stop via {@link RunningServer#stop()}.
 */
public class LwsServer {

    public static final int DEFAULT_BASE_PORT = 19302;

    // Port offsets matching TypeScript
    private static final Map<String, Integer> SERVICE_OFFSETS = new LinkedHashMap<>();
    static {
        SERVICE_OFFSETS.put("dynamodb", 1);
        SERVICE_OFFSETS.put("sqs", 2);
        SERVICE_OFFSETS.put("s3", 3);
        SERVICE_OFFSETS.put("sns", 4);
        SERVICE_OFFSETS.put("eventbridge", 5);
        SERVICE_OFFSETS.put("stepfunctions", 6);
        SERVICE_OFFSETS.put("cognito-idp", 7);
        SERVICE_OFFSETS.put("lambda", 8);
        SERVICE_OFFSETS.put("apigateway", 9);
        SERVICE_OFFSETS.put("ssm", 12);
        SERVICE_OFFSETS.put("secretsmanager", 13);
        SERVICE_OFFSETS.put("rds", 10);
        SERVICE_OFFSETS.put("docdb", 11);
        SERVICE_OFFSETS.put("elasticache", 14);
        SERVICE_OFFSETS.put("neptune", 15);
        SERVICE_OFFSETS.put("memorydb", 16);
        SERVICE_OFFSETS.put("glacier", 17);
        SERVICE_OFFSETS.put("elasticsearch", 18);
        SERVICE_OFFSETS.put("opensearch", 19);
        SERVICE_OFFSETS.put("s3tables", 20);
    }

    public static class RunningServer {
        public final ServerState state;
        public final int basePort;
        public final Map<String, Integer> ports;
        private final List<HttpServer> servers;

        RunningServer(ServerState state, int basePort, Map<String, Integer> ports, List<HttpServer> servers) {
            this.state = state;
            this.basePort = basePort;
            this.ports = ports;
            this.servers = servers;
        }

        public String managementUrl() {
            return "http://127.0.0.1:" + basePort;
        }

        public void stop() {
            for (HttpServer server : servers) {
                try { server.stop(0); } catch (Exception ignored) {}
            }
        }
    }

    public static RunningServer start(int basePort) throws Exception {
        ServerState state = new ServerState();
        List<HttpServer> servers = new ArrayList<>();
        Map<String, Integer> ports = new LinkedHashMap<>();

        // Management server at basePort
        HttpServer mgmtServer = HttpServer.create(new InetSocketAddress("127.0.0.1", basePort), 0);
        mgmtServer.createContext("/", new ManagementHandler(state));
        mgmtServer.setExecutor(Executors.newCachedThreadPool());
        mgmtServer.start();
        servers.add(mgmtServer);

        // DynamoDB at basePort+1
        {
            int port = basePort + SERVICE_OFFSETS.get("dynamodb");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new DynamoDbHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("dynamodb", port);
        }

        // SQS at basePort+2
        {
            int port = basePort + SERVICE_OFFSETS.get("sqs");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new SqsHandler(state, port));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("sqs", port);
        }

        // S3 at basePort+3
        {
            int port = basePort + SERVICE_OFFSETS.get("s3");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new S3Handler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("s3", port);
        }

        // SNS at basePort+4
        {
            int port = basePort + SERVICE_OFFSETS.get("sns");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new SnsHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("sns", port);
        }

        // EventBridge at basePort+5
        {
            int port = basePort + SERVICE_OFFSETS.get("eventbridge");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new EventBridgeHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("eventbridge", port);
        }

        // Step Functions at basePort+6
        {
            int port = basePort + SERVICE_OFFSETS.get("stepfunctions");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new StepFunctionsHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("stepfunctions", port);
        }

        // Cognito IDP at basePort+7
        {
            int port = basePort + SERVICE_OFFSETS.get("cognito-idp");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new CognitoIdpHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("cognito-idp", port);
        }

        // Lambda at basePort+8
        {
            int port = basePort + SERVICE_OFFSETS.get("lambda");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new LambdaHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("lambda", port);
        }

        // API Gateway at basePort+9
        {
            int port = basePort + SERVICE_OFFSETS.get("apigateway");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new ApiGatewayHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("apigateway", port);
        }

        // SSM at basePort+12
        {
            int port = basePort + SERVICE_OFFSETS.get("ssm");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new SsmHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("ssm", port);
        }

        // SecretsManager at basePort+13
        {
            int port = basePort + SERVICE_OFFSETS.get("secretsmanager");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new SecretsManagerHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("secretsmanager", port);
        }

        // RDS at basePort+10
        {
            int port = basePort + SERVICE_OFFSETS.get("rds");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new RdsHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("rds", port);
        }

        // DocDB at basePort+11
        {
            int port = basePort + SERVICE_OFFSETS.get("docdb");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new DocDbHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("docdb", port);
        }

        // ElastiCache at basePort+14
        {
            int port = basePort + SERVICE_OFFSETS.get("elasticache");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new ElastiCacheHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("elasticache", port);
        }

        // Neptune at basePort+15
        {
            int port = basePort + SERVICE_OFFSETS.get("neptune");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new NeptuneHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("neptune", port);
        }

        // MemoryDB at basePort+16
        {
            int port = basePort + SERVICE_OFFSETS.get("memorydb");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new MemoryDbHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("memorydb", port);
        }

        // Glacier at basePort+17
        {
            int port = basePort + SERVICE_OFFSETS.get("glacier");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new GlacierHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("glacier", port);
        }

        // Elasticsearch at basePort+18
        {
            int port = basePort + SERVICE_OFFSETS.get("elasticsearch");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new ElasticsearchHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("elasticsearch", port);
        }

        // OpenSearch at basePort+19
        {
            int port = basePort + SERVICE_OFFSETS.get("opensearch");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new OpenSearchHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("opensearch", port);
        }

        // S3Tables at basePort+20
        {
            int port = basePort + SERVICE_OFFSETS.get("s3tables");
            HttpServer server = HttpServer.create(new InetSocketAddress("127.0.0.1", port), 0);
            server.createContext("/", new S3TablesHandler(state));
            server.setExecutor(Executors.newCachedThreadPool());
            server.start();
            servers.add(server);
            ports.put("s3tables", port);
        }

        return new RunningServer(state, basePort, ports, servers);
    }

    public static void main(String[] args) throws Exception {
        int port = DEFAULT_BASE_PORT;
        if (args.length > 0) {
            port = Integer.parseInt(args[0]);
        }
        RunningServer server = start(port);
        System.out.println("LWS Java Core started at port " + port);
        System.out.println("Management URL: " + server.managementUrl());
        for (Map.Entry<String, Integer> e : server.ports.entrySet()) {
            System.out.println("  " + e.getKey() + ": " + e.getValue());
        }
        Runtime.getRuntime().addShutdownHook(new Thread(server::stop));
        Thread.currentThread().join();
    }
}
