"""Given: no operation slot is available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no operation slot is available")
def aws_fake_no_operation_slot_available():
    pytest.skip("AWS fake service is not yet available in LwsSession")
