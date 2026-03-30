"""When: an enabled event source mapping is disabled"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("an enabled event source mapping is disabled")
def disable_esm(lws_session, world):
    pytest.skip("Cannot disable ESM in lws without a real event source mapping UUID")
