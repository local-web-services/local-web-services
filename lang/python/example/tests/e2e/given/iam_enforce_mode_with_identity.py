"""Given: iam_enforce_mode_with_identity"""

from __future__ import annotations

from pytest_bdd import given, parsers

from ..constants import ScenarioContext


@given(
    parsers.parse(
        'IAM is in enforce mode with identity "{identity}" allowed all actions on all resources'
    )
)
def iam_enforce_mode_with_identity(ctx: ScenarioContext, identity: str) -> None:
    ctx.session.iam.identity(identity).allow(["*"]).apply()
    ctx.session.iam.mode("enforce").default_identity(identity).apply()
