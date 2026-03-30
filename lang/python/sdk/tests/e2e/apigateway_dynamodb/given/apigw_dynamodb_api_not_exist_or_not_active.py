"""Given: the "API" does not exist or is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "API" does not exist or is not "ACTIVE"')
def apigw_dynamodb_api_not_exist_or_not_active():
    pytest.skip("Cannot simulate non-ACTIVE REST API in lws")
