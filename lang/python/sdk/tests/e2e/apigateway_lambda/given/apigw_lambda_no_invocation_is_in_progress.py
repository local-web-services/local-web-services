"""Given: no invocation is "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given


@given('no invocation is "IN_PROGRESS"')
def apigw_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""
