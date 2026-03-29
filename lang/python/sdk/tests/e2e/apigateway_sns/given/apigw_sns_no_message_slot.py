"""Given: no message slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no message slot is available")
def apigw_sns_no_message_slot():
    pytest.skip("Cannot simulate exhausted message slots in lws")
