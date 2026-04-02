"""Given: no "lambda" "invocation" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "lambda" "invocation" "slot" was "available"')
def s3api_lambda_no_invocation_slot_available(world):
    world["_skip"] = "lws does not fail put_object when no Lambda invocation slot is available"
    pytest.skip(world["_skip"])
