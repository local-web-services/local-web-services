"""Given: no "request" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "request" "slot" was "available"')
def apigw_dynamodb_no_request_slot():
    pytest.skip("Cannot simulate exhausted request slots in lws")
