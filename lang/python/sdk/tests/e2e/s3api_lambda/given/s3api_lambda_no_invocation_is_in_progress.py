"""Given: no "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

from pytest_bdd import given


@given('no "lambda" "invocation" was "IN_PROGRESS"')
def s3api_lambda_no_invocation_is_in_progress():
    """No-op: fresh state has no in-progress invocations."""
