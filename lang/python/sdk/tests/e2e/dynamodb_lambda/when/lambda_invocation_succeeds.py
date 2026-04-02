"""When: the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" invocation processes the "dynamodb" "stream" record successfully')
def lambda_invocation_succeeds(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    world["_skip"] = "Cannot observe DynamoDB->Lambda invocation completion in lws."
    pytest.skip(world["_skip"])
