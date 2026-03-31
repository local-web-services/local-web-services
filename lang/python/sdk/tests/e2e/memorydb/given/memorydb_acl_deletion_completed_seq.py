"""Given: an "memorydb" "ACL" deletion completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "memorydb" "ACL" deletion completes')
def memorydb_acl_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL deletion completion in lws")
