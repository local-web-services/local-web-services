"""pytest-bdd step definitions for the LWS example BDD suite."""

from __future__ import annotations

import json
import time
from typing import Any, Optional

import pytest
from pytest_bdd import given, parsers, then, when

from lws_testing import LwsSession
from src.order_processor import process_order

STATE_MACHINE_DEFINITION = json.dumps({
    "Comment": "Simple order processor — passes input through as output",
    "StartAt": "ProcessOrder",
    "States": {
        "ProcessOrder": {
            "Type": "Pass",
            "End": True,
        }
    },
})


class ScenarioContext:
    """Holds per-scenario state, shared across step definitions via the ctx fixture."""

    def __init__(self, shared: LwsSession) -> None:
        self.session: Any = shared
        self.sfn_client: Any = None
        self.state_machine_arn: str = ""
        self.last_output: Optional[dict] = None
        self.last_error: Optional[Exception] = None
        self.log_capture: Any = None
        self._log_capture_cm: Any = None
        self.sfn_fake_builder: Any = None
        self.fake_execution_arn: str = ""
        self.processed_outputs: list = []
        self.processed_ids: list = []
        self.ddb_helper: Any = None
        self.sqs_helper: Any = None
        self._dedicated_session_cm: Any = None


@pytest.fixture(scope="module")
def shared_session():
    """One LwsSession server shared across all BDD scenarios in this module."""
    with LwsSession() as s:
        yield s


@pytest.fixture
def ctx(shared_session: LwsSession):
    """Per-scenario context. Resets the shared session before each scenario."""
    shared_session.reset()
    c = ScenarioContext(shared_session)
    yield c
    # Teardown: stop log capture and close any dedicated per-scenario session
    if c._log_capture_cm is not None:
        try:
            c._log_capture_cm.__exit__(None, None, None)
        except Exception:
            pass
    if c._dedicated_session_cm is not None:
        try:
            c._dedicated_session_cm.__exit__(None, None, None)
        except Exception:
            pass


# ---------------------------------------------------------------------------
# Given steps — session setup
# ---------------------------------------------------------------------------

@given("an OrderProcessor state machine is running")
def setup_order_processor(ctx: ScenarioContext) -> None:
    sfn = ctx.session.client("stepfunctions")
    response = sfn.create_state_machine(
        name="OrderProcessor",
        definition=STATE_MACHINE_DEFINITION,
        roleArn="arn:aws:iam::000000000000:role/StepFunctionsRole",
        type="STANDARD",
    )
    ctx.sfn_client = sfn
    ctx.state_machine_arn = response["stateMachineArn"]


@given("no state machines are configured")
def no_state_machines_configured(ctx: ScenarioContext) -> None:
    ctx.sfn_client = ctx.session.client("stepfunctions")


@given(parsers.parse('a session started from the "{dir}" HCL directory'))
def session_from_hcl_directory(ctx: ScenarioContext, dir: str) -> None:
    session_cm = LwsSession.from_hcl(dir)
    ctx._dedicated_session_cm = session_cm
    hcl_session = session_cm.__enter__()
    ctx.session = hcl_session
    sfn = hcl_session.client("stepfunctions")
    ctx.sfn_client = sfn
    state_machines = sfn.list_state_machines()["stateMachines"]
    ctx.state_machine_arn = state_machines[0]["stateMachineArn"]


@given(parsers.parse('a DynamoDB table "{name}" with partition key "{partition_key}"'))
def setup_dynamodb_table(ctx: ScenarioContext, name: str, partition_key: str) -> None:
    ddb = ctx.session.client("dynamodb")
    ddb.create_table(
        TableName=name,
        KeySchema=[{"AttributeName": partition_key, "KeyType": "HASH"}],
        AttributeDefinitions=[{"AttributeName": partition_key, "AttributeType": "S"}],
        BillingMode="PAY_PER_REQUEST",
    )
    ctx.ddb_helper = ctx.session.dynamodb(name)


@given(parsers.parse('an SQS queue named "{queue_name}"'))
def setup_sqs_queue(ctx: ScenarioContext, queue_name: str) -> None:
    sqs = ctx.session.client("sqs")
    sqs.create_queue(QueueName=queue_name)
    ctx.sqs_helper = ctx.session.sqs(queue_name)


@given(parsers.parse('StartExecution is faked to return execution ARN "{execution_arn}"'))
def fake_start_execution_arn(ctx: ScenarioContext, execution_arn: str) -> None:
    ctx.fake_execution_arn = execution_arn
    ctx.sfn_fake_builder = ctx.session.fake("stepfunctions")
    ctx.sfn_fake_builder.operation("start-execution").respond(
        body={
            "executionArn": execution_arn,
            "startDate": 1704067200.0,
        }
    )


@given(parsers.parse(
    'DescribeExecution is faked to return SUCCEEDED with output containing order ID "{order_id}"'
))
def fake_describe_execution_succeeded(ctx: ScenarioContext, order_id: str) -> None:
    fake_sm_arn = "arn:aws:states:us-east-1:000000000000:stateMachine:OrderProcessor"
    ctx.sfn_fake_builder.operation("describe-execution").respond(
        body={
            "executionArn": ctx.fake_execution_arn,
            "stateMachineArn": fake_sm_arn,
            "name": "fake-exec",
            "status": "SUCCEEDED",
            "startDate": 1704067200.0,
            "output": json.dumps({"orderId": order_id}),
        }
    )


@given(parsers.parse('StartExecution is faked to return error "{error_code}"'))
def fake_start_execution_error(ctx: ScenarioContext, error_code: str) -> None:
    ctx.session.fake("stepfunctions").operation("start-execution").error(
        error_type=error_code,
        message="Injected error for testing",
    )


@given(parsers.parse(
    'StartExecution is faked with a 10ms delay returning execution ARN "{execution_arn}"'
))
def fake_start_execution_delay(ctx: ScenarioContext, execution_arn: str) -> None:
    ctx.fake_execution_arn = execution_arn
    ctx.sfn_fake_builder = ctx.session.fake("stepfunctions")
    ctx.sfn_fake_builder.operation("start-execution").respond(
        body={
            "executionArn": execution_arn,
            "startDate": 1704067200.0,
        },
        delay_ms=10,
    )


@given(parsers.parse(
    'IAM is in enforce mode with identity "{identity}" allowed all actions on all resources'
))
def iam_enforce_mode_with_identity(ctx: ScenarioContext, identity: str) -> None:
    ctx.session.iam.identity(identity).allow(["*"]).apply()
    ctx.session.iam.mode("enforce").default_identity(identity).apply()


@given("stepfunctions chaos is set to 100% error rate")
def stepfunctions_chaos_100_percent(ctx: ScenarioContext) -> None:
    ctx.session.chaos("stepfunctions").error_rate(1.0).apply()


@given("log capture is active")
def log_capture_is_active(ctx: ScenarioContext) -> None:
    cm = ctx.session.capture_logs()
    ctx._log_capture_cm = cm
    ctx.log_capture = cm.__enter__()


@given(parsers.parse('order "{order_id}" has been processed'))
def order_has_been_processed(ctx: ScenarioContext, order_id: str) -> None:
    process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)


# ---------------------------------------------------------------------------
# When steps — actions
# ---------------------------------------------------------------------------

@when(parsers.parse('I process order "{order_id}"'))
def i_process_order(ctx: ScenarioContext, order_id: str) -> None:
    ctx.last_error = None
    ctx.last_output = None
    try:
        ctx.last_output = process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)
    except Exception as e:
        ctx.last_error = e


@when(parsers.parse('I process order "{order_id}" via ARN "{arn}"'))
def i_process_order_via_arn(ctx: ScenarioContext, order_id: str, arn: str) -> None:
    ctx.last_error = None
    ctx.last_output = None
    try:
        ctx.last_output = process_order(order_id, arn, ctx.sfn_client)
    except Exception as e:
        ctx.last_error = e


@when(parsers.parse('I process orders "{id1}", "{id2}", "{id3}"'))
def i_process_multiple_orders(ctx: ScenarioContext, id1: str, id2: str, id3: str) -> None:
    ctx.processed_outputs = []
    ctx.processed_ids = [id1, id2, id3]
    for order_id in ctx.processed_ids:
        output = process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)
        ctx.processed_outputs.append(output)


@when("I reset the session")
def i_reset_the_session(ctx: ScenarioContext) -> None:
    ctx.session.reset()


@when(parsers.parse('I start log capture and process order "{order_id}"'))
def i_start_log_capture_and_process_order(ctx: ScenarioContext, order_id: str) -> None:
    cm = ctx.session.capture_logs()
    ctx._log_capture_cm = cm
    ctx.log_capture = cm.__enter__()
    ctx.last_error = None
    ctx.last_output = None
    try:
        ctx.last_output = process_order(order_id, ctx.state_machine_arn, ctx.sfn_client)
    except Exception as e:
        ctx.last_error = e


@when(parsers.parse('I put item with orderId "{order_id}" and status "{status}" into "{table_name}"'))
def i_put_item(ctx: ScenarioContext, order_id: str, status: str, table_name: str) -> None:
    ctx.ddb_helper.put({"orderId": {"S": order_id}, "status": {"S": status}})


@when(parsers.parse('I send message body "{body}" to "{queue_name}"'))
def i_send_message(ctx: ScenarioContext, body: str, queue_name: str) -> None:
    ctx.sqs_helper.send(body)


# ---------------------------------------------------------------------------
# Then steps — assertions
# ---------------------------------------------------------------------------

@then(parsers.parse('the output will contain order ID "{expected_order_id}"'))
def the_output_will_contain_order_id(ctx: ScenarioContext, expected_order_id: str) -> None:
    assert ctx.last_error is None, f"expected no error but got: {ctx.last_error}"
    assert ctx.last_output is not None, "expected non-nil output"
    actual_order_id = ctx.last_output.get("orderId")
    assert actual_order_id == expected_order_id, (
        f"output orderId = {actual_order_id!r}, want {expected_order_id!r}"
    )


@then("each output will contain the corresponding order ID")
def each_output_contains_order_id(ctx: ScenarioContext) -> None:
    assert len(ctx.processed_outputs) == len(ctx.processed_ids), (
        f"expected {len(ctx.processed_ids)} outputs, got {len(ctx.processed_outputs)}"
    )
    for i, (output, expected_id) in enumerate(zip(ctx.processed_outputs, ctx.processed_ids)):
        actual_id = output.get("orderId")
        assert actual_id == expected_id, (
            f"output[{i}] orderId = {actual_id!r}, want {expected_id!r}"
        )


@then("an AWS error is returned")
def an_aws_error_is_returned(ctx: ScenarioContext) -> None:
    assert ctx.last_error is not None, (
        f"expected an AWS error but got nil; output: {ctx.last_output}"
    )


@then("the session accepts a second reset without error")
def session_accepts_second_reset(ctx: ScenarioContext) -> None:
    ctx.session.reset()


@then(parsers.parse('the log capture will have recorded a "{service}" "{operation}" call'))
def log_capture_recorded_call(ctx: ScenarioContext, service: str, operation: str) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    ctx.log_capture.assert_called(service, operation)


@then("no errors will appear in the log capture")
def no_errors_in_log_capture(ctx: ScenarioContext) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    ctx.log_capture.assert_no_errors()


@then("recent logs will be non-empty")
def recent_logs_non_empty(ctx: ScenarioContext) -> None:
    deadline = time.time() + 5.0
    while time.time() < deadline:
        logs = ctx.session.recent_logs()
        if logs:
            return
        time.sleep(0.05)
    raise AssertionError("expected non-empty recent logs after activity")


@then(parsers.parse('filtering logs by service "{service}" will return entries'))
def filtering_logs_by_service(ctx: ScenarioContext, service: str) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    entries = ctx.log_capture.for_service(service)
    assert entries, f"expected for_service({service!r}) to return entries but got none"


@then(parsers.parse('filtering logs by operation "{operation}" will return entries'))
def filtering_logs_by_operation(ctx: ScenarioContext, operation: str) -> None:
    assert ctx.log_capture is not None, "log capture is not active"
    entries = ctx.log_capture.for_operation(operation)
    assert entries, f"expected for_operation({operation!r}) to return entries but got none"


@then(parsers.parse('the table "{table_name}" will contain {count:d} item'))
@then(parsers.parse('the table "{table_name}" will contain {count:d} items'))
def table_contains_n_items(ctx: ScenarioContext, table_name: str, count: int) -> None:
    ctx.ddb_helper.assert_item_count(count)


@then(parsers.parse('the table "{table_name}" will contain an item with orderId "{order_id}"'))
def table_contains_item_with_order_id(ctx: ScenarioContext, table_name: str, order_id: str) -> None:
    ctx.ddb_helper.assert_item_exists({"orderId": {"S": order_id}})


@then(parsers.parse('receiving {count:d} message from "{queue_name}" will return body "{expected_body}"'))
@then(parsers.parse('receiving {count:d} messages from "{queue_name}" will return body "{expected_body}"'))
def receiving_message_returns_body(
    ctx: ScenarioContext, count: int, queue_name: str, expected_body: str
) -> None:
    actual_messages = ctx.sqs_helper.receive(max_messages=count)
    assert len(actual_messages) == count, (
        f"expected {count} message(s), got {len(actual_messages)}"
    )
    actual_body = actual_messages[0]["Body"]
    assert actual_body == expected_body, (
        f"message body = {actual_body!r}, want {expected_body!r}"
    )
