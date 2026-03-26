"""Given: the message has not exceeded the maximum receive count"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the message has not exceeded the maximum receive count")
def message_not_exceeded_max_receive_count():
    pytest.skip("Cannot control receive count in this abstract context")
