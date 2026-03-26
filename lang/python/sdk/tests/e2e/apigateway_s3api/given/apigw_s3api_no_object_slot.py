"""Given: no object slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no object slot is available")
def apigw_s3api_no_object_slot():
    pytest.skip("Cannot simulate exhausted object slots in lws")
