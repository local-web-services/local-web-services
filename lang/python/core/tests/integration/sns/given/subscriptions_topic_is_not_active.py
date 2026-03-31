"""Given: the "sns" "subscription"'s "sns" "topic" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the subscription\'s topic is not "ACTIVE"')
def subscriptions_topic_is_not_active():
    pytest.skip("Cannot configure lifecycle state in integration test context")
