"""Given: no request slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no request slot is available")
def apigw_sfn_no_request_slot():
    pytest.skip("Cannot simulate exhausted request slots in lws")
