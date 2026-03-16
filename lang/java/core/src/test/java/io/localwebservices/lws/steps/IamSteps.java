package io.localwebservices.lws.steps;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.localwebservices.lws.cli.LwsCli;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;
import software.amazon.awssdk.services.eventbridge.EventBridgeClient;
import software.amazon.awssdk.services.eventbridge.model.*;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerClient;
import software.amazon.awssdk.services.secretsmanager.model.*;
import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.*;
import software.amazon.awssdk.services.sns.SnsClient;
import software.amazon.awssdk.services.sns.model.*;
import software.amazon.awssdk.services.sqs.SqsClient;
import software.amazon.awssdk.services.sqs.model.*;
import software.amazon.awssdk.services.ssm.SsmClient;
import software.amazon.awssdk.services.ssm.model.*;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;

public class IamSteps {

    private static final String ACCOUNT = "000000000000";
    private static final String REGION = "us-east-1";

    private static final Map<String, Object> FULL_ACCESS_POLICY = Map.of(
        "Statement", List.of(Map.of("Effect", "Allow", "Action", "*", "Resource", "*"))
    );
    private static final Map<String, Object> NO_PERMS_POLICY = Map.of(
        "Statement", List.of()
    );

    private final WorldContext world;

    public IamSteps(WorldContext world) {
        this.world = world;
    }

    private void ensureIdentitiesRegistered() throws Exception {
        LwsCli.iamRegisterIdentities(world.managementPort(), Map.of(
            "lws-test-full-access", Map.of("inline_policies", List.of(FULL_ACCESS_POLICY)),
            "lws-test-no-perms", Map.of("inline_policies", List.of(NO_PERMS_POLICY))
        ));
    }

    @Given("IAM auth was enabled for {string} with mode {string}")
    public void iamAuthWasEnabledForWithMode(String service, String mode) throws Exception {
        ensureIdentitiesRegistered();
        LwsCli.iamSet(world.managementPort(), mode);
    }

    @Given("IAM auth was disabled for {string}")
    public void iamAuthWasDisabledFor(String service) throws Exception {
        LwsCli.iamSet(world.managementPort(), "disabled");
    }

    @Given("IAM auth was set for {string} with mode {string}")
    public void iamAuthWasSetForWithMode(String service, String mode) throws Exception {
        ensureIdentitiesRegistered();
        LwsCli.iamSet(world.managementPort(), mode);
    }

    @Given("IAM auth was set for {string} with mode {string} and identity {string}")
    public void iamAuthWasSetForWithModeAndIdentity(String service, String mode, String identity) throws Exception {
        ensureIdentitiesRegistered();
        LwsCli.iamSetModeAndIdentity(world.managementPort(), mode, identity);
    }

    @Then("IAM auth was cleaned up for {string}")
    public void iamAuthWasCleanedUpFor(String service) throws Exception {
        LwsCli.iamSet(world.managementPort(), "disabled");
    }

    @When("I call {string} {string}")
    public void iCall(String service, String operation) {
        try {
            dispatchServiceCall(service, operation);
        } catch (Exception e) {
            world.setFailure(e);
        }
    }

    private void dispatchServiceCall(String service, String operation) throws Exception {
        switch (service) {
            case "dynamodb": callDynamodb(operation); break;
            case "sqs": callSqs(operation); break;
            case "s3": callS3(operation); break;
            case "sns": callSns(operation); break;
            case "events": callEvents(operation); break;
            case "stepfunctions": callStepFunctions(operation); break;
            case "ssm": callSsm(operation); break;
            case "secretsmanager": callSecretsManager(operation); break;
            case "cognito-idp": callCognitoRaw(operation); break;
            default: world.setSuccess(Map.of("message", "pending: " + service + " " + operation));
        }
    }

    private void callDynamodb(String operation) throws Exception {
        String tableName = "iam-test-table";
        String tableArn = "arn:aws:dynamodb:" + REGION + ":" + ACCOUNT + ":table/" + tableName;
        try (DynamoDbClient client = world.dynamodbClient()) {
            switch (operation) {
                case "list-tables": world.setSuccess(client.listTables()); break;
                case "create-table": world.setSuccess(client.createTable(r -> r.tableName(tableName)
                    .keySchema(KeySchemaElement.builder().attributeName("pk").keyType(KeyType.HASH).build())
                    .attributeDefinitions(AttributeDefinition.builder().attributeName("pk").attributeType(ScalarAttributeType.S).build())
                    .billingMode(BillingMode.PAY_PER_REQUEST))); break;
                case "delete-table": world.setSuccess(client.deleteTable(r -> r.tableName(tableName))); break;
                case "describe-table": world.setSuccess(client.describeTable(r -> r.tableName(tableName))); break;
                case "update-table": world.setSuccess(client.updateTable(r -> r.tableName(tableName).billingMode(BillingMode.PAY_PER_REQUEST))); break;
                case "describe-time-to-live": world.setSuccess(client.describeTimeToLive(r -> r.tableName(tableName))); break;
                case "update-time-to-live": world.setSuccess(client.updateTimeToLive(r -> r.tableName(tableName).timeToLiveSpecification(s -> s.attributeName("ttl").enabled(true)))); break;
                case "describe-continuous-backups": world.setSuccess(client.describeContinuousBackups(r -> r.tableName(tableName))); break;
                case "get-item": world.setSuccess(client.getItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS("k"))))); break;
                case "put-item": world.setSuccess(client.putItem(r -> r.tableName(tableName).item(Map.of("pk", AttributeValue.fromS("k"))))); break;
                case "delete-item": world.setSuccess(client.deleteItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS("k"))))); break;
                case "update-item": world.setSuccess(client.updateItem(r -> r.tableName(tableName).key(Map.of("pk", AttributeValue.fromS("k"))).updateExpression("SET #d = :d").expressionAttributeNames(Map.of("#d", "data")).expressionAttributeValues(Map.of(":d", AttributeValue.fromS("v"))))); break;
                case "query": world.setSuccess(client.query(r -> r.tableName(tableName).keyConditionExpression("pk = :pk").expressionAttributeValues(Map.of(":pk", AttributeValue.fromS("k"))))); break;
                case "scan": world.setSuccess(client.scan(r -> r.tableName(tableName))); break;
                case "batch-get-item": world.setSuccess(client.batchGetItem(r -> r.requestItems(Map.of(tableName, KeysAndAttributes.builder().keys(Map.of("pk", AttributeValue.fromS("k"))).build())))); break;
                case "batch-write-item": world.setSuccess(client.batchWriteItem(r -> r.requestItems(Map.of(tableName, List.of(WriteRequest.builder().putRequest(p -> p.item(Map.of("pk", AttributeValue.fromS("k")))).build()))))); break;
                case "transact-get-items": world.setSuccess(client.transactGetItems(r -> r.transactItems(TransactGetItem.builder().get(g -> g.tableName(tableName).key(Map.of("pk", AttributeValue.fromS("k")))).build()))); break;
                case "transact-write-items": world.setSuccess(client.transactWriteItems(r -> r.transactItems(TransactWriteItem.builder().put(p -> p.tableName(tableName).item(Map.of("pk", AttributeValue.fromS("k")))).build()))); break;
                case "list-tags-of-resource": world.setSuccess(client.listTagsOfResource(r -> r.resourceArn(tableArn))); break;
                case "tag-resource": world.setSuccess(client.tagResource(r -> r.resourceArn(tableArn).tags(software.amazon.awssdk.services.dynamodb.model.Tag.builder().key("k").value("v").build()))); break;
                case "untag-resource": world.setSuccess(client.untagResource(r -> r.resourceArn(tableArn).tagKeys("k"))); break;
                default: world.setSuccess(Map.of("message", "pending dynamodb: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    private void callSqs(String operation) throws Exception {
        String queueName = "iam-test-queue";
        String queueUrl = world.sqsQueueUrl(queueName);
        try (SqsClient client = world.sqsClient()) {
            switch (operation) {
                case "list-queues": world.setSuccess(client.listQueues()); break;
                case "create-queue": world.setSuccess(client.createQueue(r -> r.queueName(queueName))); break;
                case "delete-queue": world.setSuccess(client.deleteQueue(r -> r.queueUrl(queueUrl))); break;
                case "get-queue-url": world.setSuccess(client.getQueueUrl(r -> r.queueName(queueName))); break;
                case "get-queue-attributes": world.setSuccess(client.getQueueAttributes(r -> r.queueUrl(queueUrl).attributeNamesWithStrings("All"))); break;
                case "set-queue-attributes": world.setSuccess(client.setQueueAttributes(r -> r.queueUrl(queueUrl).attributesWithStrings(Map.of("VisibilityTimeout", "30")))); break;
                case "purge-queue": world.setSuccess(client.purgeQueue(r -> r.queueUrl(queueUrl))); break;
                case "list-queue-tags": world.setSuccess(client.listQueueTags(r -> r.queueUrl(queueUrl))); break;
                case "tag-queue": world.setSuccess(client.tagQueue(r -> r.queueUrl(queueUrl).tags(Map.of("env", "test")))); break;
                case "untag-queue": world.setSuccess(client.untagQueue(r -> r.queueUrl(queueUrl).tagKeys("env"))); break;
                case "send-message": world.setSuccess(client.sendMessage(r -> r.queueUrl(queueUrl).messageBody("test"))); break;
                case "send-message-batch": world.setSuccess(client.sendMessageBatch(r -> r.queueUrl(queueUrl).entries(SendMessageBatchRequestEntry.builder().id("1").messageBody("test").build()))); break;
                case "receive-message": world.setSuccess(client.receiveMessage(r -> r.queueUrl(queueUrl).maxNumberOfMessages(1))); break;
                case "delete-message": world.setSuccess(client.deleteMessage(r -> r.queueUrl(queueUrl).receiptHandle("dummy"))); break;
                case "delete-message-batch": world.setSuccess(client.deleteMessageBatch(r -> r.queueUrl(queueUrl).entries(DeleteMessageBatchRequestEntry.builder().id("1").receiptHandle("dummy").build()))); break;
                case "change-message-visibility": world.setSuccess(client.changeMessageVisibility(r -> r.queueUrl(queueUrl).receiptHandle("dummy").visibilityTimeout(30))); break;
                case "change-message-visibility-batch": world.setSuccess(client.changeMessageVisibilityBatch(r -> r.queueUrl(queueUrl).entries(ChangeMessageVisibilityBatchRequestEntry.builder().id("1").receiptHandle("dummy").visibilityTimeout(30).build()))); break;
                case "list-dead-letter-source-queues": world.setSuccess(client.listDeadLetterSourceQueues(r -> r.queueUrl(queueUrl))); break;
                default: world.setSuccess(Map.of("message", "pending sqs: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    private void callS3(String operation) throws Exception {
        String bucket = "iam-test-bucket";
        String key = "iam-test-key.txt";
        try (S3Client client = world.s3Client()) {
            switch (operation) {
                case "list-buckets": world.setSuccess(client.listBuckets()); break;
                case "create-bucket": world.setSuccess(client.createBucket(r -> r.bucket(bucket))); break;
                case "delete-bucket": world.setSuccess(client.deleteBucket(r -> r.bucket(bucket))); break;
                case "head-bucket": world.setSuccess(client.headBucket(r -> r.bucket(bucket))); break;
                case "list-objects-v2": world.setSuccess(client.listObjectsV2(r -> r.bucket(bucket))); break;
                case "get-bucket-location": world.setSuccess(client.getBucketLocation(r -> r.bucket(bucket))); break;
                case "get-bucket-tagging": world.setSuccess(client.getBucketTagging(r -> r.bucket(bucket))); break;
                case "put-bucket-tagging": world.setSuccess(client.putBucketTagging(r -> r.bucket(bucket).tagging(software.amazon.awssdk.services.s3.model.Tagging.builder().tagSet(List.of()).build()))); break;
                case "delete-bucket-tagging": world.setSuccess(client.deleteBucketTagging(r -> r.bucket(bucket))); break;
                case "get-bucket-policy": world.setSuccess(client.getBucketPolicy(r -> r.bucket(bucket))); break;
                case "put-bucket-policy": world.setSuccess(client.putBucketPolicy(r -> r.bucket(bucket).policy("{\"Version\":\"2012-10-17\",\"Statement\":[]}"))); break;
                case "get-bucket-notification-configuration": world.setSuccess(client.getBucketNotificationConfiguration(r -> r.bucket(bucket))); break;
                case "put-bucket-notification-configuration": world.setSuccess(client.putBucketNotificationConfiguration(r -> r.bucket(bucket).notificationConfiguration(software.amazon.awssdk.services.s3.model.NotificationConfiguration.builder().build()))); break;
                case "get-bucket-website": world.setSuccess(client.getBucketWebsite(r -> r.bucket(bucket))); break;
                case "put-bucket-website": world.setSuccess(client.putBucketWebsite(r -> r.bucket(bucket).websiteConfiguration(w -> w.indexDocument(i -> i.suffix("index.html"))))); break;
                case "delete-bucket-website": world.setSuccess(client.deleteBucketWebsite(r -> r.bucket(bucket))); break;
                case "get-object": world.setSuccess(client.getObject(r -> r.bucket(bucket).key(key))); break;
                case "put-object": world.setSuccess(client.putObject(r -> r.bucket(bucket).key(key), software.amazon.awssdk.core.sync.RequestBody.fromBytes("test".getBytes(StandardCharsets.UTF_8)))); break;
                case "delete-object": world.setSuccess(client.deleteObject(r -> r.bucket(bucket).key(key))); break;
                case "head-object": world.setSuccess(client.headObject(r -> r.bucket(bucket).key(key))); break;
                case "copy-object": world.setSuccess(client.copyObject(r -> r.sourceBucket(bucket).sourceKey(key).destinationBucket(bucket).destinationKey("dest.txt"))); break;
                case "delete-objects": world.setSuccess(client.deleteObjects(r -> r.bucket(bucket).delete(d -> d.objects(ObjectIdentifier.builder().key(key).build())))); break;
                case "create-multipart-upload": world.setSuccess(client.createMultipartUpload(r -> r.bucket(bucket).key(key))); break;
                case "upload-part": world.setSuccess(client.uploadPart(r -> r.bucket(bucket).key(key).uploadId("dummy").partNumber(1), software.amazon.awssdk.core.sync.RequestBody.fromBytes("part".getBytes(StandardCharsets.UTF_8)))); break;
                case "complete-multipart-upload": world.setSuccess(client.completeMultipartUpload(r -> r.bucket(bucket).key(key).uploadId("dummy").multipartUpload(software.amazon.awssdk.services.s3.model.CompletedMultipartUpload.builder().parts(List.of()).build()))); break;
                case "list-parts": world.setSuccess(client.listParts(r -> r.bucket(bucket).key(key).uploadId("dummy"))); break;
                case "abort-multipart-upload": world.setSuccess(client.abortMultipartUpload(r -> r.bucket(bucket).key(key).uploadId("dummy"))); break;
                default: world.setSuccess(Map.of("message", "pending s3: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    private void callSns(String operation) throws Exception {
        String topicArn = "arn:aws:sns:" + REGION + ":" + ACCOUNT + ":iam-test-topic";
        String subArn = "arn:aws:sns:" + REGION + ":" + ACCOUNT + ":iam-test-topic:dummy-sub";
        try (SnsClient client = world.snsClient()) {
            switch (operation) {
                case "list-topics": world.setSuccess(client.listTopics()); break;
                case "list-subscriptions": world.setSuccess(client.listSubscriptions()); break;
                case "list-subscriptions-by-topic": world.setSuccess(client.listSubscriptionsByTopic(r -> r.topicArn(topicArn))); break;
                case "create-topic": world.setSuccess(client.createTopic(r -> r.name("iam-test-topic"))); break;
                case "delete-topic": world.setSuccess(client.deleteTopic(r -> r.topicArn(topicArn))); break;
                case "publish": world.setSuccess(client.publish(r -> r.topicArn(topicArn).message("test"))); break;
                case "subscribe": world.setSuccess(client.subscribe(r -> r.topicArn(topicArn).protocol("sqs").endpoint("arn:aws:sqs:" + REGION + ":" + ACCOUNT + ":dummy"))); break;
                case "unsubscribe": world.setSuccess(client.unsubscribe(r -> r.subscriptionArn(subArn))); break;
                case "get-topic-attributes": world.setSuccess(client.getTopicAttributes(r -> r.topicArn(topicArn))); break;
                case "set-topic-attributes": world.setSuccess(client.setTopicAttributes(r -> r.topicArn(topicArn).attributeName("DisplayName").attributeValue("test"))); break;
                case "get-subscription-attributes": world.setSuccess(client.getSubscriptionAttributes(r -> r.subscriptionArn(subArn))); break;
                case "set-subscription-attributes": world.setSuccess(client.setSubscriptionAttributes(r -> r.subscriptionArn(subArn).attributeName("RawMessageDelivery").attributeValue("true"))); break;
                case "confirm-subscription": world.setSuccess(client.confirmSubscription(r -> r.topicArn(topicArn).token("dummy"))); break;
                case "list-tags-for-resource": world.setSuccess(client.listTagsForResource(r -> r.resourceArn(topicArn))); break;
                case "tag-resource": world.setSuccess(client.tagResource(r -> r.resourceArn(topicArn).tags(software.amazon.awssdk.services.sns.model.Tag.builder().key("k").value("v").build()))); break;
                case "untag-resource": world.setSuccess(client.untagResource(r -> r.resourceArn(topicArn).tagKeys("k"))); break;
                default: world.setSuccess(Map.of("message", "pending sns: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    private void callEvents(String operation) throws Exception {
        String busArn = "arn:aws:events:" + REGION + ":" + ACCOUNT + ":event-bus/iam-test-bus";
        try (EventBridgeClient client = world.eventbridgeClient()) {
            switch (operation) {
                case "list-rules": world.setSuccess(client.listRules(r -> r.eventBusName("default"))); break;
                case "list-event-buses": world.setSuccess(client.listEventBuses(ListEventBusesRequest.builder().build())); break;
                case "describe-event-bus": world.setSuccess(client.describeEventBus(r -> r.name("default"))); break;
                case "create-event-bus": world.setSuccess(client.createEventBus(r -> r.name("iam-test-bus"))); break;
                case "delete-event-bus": world.setSuccess(client.deleteEventBus(r -> r.name("iam-test-bus"))); break;
                case "put-rule": world.setSuccess(client.putRule(r -> r.name("iam-test-rule").eventBusName("default").scheduleExpression("rate(1 day)").state(RuleState.ENABLED))); break;
                case "delete-rule": world.setSuccess(client.deleteRule(r -> r.name("iam-test-rule").eventBusName("default"))); break;
                case "describe-rule": world.setSuccess(client.describeRule(r -> r.name("iam-test-rule").eventBusName("default"))); break;
                case "put-targets": world.setSuccess(client.putTargets(r -> r.rule("iam-test-rule").eventBusName("default").targets(software.amazon.awssdk.services.eventbridge.model.Target.builder().id("t1").arn("arn:aws:sqs:" + REGION + ":" + ACCOUNT + ":dummy").build()))); break;
                case "remove-targets": world.setSuccess(client.removeTargets(r -> r.rule("iam-test-rule").eventBusName("default").ids("t1"))); break;
                case "list-targets-by-rule": world.setSuccess(client.listTargetsByRule(r -> r.rule("iam-test-rule").eventBusName("default"))); break;
                case "enable-rule": world.setSuccess(client.enableRule(r -> r.name("iam-test-rule").eventBusName("default"))); break;
                case "disable-rule": world.setSuccess(client.disableRule(r -> r.name("iam-test-rule").eventBusName("default"))); break;
                case "put-events": world.setSuccess(client.putEvents(r -> r.entries(PutEventsRequestEntry.builder().source("test").detailType("test").detail("{}").build()))); break;
                case "list-tags-for-resource": world.setSuccess(client.listTagsForResource(r -> r.resourceARN(busArn))); break;
                case "tag-resource": world.setSuccess(client.tagResource(r -> r.resourceARN(busArn).tags(software.amazon.awssdk.services.eventbridge.model.Tag.builder().key("k").value("v").build()))); break;
                case "untag-resource": world.setSuccess(client.untagResource(r -> r.resourceARN(busArn).tagKeys("k"))); break;
                default: world.setSuccess(Map.of("message", "pending events: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    private void callStepFunctions(String operation) throws Exception {
        String smArn = "arn:aws:states:" + REGION + ":" + ACCOUNT + ":stateMachine:iam-test-sm";
        String passDefinition = "{\"StartAt\":\"Pass\",\"States\":{\"Pass\":{\"Type\":\"Pass\",\"End\":true}}}";
        String execArn = "arn:aws:states:" + REGION + ":" + ACCOUNT + ":execution:iam-test-sm:dummy";
        // Some operations are not in SDK v2.25.0 - use raw HTTP for those
        if ("validate-state-machine-definition".equals(operation)) {
            callStepFunctionsRaw("ValidateStateMachineDefinition", "{\"definition\":\"" + passDefinition.replace("\\", "\\\\").replace("\"", "\\\"") + "\"}");
            return;
        }
        try (SfnClient client = world.sfnClient()) {
            switch (operation) {
                case "list-state-machines": world.setSuccess(client.listStateMachines()); break;
                case "create-state-machine": world.setSuccess(client.createStateMachine(r -> r.name("iam-test-sm").definition(passDefinition).roleArn("arn:aws:iam::" + ACCOUNT + ":role/dummy").type(StateMachineType.STANDARD))); break;
                case "delete-state-machine": world.setSuccess(client.deleteStateMachine(r -> r.stateMachineArn(smArn))); break;
                case "describe-state-machine": world.setSuccess(client.describeStateMachine(r -> r.stateMachineArn(smArn))); break;
                case "update-state-machine": world.setSuccess(client.updateStateMachine(r -> r.stateMachineArn(smArn).definition(passDefinition))); break;
                case "list-state-machine-versions": world.setSuccess(client.listStateMachineVersions(r -> r.stateMachineArn(smArn))); break;
                case "start-execution": world.setSuccess(client.startExecution(r -> r.stateMachineArn(smArn).input("{}"))); break;
                case "start-sync-execution": world.setSuccess(client.startSyncExecution(r -> r.stateMachineArn(smArn).input("{}"))); break;
                case "stop-execution": world.setSuccess(client.stopExecution(r -> r.executionArn(execArn))); break;
                case "describe-execution": world.setSuccess(client.describeExecution(r -> r.executionArn(execArn))); break;
                case "list-executions": world.setSuccess(client.listExecutions(r -> r.stateMachineArn(smArn))); break;
                case "get-execution-history": world.setSuccess(client.getExecutionHistory(r -> r.executionArn(execArn))); break;
                case "list-tags-for-resource": world.setSuccess(client.listTagsForResource(r -> r.resourceArn(smArn))); break;
                case "tag-resource": world.setSuccess(client.tagResource(r -> r.resourceArn(smArn).tags(software.amazon.awssdk.services.sfn.model.Tag.builder().key("k").value("v").build()))); break;
                case "untag-resource": world.setSuccess(client.untagResource(r -> r.resourceArn(smArn).tagKeys("k"))); break;
                default: world.setSuccess(Map.of("message", "pending sfn: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    private void callStepFunctionsRaw(String action, String jsonBody) {
        try {
            String target = "AWSStepFunctions." + action;
            int port = world.stepfunctionsPort();
            URL url = new URL("http://127.0.0.1:" + port + "/");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-amz-json-1.0");
            conn.setRequestProperty("X-Amz-Target", target);
            conn.setRequestProperty("Authorization", "AWS4-HMAC-SHA256 Credential=test/20230101/us-east-1/states/aws4_request, SignedHeaders=content-type;host;x-amz-target, Signature=dummy");
            conn.setDoOutput(true);
            byte[] body = jsonBody.getBytes(StandardCharsets.UTF_8);
            conn.setRequestProperty("Content-Length", String.valueOf(body.length));
            try (OutputStream os = conn.getOutputStream()) { os.write(body); }
            int status = conn.getResponseCode();
            InputStream is = status >= 200 && status < 300 ? conn.getInputStream() : conn.getErrorStream();
            byte[] responseBytes = is != null ? is.readAllBytes() : new byte[0];
            String responseBody = new String(responseBytes, StandardCharsets.UTF_8);
            if (status == 403) {
                world.setFailure(new RuntimeException(responseBody));
            } else {
                world.setSuccess(responseBody);
            }
        } catch (Exception e) {
            world.setFailure(e);
        }
    }

    private void callSsm(String operation) throws Exception {
        String paramName = "/iam-test/param";
        try (SsmClient client = world.ssmClient()) {
            switch (operation) {
                case "describe-parameters": world.setSuccess(client.describeParameters()); break;
                case "get-parameter": world.setSuccess(client.getParameter(r -> r.name(paramName))); break;
                case "get-parameters": world.setSuccess(client.getParameters(r -> r.names(paramName))); break;
                case "get-parameters-by-path": world.setSuccess(client.getParametersByPath(r -> r.path("/iam-test"))); break;
                case "put-parameter": world.setSuccess(client.putParameter(r -> r.name(paramName).value("v").type(ParameterType.STRING))); break;
                case "delete-parameter": world.setSuccess(client.deleteParameter(r -> r.name(paramName))); break;
                case "delete-parameters": world.setSuccess(client.deleteParameters(r -> r.names(paramName))); break;
                case "add-tags-to-resource": world.setSuccess(client.addTagsToResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(paramName).tags(software.amazon.awssdk.services.ssm.model.Tag.builder().key("k").value("v").build()))); break;
                case "remove-tags-from-resource": world.setSuccess(client.removeTagsFromResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(paramName).tagKeys("k"))); break;
                case "list-tags-for-resource": world.setSuccess(client.listTagsForResource(r -> r.resourceType(ResourceTypeForTagging.PARAMETER).resourceId(paramName))); break;
                default: world.setSuccess(Map.of("message", "pending ssm: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }

    /**
     * Sends a raw HTTP request to the Cognito IDP port (using Cognito AWS target).
     * Maps CLI-style operation names to Cognito X-Amz-Target values.
     */
    private void callCognitoRaw(String operation) {
        try {
            // Map operation name to CognitoIdentityProvider target
            String target = "AmazonCognitoIdentityProvider." + toCognitoTarget(operation);
            int port = world.cognitoPort();
            URL url = new URL("http://127.0.0.1:" + port + "/");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-amz-json-1.1");
            conn.setRequestProperty("X-Amz-Target", target);
            conn.setRequestProperty("Authorization", "AWS4-HMAC-SHA256 Credential=test/20230101/us-east-1/cognito-idp/aws4_request, SignedHeaders=content-type;host;x-amz-target, Signature=dummy");
            conn.setDoOutput(true);
            byte[] body = "{}".getBytes(StandardCharsets.UTF_8);
            conn.setRequestProperty("Content-Length", String.valueOf(body.length));
            try (OutputStream os = conn.getOutputStream()) { os.write(body); }
            int status = conn.getResponseCode();
            InputStream is = status >= 200 && status < 300 ? conn.getInputStream() : conn.getErrorStream();
            byte[] responseBytes = is != null ? is.readAllBytes() : new byte[0];
            String responseBody = new String(responseBytes, StandardCharsets.UTF_8);
            if (status == 403) {
                // IAM denied - treat as failure with error message
                world.setFailure(new RuntimeException(responseBody));
            } else {
                world.setSuccess(responseBody);
            }
        } catch (Exception e) {
            world.setFailure(e);
        }
    }

    private static String toCognitoTarget(String operation) {
        // Convert CLI-style to PascalCase Cognito target
        StringBuilder sb = new StringBuilder();
        for (String part : operation.split("-")) {
            if (!part.isEmpty()) {
                sb.append(Character.toUpperCase(part.charAt(0)));
                sb.append(part.substring(1));
            }
        }
        return sb.toString();
    }

    private void callSecretsManager(String operation) throws Exception {
        String secretName = "iam-test-secret";
        try (SecretsManagerClient client = world.secretsManagerClient()) {
            switch (operation) {
                case "list-secrets": world.setSuccess(client.listSecrets()); break;
                case "create-secret": world.setSuccess(client.createSecret(r -> r.name(secretName).secretString("val"))); break;
                case "get-secret-value": world.setSuccess(client.getSecretValue(r -> r.secretId(secretName))); break;
                case "put-secret-value": world.setSuccess(client.putSecretValue(r -> r.secretId(secretName).secretString("new"))); break;
                case "describe-secret": world.setSuccess(client.describeSecret(r -> r.secretId(secretName))); break;
                case "update-secret": world.setSuccess(client.updateSecret(r -> r.secretId(secretName).secretString("updated"))); break;
                case "delete-secret": world.setSuccess(client.deleteSecret(r -> r.secretId(secretName).forceDeleteWithoutRecovery(true))); break;
                case "restore-secret": world.setSuccess(client.restoreSecret(r -> r.secretId(secretName))); break;
                case "list-secret-version-ids": world.setSuccess(client.listSecretVersionIds(r -> r.secretId(secretName))); break;
                case "get-resource-policy": world.setSuccess(client.getResourcePolicy(r -> r.secretId(secretName))); break;
                case "tag-resource": world.setSuccess(client.tagResource(r -> r.secretId(secretName).tags(software.amazon.awssdk.services.secretsmanager.model.Tag.builder().key("k").value("v").build()))); break;
                case "untag-resource": world.setSuccess(client.untagResource(r -> r.secretId(secretName).tagKeys("k"))); break;
                default: world.setSuccess(Map.of("message", "pending secretsmanager: " + operation));
            }
        } catch (Exception e) { world.setFailure(e); }
    }
}
