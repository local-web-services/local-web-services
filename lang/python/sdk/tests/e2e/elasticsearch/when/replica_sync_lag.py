"""When: a replica sync lag event occurs on an active domain"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a replica sync lag event occurs on an active domain")
def replica_sync_lag(lws_session, world):
    pytest.skip("Cannot trigger internal replica sync lag event in lws")
