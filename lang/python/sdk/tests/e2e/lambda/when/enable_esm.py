"""When: a disabled event source mapping is enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a disabled event source mapping is enabled")
def enable_esm(lws_session, world):
    pytest.skip("Cannot enable ESM in lws without a real event source mapping UUID")
