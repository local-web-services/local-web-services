"""Given: the subscribed queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the subscribed queue is not "ACTIVE"')
def subscribed_queue_is_not_active(lws_session, world):
    pytest.skip("lws does not enforce queue lifecycle state during SNS publish/deliver")
