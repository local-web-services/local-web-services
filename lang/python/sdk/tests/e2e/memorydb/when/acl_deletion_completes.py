"""When: an "memorydb" "ACL" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "memorydb" "ACL" deletion completes')
def acl_deletion_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB ACL deletion completion in lws")
