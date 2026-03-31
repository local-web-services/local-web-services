"""When: a "memorydb" "user" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "memorydb" "user" finishes creating')
def user_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB user creation completion in lws")
