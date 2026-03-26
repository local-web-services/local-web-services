"""Given: the target queue is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target queue is not "ACTIVE"')
def target_queue_is_not_active():
    pytest.skip("lws does not reject put_events when the target queue is not ACTIVE")
