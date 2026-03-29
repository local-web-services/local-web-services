"""Given: the bus does not exist or is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bus does not exist or is not "ACTIVE"')
def bus_not_exist_or_not_active():
    pytest.skip(
        "lws does not reject enable_event_publishing when the bus does not exist or is not ACTIVE"
    )
