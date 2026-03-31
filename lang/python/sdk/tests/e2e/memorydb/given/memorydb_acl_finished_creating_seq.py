"""Given: an "memorydb" "ACL" finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "memorydb" "ACL" finishes creating')
def memorydb_acl_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL creation completion in lws")
