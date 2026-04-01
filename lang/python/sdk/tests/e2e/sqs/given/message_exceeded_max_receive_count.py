"""Given: the "sqs" "message" had exceeded the maximum receive count"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "message" had exceeded the maximum receive count')
def message_exceeded_max_receive_count():
    pytest.skip("Cannot control receive count in this abstract context")
