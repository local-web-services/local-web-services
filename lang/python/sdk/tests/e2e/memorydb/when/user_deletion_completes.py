"""When: a "memorydb" "user" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "memorydb" "user" deletion completes')
def user_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB user deletion completion in lws")
