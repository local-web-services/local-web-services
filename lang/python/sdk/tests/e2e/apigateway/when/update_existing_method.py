"""When: an existing method is updated"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an existing method is updated")
def update_existing_method(lws_session, world):
    pytest.skip("lws does not implement the UpdateMethod (PATCH method) route")
