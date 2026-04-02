"""Given: the "lambda" "event source mapping" was not "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was not "ENABLED"')
def dynamodb_lambda_esm_is_not_enabled(lws_session, world):
    world["_skip"] = "Cannot create a non-ENABLED event source mapping in lws."
    pytest.skip(world["_skip"])
