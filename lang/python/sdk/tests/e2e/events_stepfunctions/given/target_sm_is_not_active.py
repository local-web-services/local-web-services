"""Given: the target state machine is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target state machine is not "ACTIVE"')
def target_sm_is_not_active():
    pytest.skip("lws does not reject put_events when the target state machine is not ACTIVE")
