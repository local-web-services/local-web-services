"""When: an "memorydb" "ACL" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "memorydb" "ACL" finishes creating')
def acl_finishes_creating(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB ACL creation completion in lws")
