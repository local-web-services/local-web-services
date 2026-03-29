"""Given: the subscription's topic does not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the subscription's topic does not exist")
def subscriptions_topic_does_not_exist():
    pytest.skip("Cannot test subscription with non-existent topic in this context")
