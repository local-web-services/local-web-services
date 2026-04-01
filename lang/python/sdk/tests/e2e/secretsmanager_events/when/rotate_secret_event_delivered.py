"""When: a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when(
    'a "secretsmanager" "secret" rotation occurs and Secrets Manager delivers a "ROTATED" event to the bus'
)
def rotate_secret_event_delivered(lws_session, world):
    pytest.skip("Cannot trigger secret rotation in lws")
