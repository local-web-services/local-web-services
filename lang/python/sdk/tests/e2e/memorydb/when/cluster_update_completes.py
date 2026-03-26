"""When: a MemoryDB cluster update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a MemoryDB cluster update completes")
def cluster_update_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster update completion in lws")
