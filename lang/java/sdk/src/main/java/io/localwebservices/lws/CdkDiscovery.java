package io.localwebservices.lws;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

/**
 * Discovers AWS resources from a synthesised CDK cloud assembly.
 *
 * <p>Use via {@link LwsSession#fromCdk(String)} or call {@link #discover(Path)} directly:
 * <pre>{@code
 * SessionSpec spec = CdkDiscovery.discover(Path.of("path/to/project"));
 * }</pre>
 *
 * <p>Only resources with plain-string name properties are included; resources
 * whose names are defined via CloudFormation intrinsic functions are skipped.
 */
public class CdkDiscovery {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    /**
     * Parses a synthesised CDK cloud assembly at {@code projectDir/cdk.out} and
     * returns a {@link SessionSpec} describing the discovered resources.
     *
     * @param projectDir path to the CDK project root (must contain {@code cdk.out/manifest.json})
     * @return a SessionSpec populated with discovered resources
     */
    public static SessionSpec discover(Path projectDir) throws Exception {
        Path cdkOut = projectDir.resolve("cdk.out");
        Path manifestPath = cdkOut.resolve("manifest.json");
        JsonNode manifest = MAPPER.readTree(Files.readString(manifestPath));

        List<TableSpec> tables = new ArrayList<>();
        List<String> queues = new ArrayList<>();
        List<String> buckets = new ArrayList<>();
        List<String> topics = new ArrayList<>();
        List<StateMachineSpec> stateMachines = new ArrayList<>();
        List<String> parameters = new ArrayList<>();
        List<String> secrets = new ArrayList<>();

        JsonNode artifacts = manifest.path("artifacts");
        artifacts.fields().forEachRemaining(entry -> {
            JsonNode artifact = entry.getValue();
            if (!"aws:cloudformation:stack".equals(artifact.path("type").asText())) {
                return;
            }
            String templateFile = artifact.path("properties").path("templateFile").asText();
            Path templatePath = cdkOut.resolve(templateFile);
            JsonNode template;
            try {
                template = MAPPER.readTree(Files.readString(templatePath));
            } catch (Exception e) {
                throw new RuntimeException("Failed to read CDK template: " + templatePath, e);
            }

            JsonNode resources = template.path("Resources");
            resources.fields().forEachRemaining(res -> {
                JsonNode resource = res.getValue();
                String type = resource.path("Type").asText();
                JsonNode props = resource.path("Properties");

                switch (type) {
                    case "AWS::DynamoDB::Table": {
                        String name = plainString(props, "TableName");
                        if (name == null) break;
                        TableSpec ts = new TableSpec(name, "");
                        JsonNode keySchema = props.path("KeySchema");
                        String partitionKey = "";
                        String sortKey = null;
                        for (JsonNode ks : keySchema) {
                            String attrName = ks.path("AttributeName").asText("");
                            String keyType = ks.path("KeyType").asText("");
                            if ("HASH".equals(keyType)) partitionKey = attrName;
                            else if ("RANGE".equals(keyType)) sortKey = attrName;
                        }
                        if (!partitionKey.isEmpty()) {
                            TableSpec spec = new TableSpec(name, partitionKey);
                            if (sortKey != null) spec.sortKey(sortKey);
                            tables.add(spec);
                        }
                        break;
                    }
                    case "AWS::SQS::Queue": {
                        String name = plainString(props, "QueueName");
                        if (name != null) queues.add(name);
                        break;
                    }
                    case "AWS::S3::Bucket": {
                        String name = plainString(props, "BucketName");
                        if (name != null) buckets.add(name);
                        break;
                    }
                    case "AWS::SNS::Topic": {
                        String name = plainString(props, "TopicName");
                        if (name != null) topics.add(name);
                        break;
                    }
                    case "AWS::StepFunctions::StateMachine": {
                        String name = plainString(props, "StateMachineName");
                        if (name == null) break;
                        String def = plainString(props, "DefinitionString");
                        if (def == null) def = "{}";
                        stateMachines.add(new StateMachineSpec(name, def));
                        break;
                    }
                    case "AWS::SSM::Parameter": {
                        String name = plainString(props, "Name");
                        if (name != null) parameters.add(name);
                        break;
                    }
                    case "AWS::SecretsManager::Secret": {
                        String name = plainString(props, "Name");
                        if (name != null) secrets.add(name);
                        break;
                    }
                    default:
                        break;
                }
            });
        });

        return new SessionSpec()
                .tables(tables)
                .queues(queues)
                .buckets(buckets)
                .topics(topics)
                .stateMachines(stateMachines)
                .parameters(parameters)
                .secrets(secrets);
    }

    /**
     * Returns the string value of a property node if it is a plain JSON string.
     * Returns {@code null} if the property is absent or is not a plain string
     * (e.g. a CloudFormation intrinsic function object).
     */
    private static String plainString(JsonNode props, String key) {
        JsonNode node = props.path(key);
        if (node.isMissingNode() || node.isNull()) return null;
        if (!node.isTextual()) return null;
        return node.asText();
    }
}
