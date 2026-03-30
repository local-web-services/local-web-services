"""Given: session_from_hcl_directory"""

from __future__ import annotations

from lws_testing import LwsSession
from pytest_bdd import given, parsers

from ..constants import ScenarioContext


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
