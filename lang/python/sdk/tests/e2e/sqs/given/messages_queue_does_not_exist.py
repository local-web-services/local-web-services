"""Given: the message's queue does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the message's queue does not exist")
def messages_queue_does_not_exist():
    pytest.skip("Cannot test non-existent queue for message in isolated context")
