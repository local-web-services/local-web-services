"""Given: an OrderProcessor state machine is running"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import STATE_MACHINE_DEFINITION, ScenarioContext


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
