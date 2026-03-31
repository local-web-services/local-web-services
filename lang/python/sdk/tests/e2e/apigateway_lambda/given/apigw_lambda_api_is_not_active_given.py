"""Given: the "api gateway" "api" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "api" was not "ACTIVE"')
def apigw_lambda_api_is_not_active_given():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")
