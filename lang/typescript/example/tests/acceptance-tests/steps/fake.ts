import { Given } from "@cucumber/cucumber";
import { OrderWorld } from "../support/world";

Given(
  "StartExecution is faked to return execution ARN {string}",
  async function (this: OrderWorld, executionArn: string) {
    this.fakeExecutionArn = executionArn;
    this.sfnFakeBuilder = this.session!.fake("stepfunctions");
    await this.sfnFakeBuilder.operation("start-execution").respond({
      body: {
        executionArn,
        startDate: 1704067200.0,
      },
    });
  },
);

Given(
  "DescribeExecution is faked to return SUCCEEDED with output containing order ID {string}",
  async function (this: OrderWorld, orderId: string) {
    await this.sfnFakeBuilder!.operation("describe-execution").respond({
      body: {
        executionArn: this.fakeExecutionArn,
        stateMachineArn: "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor",
        name: "fake-exec",
        status: "SUCCEEDED",
        startDate: 1704067200.0,
        output: JSON.stringify({ orderId }),
      },
    });
  },
);

Given(
  "StartExecution is faked to return error {string}",
  async function (this: OrderWorld, errorCode: string) {
    await this.session!.fake("stepfunctions").operation("start-execution").error(errorCode);
  },
);

Given(
  "StartExecution is faked with a 10ms delay returning execution ARN {string}",
  async function (this: OrderWorld, executionArn: string) {
    this.fakeExecutionArn = executionArn;
    this.sfnFakeBuilder = this.session!.fake("stepfunctions");
    await this.sfnFakeBuilder.operation("start-execution").respond({
      body: {
        executionArn,
        startDate: 1704067200.0,
      },
      delayMs: 10,
    });
  },
);
