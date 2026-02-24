package com.example.orders;

import software.amazon.awssdk.services.sfn.SfnClient;
import software.amazon.awssdk.services.sfn.model.DescribeExecutionRequest;
import software.amazon.awssdk.services.sfn.model.DescribeExecutionResponse;
import software.amazon.awssdk.services.sfn.model.StartExecutionRequest;
import software.amazon.awssdk.services.sfn.model.StartExecutionResponse;

/**
 * Starts a Step Functions execution for an order and polls until it completes.
 */
public class OrderProcessor {

    private final SfnClient sfnClient;

    /** Creates a processor using an explicit SFN client (inject in tests). */
    public OrderProcessor(SfnClient sfnClient) {
        this.sfnClient = sfnClient;
    }

    /** Creates a processor using the default AWS SDK configuration (used in production). */
    public OrderProcessor() {
        this.sfnClient = SfnClient.create();
    }

    /**
     * Starts an execution for the given order ID and returns the execution output.
     *
     * @param orderId        the order identifier
     * @param stateMachineArn the ARN of the state machine to execute
     * @return the raw JSON output from the execution
     */
    public String processOrder(String orderId, String stateMachineArn) throws InterruptedException {
        StartExecutionResponse started = sfnClient.startExecution(
                StartExecutionRequest.builder()
                        .stateMachineArn(stateMachineArn)
                        .input("{\"orderId\": \"" + orderId + "\"}")
                        .build());

        return pollUntilComplete(started.executionArn());
    }

    private String pollUntilComplete(String executionArn) throws InterruptedException {
        while (true) {
            DescribeExecutionResponse result = sfnClient.describeExecution(
                    DescribeExecutionRequest.builder()
                            .executionArn(executionArn)
                            .build());

            switch (result.statusAsString()) {
                case "SUCCEEDED" -> { return result.output(); }
                case "FAILED", "TIMED_OUT", "ABORTED" ->
                        throw new RuntimeException("Execution ended with status: " + result.statusAsString());
                default -> Thread.sleep(100);
            }
        }
    }
}
