import boto3
import json
import time


def process_order(order_id: str, state_machine_arn: str, sfn_client=None) -> dict:
    """
    Start an order processing Step Functions execution and return the result.

    Accepts an optional pre-configured boto3 SFN client. In production, omit
    the client and one will be created with default settings. In tests, pass
    ``session.client("stepfunctions")`` to point at the local-web-services emulator.
    """
    sfn = sfn_client or boto3.client("stepfunctions", region_name="us-east-1")
    response = sfn.start_execution(
        stateMachineArn=state_machine_arn,
        input=json.dumps({"orderId": order_id}),
    )
    return _poll_until_complete(sfn, response["executionArn"])


def _poll_until_complete(sfn, execution_arn: str) -> dict:
    while True:
        result = sfn.describe_execution(executionArn=execution_arn)
        status = result["status"]
        if status == "SUCCEEDED":
            return json.loads(result["output"])
        if status in ("FAILED", "TIMED_OUT", "ABORTED"):
            raise RuntimeError(f"Execution ended with status: {status}")
        time.sleep(0.1)
