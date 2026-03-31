"""Given: a "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "invocation" was "IN_PROGRESS"')
def sm_lambda_invocation_is_in_progress():
    pytest.skip("Cannot trigger SecretsManager->Lambda invocation in lws")
