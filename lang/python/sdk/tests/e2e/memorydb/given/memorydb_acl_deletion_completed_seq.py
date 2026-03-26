"""Given: an "ACL" deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "ACL" deletion has completed')
def memorydb_acl_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL deletion completion in lws")
