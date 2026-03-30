"""Given: the subscription does not belong to this topic"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the subscription does not belong to this topic")
def subscription_not_belong_to_topic():
    pytest.skip("Cannot test cross-topic subscription isolation in this context")
