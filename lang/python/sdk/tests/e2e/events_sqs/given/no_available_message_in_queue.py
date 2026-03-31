"""Given: no "AVAILABLE" message existed in the queue"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "AVAILABLE" message existed in the queue')
def no_available_message_in_queue():
    pytest.skip("Cannot ensure no messages exist in an empty queue without creating it first")
