"""Given: a "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "invocation" was "IN_PROGRESS"')
def cognito_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger Cognito->Lambda invocation in lws")
