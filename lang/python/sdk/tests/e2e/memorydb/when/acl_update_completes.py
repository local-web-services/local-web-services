"""When: an "memorydb" "ACL" update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "memorydb" "ACL" update completes')
def acl_update_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB ACL update completion in lws")
