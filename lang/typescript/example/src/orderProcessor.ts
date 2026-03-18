import { SFNClient, StartExecutionCommand, DescribeExecutionCommand } from "@aws-sdk/client-sfn";

/**
 * Start an order processing Step Functions execution and return the result.
 *
 * Accepts an optional pre-configured SFNClient. In production, omit the client
 * and it will be created with default settings (reading endpoint from env vars
 * or the standard AWS config). In tests, pass `session.client("stepfunctions")`
 * to point at the local-web-services emulator.
 */
export async function processOrder(
  orderId: string,
  stateMachineArn: string,
  sfnClient?: SFNClient,
): Promise<Record<string, unknown>> {
  const sfn = sfnClient ?? new SFNClient({ region: "us-east-1" });

  const { executionArn } = await sfn.send(
    new StartExecutionCommand({
      stateMachineArn,
      input: JSON.stringify({ orderId }),
    }),
  );

  return pollUntilComplete(sfn, executionArn!);
}

async function pollUntilComplete(
  sfn: SFNClient,
  executionArn: string,
): Promise<Record<string, unknown>> {
  while (true) {
    const result = await sfn.send(new DescribeExecutionCommand({ executionArn }));
    if (result.status === "SUCCEEDED") {
      return JSON.parse(result.output!);
    }
    if (["FAILED", "TIMED_OUT", "ABORTED"].includes(result.status!)) {
      throw new Error(`Execution ended with status: ${result.status}`);
    }
    await new Promise((r) => setTimeout(r, 100));
  }
}
