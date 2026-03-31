"""Then: the event will be queued in an async slot"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the event will be queued in an async slot")
def event_queued_in_async_slot(world):
    pytest.skip("Cannot observe Lambda async slot state in lws")
