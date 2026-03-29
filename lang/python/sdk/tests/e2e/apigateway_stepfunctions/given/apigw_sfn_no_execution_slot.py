"""Given: no execution slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no execution slot is available")
def apigw_sfn_no_execution_slot():
    pytest.skip("Cannot simulate exhausted execution slots in lws")
