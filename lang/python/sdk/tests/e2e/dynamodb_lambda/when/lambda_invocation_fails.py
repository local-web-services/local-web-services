"""When: the "lambda" "function" invocation fails and the stream record is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the "lambda" "function" invocation fails and the stream record is retried')
def lambda_invocation_fails(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    world["_skip"] = "Cannot trigger DynamoDB->Lambda invocation failure in lws."
    pytest.skip(world["_skip"])
