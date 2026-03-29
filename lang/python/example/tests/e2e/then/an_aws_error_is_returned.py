"""Then: an AWS error is returned"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import ScenarioContext


@then("an AWS error is returned")
def an_aws_error_is_returned(ctx: ScenarioContext) -> None:
    assert (
        ctx.last_error is not None
    ), f"expected an AWS error but got nil; output: {ctx.last_output}"
