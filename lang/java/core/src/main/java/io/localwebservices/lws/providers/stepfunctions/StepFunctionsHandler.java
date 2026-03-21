package io.localwebservices.lws.providers.stepfunctions;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import io.localwebservices.lws.ServerState;
import io.localwebservices.lws.middleware.ChaosMiddleware;
import io.localwebservices.lws.middleware.FakeMiddleware;
import io.localwebservices.lws.middleware.IamMiddleware;
import io.localwebservices.lws.providers.dynamodb.DynamoDbHandler;
import io.localwebservices.lws.providers.eventbridge.EventBridgeHandler;
import io.localwebservices.lws.providers.s3.S3Handler;
import io.localwebservices.lws.providers.secretsmanager.SecretsManagerHandler;
import io.localwebservices.lws.providers.sns.SnsHandler;
import io.localwebservices.lws.providers.sqs.SqsHandler;
import io.localwebservices.lws.providers.ssm.SsmHandler;
import java.io.*;
import java.time.Instant;
import java.util.*;

/** Step Functions wire-protocol HTTP handler. */
public class StepFunctionsHandler implements HttpHandler {

  private static final ObjectMapper MAPPER = new ObjectMapper();

  private final ServerState state;
  private final StepFunctionsStore store;

  private DynamoDbHandler dynamoDbHandler;
  private SqsHandler sqsHandler;
  private SnsHandler snsHandler;
  private S3Handler s3Handler;
  private SecretsManagerHandler secretsManagerHandler;
  private SsmHandler ssmHandler;
  private EventBridgeHandler eventBridgeHandler;

  public StepFunctionsHandler(ServerState state) {
    this.state = state;
    this.store = new StepFunctionsStore();
    state.resetCallbacks.add(store::reset);
  }

  /** Wires in the DynamoDB handler for service task bridge execution. */
  public void setDynamoDbHandler(DynamoDbHandler dynamoDbHandler) {
    this.dynamoDbHandler = dynamoDbHandler;
  }

  /** Wires in the SQS handler for service task bridge execution. */
  public void setSqsHandler(SqsHandler sqsHandler) {
    this.sqsHandler = sqsHandler;
  }

  /** Wires in the SNS handler for service task bridge execution. */
  public void setSnsHandler(SnsHandler snsHandler) {
    this.snsHandler = snsHandler;
  }

  /** Wires in the S3 handler for service task bridge execution. */
  public void setS3Handler(S3Handler s3Handler) {
    this.s3Handler = s3Handler;
  }

  /** Wires in the SecretsManager handler for service task bridge execution. */
  public void setSecretsManagerHandler(SecretsManagerHandler secretsManagerHandler) {
    this.secretsManagerHandler = secretsManagerHandler;
  }

  /** Wires in the SSM handler for service task bridge execution. */
  public void setSsmHandler(SsmHandler ssmHandler) {
    this.ssmHandler = ssmHandler;
  }

  /** Wires in the EventBridge handler for service task bridge execution. */
  public void setEventBridgeHandler(EventBridgeHandler eventBridgeHandler) {
    this.eventBridgeHandler = eventBridgeHandler;
  }

  /**
   * Starts a Step Functions execution programmatically (used by EventBridge→StepFunctions
   * delivery). Returns the execution ARN, or null if the state machine does not exist.
   */
  public String startExecution(String stateMachineArn, String input) {
    if (!store.stateMachineExists(stateMachineArn)) {
      return null;
    }
    String execName = UUID.randomUUID().toString();
    Map<String, Object> exec = store.startExecution(stateMachineArn, execName, input);
    return (String) exec.get("executionArn");
  }

  /**
   * Executes a service integration task identified by its resource ARN. The params map contains the
   * task's Parameters field from the state machine definition. Returns the task output map, or null
   * if the ARN is not a recognised service integration.
   */
  @SuppressWarnings("unchecked")
  public Map<String, Object> executeServiceTask(String resourceArn, Map<String, Object> params) {
    if (resourceArn == null) {
      return null;
    }
    if ("arn:aws:states:::dynamodb:putItem".equals(resourceArn)) {
      if (dynamoDbHandler == null) return new LinkedHashMap<>();
      return dynamoDbHandler.executePutItem(params);
    }
    if ("arn:aws:states:::dynamodb:getItem".equals(resourceArn)) {
      if (dynamoDbHandler == null) return new LinkedHashMap<>();
      return dynamoDbHandler.executeGetItem(params);
    }
    if ("arn:aws:states:::sqs:sendMessage".equals(resourceArn)) {
      if (sqsHandler == null) return new LinkedHashMap<>();
      return sqsHandler.executeSendMessage(params);
    }
    if ("arn:aws:states:::sns:publish".equals(resourceArn)) {
      if (snsHandler == null) return new LinkedHashMap<>();
      return snsHandler.executePublish(params);
    }
    if ("arn:aws:states:::s3:getObject".equals(resourceArn)) {
      if (s3Handler == null) return new LinkedHashMap<>();
      return s3Handler.executeGetObject(params);
    }
    if ("arn:aws:states:::s3:putObject".equals(resourceArn)) {
      if (s3Handler == null) return new LinkedHashMap<>();
      return s3Handler.executePutObject(params);
    }
    if ("arn:aws:states:::secretsmanager:getSecretValue".equals(resourceArn)) {
      if (secretsManagerHandler == null) return new LinkedHashMap<>();
      return secretsManagerHandler.executeGetSecretValue(params);
    }
    if ("arn:aws:states:::ssm:getParameter".equals(resourceArn)) {
      if (ssmHandler == null) return new LinkedHashMap<>();
      return ssmHandler.executeGetParameter(params);
    }
    if ("arn:aws:states:::events:putEvents".equals(resourceArn)) {
      if (eventBridgeHandler == null) return new LinkedHashMap<>();
      return eventBridgeHandler.executePutEvents(params);
    }
    return null;
  }

  /**
   * Executes a state machine synchronously by walking its states. Returns the final output as a
   * JSON string, or the original input if execution cannot be performed.
   */
  @SuppressWarnings("unchecked")
  private String executeSynchronously(String smArn, String input) {
    Map<String, Object> sm = store.getStateMachine(smArn);
    if (sm == null) {
      return input;
    }
    String definitionStr = (String) sm.get("definition");
    if (definitionStr == null) {
      return input;
    }
    Map<String, Object> definition;
    try {
      definition = MAPPER.readValue(definitionStr, Map.class);
    } catch (Exception e) {
      return input;
    }
    Map<String, Object> states = (Map<String, Object>) definition.get("States");
    if (states == null) {
      return input;
    }
    String startAt = (String) definition.get("StartAt");
    if (startAt == null) {
      return input;
    }

    Map<String, Object> currentData;
    try {
      currentData =
          input != null && !input.isEmpty()
              ? MAPPER.readValue(input, Map.class)
              : new LinkedHashMap<>();
    } catch (Exception e) {
      currentData = new LinkedHashMap<>();
    }

    String currentStateName = startAt;
    int maxSteps = 100;
    int steps = 0;
    while (currentStateName != null && steps < maxSteps) {
      steps++;
      Map<String, Object> stateDefObj = (Map<String, Object>) states.get(currentStateName);
      if (stateDefObj == null) {
        break;
      }
      String stateType = (String) stateDefObj.get("Type");
      if ("Task".equals(stateType)) {
        String resource = (String) stateDefObj.get("Resource");
        Map<String, Object> taskParams =
            stateDefObj.containsKey("Parameters")
                ? (Map<String, Object>) stateDefObj.get("Parameters")
                : currentData;
        Map<String, Object> taskOutput = executeServiceTask(resource, taskParams);
        if (taskOutput != null) {
          currentData = taskOutput;
        }
      } else if ("Pass".equals(stateType)) {
        if (stateDefObj.containsKey("Result")) {
          currentData = (Map<String, Object>) stateDefObj.get("Result");
        }
      }
      Boolean end = (Boolean) stateDefObj.get("End");
      if (Boolean.TRUE.equals(end)) {
        break;
      }
      currentStateName = (String) stateDefObj.get("Next");
    }

    try {
      return MAPPER.writeValueAsString(currentData);
    } catch (Exception e) {
      return input;
    }
  }

  @Override
  public void handle(HttpExchange exchange) throws IOException {
    String target = exchange.getRequestHeaders().getFirst("X-Amz-Target");
    if (target == null) target = "";
    String operation =
        target.contains(".") ? target.substring(target.lastIndexOf('.') + 1) : target;

    byte[] bodyBytes;
    try (InputStream is = exchange.getRequestBody()) {
      bodyBytes = is.readAllBytes();
    }
    @SuppressWarnings("unchecked")
    Map<String, Object> body =
        bodyBytes.length > 0 ? MAPPER.readValue(bodyBytes, Map.class) : new LinkedHashMap<>();

    long startMs = System.currentTimeMillis();
    int[] statusHolder = {200};
    try {
      if (IamMiddleware.applyIamAuth(state, "states", operation, exchange, false)) {
        statusHolder[0] = 403;
        return;
      }
      if (FakeMiddleware.applyFake(state, "stepfunctions", operation, exchange)) {
        statusHolder[0] = 200;
        return;
      }
      if (ChaosMiddleware.applyChaos(state, "stepfunctions", operation, exchange, false)) {
        statusHolder[0] = 500;
        return;
      }

      handleOperation(operation, body, exchange);
    } catch (InterruptedException e) {
      Thread.currentThread().interrupt();
      statusHolder[0] = 500;
      sendJson(exchange, 500, Map.of("__type", "InternalFailure", "message", "Interrupted"));
    } catch (Exception e) {
      statusHolder[0] = 400;
      sendJson(
          exchange,
          400,
          Map.of(
              "__type",
              "ValidationException",
              "message",
              e.getMessage() != null ? e.getMessage() : "Error"));
    } finally {
      double durationMs = System.currentTimeMillis() - startMs;
      Map<String, Object> logEntry = new LinkedHashMap<>();
      logEntry.put("service", "stepfunctions");
      logEntry.put("handler", operation);
      logEntry.put("level", statusHolder[0] >= 500 ? "ERROR" : "INFO");
      logEntry.put("status_code", statusHolder[0]);
      logEntry.put("duration_ms", durationMs);
      logEntry.put("timestamp", Instant.now().toString());
      state.addLog(logEntry);
    }
  }

  @SuppressWarnings("unchecked")
  private void handleOperation(String operation, Map<String, Object> body, HttpExchange exchange)
      throws IOException {
    switch (operation) {
      case "CreateStateMachine":
        {
          String name = (String) body.get("name");
          String arn = store.stateMachineArn(name);
          if (store.stateMachineExists(arn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineAlreadyExists",
                    "message",
                    "State Machine Already Exists"));
            break;
          }
          Map<String, Object> sm = store.createStateMachine(name, body);
          sendJson(
              exchange,
              200,
              Map.of("stateMachineArn", arn, "creationDate", sm.getOrDefault("creationDate", 0.0)));
          break;
        }
      case "DeleteStateMachine":
        {
          String arn = (String) body.get("stateMachineArn");
          if (!store.stateMachineExists(arn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineDoesNotExist",
                    "message",
                    "State machine does not exist: " + arn));
            break;
          }
          store.deleteStateMachine(arn);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "DescribeStateMachine":
        {
          String arn = (String) body.get("stateMachineArn");
          Map<String, Object> sm = store.getStateMachine(arn);
          if (sm == null) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineDoesNotExist",
                    "message",
                    "State machine does not exist: " + arn));
            return;
          }
          sendJson(exchange, 200, sm);
          break;
        }
      case "ListStateMachines":
        {
          List<Map<String, Object>> list = store.listStateMachines();
          sendJson(exchange, 200, Map.of("stateMachines", list));
          break;
        }
      case "UpdateStateMachine":
        {
          String arn = (String) body.get("stateMachineArn");
          store.updateStateMachine(arn, body);
          sendJson(exchange, 200, Map.of("updateDate", Instant.now().getEpochSecond() * 1.0));
          break;
        }
      case "ValidateStateMachineDefinition":
        {
          sendJson(exchange, 200, Map.of("result", "OK", "diagnostics", List.of()));
          break;
        }
      case "ListStateMachineVersions":
        {
          String smArn = (String) body.get("stateMachineArn");
          if (!store.stateMachineExists(smArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineDoesNotExist",
                    "message",
                    "State machine does not exist: " + smArn));
            break;
          }
          sendJson(exchange, 200, Map.of("stateMachineVersions", List.of()));
          break;
        }
      case "StartExecution":
        {
          if (state.getCapacityConfig("stepfunctions").isExhausted()) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ExecutionLimitExceeded",
                    "message",
                    "The maximum number of running executions has been reached."));
            break;
          }
          String smArn = (String) body.get("stateMachineArn");
          if (!store.stateMachineExists(smArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineDoesNotExist",
                    "message",
                    "State machine does not exist: " + smArn));
            return;
          }
          String execName =
              body.containsKey("name") ? (String) body.get("name") : UUID.randomUUID().toString();
          String input = (String) body.getOrDefault("input", "{}");
          String output = executeSynchronously(smArn, input);
          Map<String, Object> exec = store.startExecutionWithOutput(smArn, execName, input, output);
          sendJson(
              exchange,
              200,
              Map.of("executionArn", exec.get("executionArn"), "startDate", exec.get("startDate")));
          break;
        }
      case "StartSyncExecution":
        {
          if (state.getCapacityConfig("stepfunctions").isExhausted()) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ExecutionLimitExceeded",
                    "message",
                    "The maximum number of running executions has been reached."));
            break;
          }
          String smArn = (String) body.get("stateMachineArn");
          if (!store.stateMachineExists(smArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineDoesNotExist",
                    "message",
                    "State machine does not exist: " + smArn));
            break;
          }
          String execName =
              body.containsKey("name") ? (String) body.get("name") : UUID.randomUUID().toString();
          String execArn =
              "arn:aws:states:us-east-1:000000000000:express:"
                  + (smArn.contains(":") ? smArn.substring(smArn.lastIndexOf(':') + 1) : smArn)
                  + ":"
                  + execName;
          double now = Instant.now().getEpochSecond() * 1.0;
          String input = (String) body.getOrDefault("input", "{}");
          String output = executeSynchronously(smArn, input);
          sendJson(
              exchange,
              200,
              Map.of(
                  "executionArn", execArn,
                  "stateMachineArn", smArn,
                  "name", execName,
                  "status", "SUCCEEDED",
                  "startDate", now,
                  "stopDate", now,
                  "input", input,
                  "output", output));
          break;
        }
      case "StopExecution":
        {
          String execArn = (String) body.get("executionArn");
          if (!store.executionExists(execArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ExecutionDoesNotExist",
                    "message",
                    "Execution does not exist: " + execArn));
            break;
          }
          double stopDate = Instant.now().getEpochSecond() * 1.0;
          store.stopExecution(execArn, stopDate);
          sendJson(exchange, 200, Map.of("stopDate", stopDate));
          break;
        }
      case "DescribeExecution":
        {
          String execArn = (String) body.get("executionArn");
          Map<String, Object> exec = store.getExecution(execArn);
          if (exec == null) {
            exec =
                Map.of(
                    "executionArn",
                    execArn,
                    "status",
                    "RUNNING",
                    "startDate",
                    Instant.now().getEpochSecond() * 1.0,
                    "input",
                    "{}");
          }
          sendJson(exchange, 200, exec);
          break;
        }
      case "ListExecutions":
        {
          String smArn = (String) body.get("stateMachineArn");
          if (!store.stateMachineExists(smArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "StateMachineDoesNotExist",
                    "message",
                    "State machine does not exist: " + smArn));
            break;
          }
          List<Map<String, Object>> list = store.listExecutions(smArn);
          sendJson(exchange, 200, Map.of("executions", list));
          break;
        }
      case "GetExecutionHistory":
        {
          String execArn = (String) body.get("executionArn");
          if (execArn == null || !store.executionExists(execArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ExecutionDoesNotExist",
                    "message",
                    "Execution does not exist: " + execArn));
            break;
          }
          sendJson(exchange, 200, Map.of("events", List.of()));
          break;
        }
      case "ListTagsForResource":
        {
          String resourceArn = (String) body.get("resourceArn");
          if (!store.stateMachineExists(resourceArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ResourceNotFound", "message", "Resource not found: " + resourceArn));
            break;
          }
          List<Map<String, String>> tags = store.listTags(resourceArn);
          sendJson(exchange, 200, Map.of("tags", tags));
          break;
        }
      case "TagResource":
        {
          String resourceArn = (String) body.get("resourceArn");
          if (!store.stateMachineExists(resourceArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ResourceNotFound", "message", "Resource not found: " + resourceArn));
            break;
          }
          List<Map<String, Object>> newTags =
              (List<Map<String, Object>>) body.getOrDefault("tags", List.of());
          store.tagResource(resourceArn, newTags);
          sendJson(exchange, 200, Map.of());
          break;
        }
      case "UntagResource":
        {
          String resourceArn = (String) body.get("resourceArn");
          if (!store.stateMachineExists(resourceArn)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type", "ResourceNotFound", "message", "Resource not found: " + resourceArn));
            break;
          }
          List<String> tagKeys = (List<String>) body.getOrDefault("tagKeys", List.of());
          if (!store.allTagsFound(resourceArn, tagKeys)) {
            sendJson(
                exchange,
                400,
                Map.of(
                    "__type",
                    "ResourceNotFound",
                    "message",
                    "Tag not found on resource: " + resourceArn));
            break;
          }
          store.untagResource(resourceArn, tagKeys);
          sendJson(exchange, 200, Map.of());
          break;
        }
      default:
        {
          sendJson(
              exchange,
              400,
              Map.of(
                  "__type",
                  "UnknownOperationException",
                  "message",
                  "Not implemented: " + operation));
        }
    }
  }

  private void sendJson(HttpExchange exchange, int status, Object body) throws IOException {
    byte[] bytes = MAPPER.writeValueAsBytes(body);
    exchange.getResponseHeaders().set("Content-Type", "application/x-amz-json-1.0");
    exchange.sendResponseHeaders(status, bytes.length);
    try (OutputStream os = exchange.getResponseBody()) {
      os.write(bytes);
    }
  }
}
