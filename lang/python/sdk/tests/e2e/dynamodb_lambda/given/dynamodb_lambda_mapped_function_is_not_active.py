"""Given: the mapped "lambda" "function" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapped "lambda" "function" was not "ACTIVE"')
def dynamodb_lambda_mapped_function_is_not_active(lws_session, world):
    world["_skip"] = "Cannot configure mapped function lifecycle state in lws."
    pytest.skip(world["_skip"])
