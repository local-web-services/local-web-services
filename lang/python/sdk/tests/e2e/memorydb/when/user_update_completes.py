"""When: a "memorydb" "user" update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "memorydb" "user" update completes')
def user_update_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB user update completion in lws")
