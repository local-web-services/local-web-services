"""Given: a "lambda" "invocation" was "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "lambda" "invocation" was "IN_PROGRESS"')
def dynamodb_lambda_invocation_is_in_progress(lws_session, world):
    world["_skip"] = "Cannot observe in-progress DynamoDB->Lambda invocations in lws."
    pytest.skip(world["_skip"])
