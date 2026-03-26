"""Given: an "ACL" update has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "ACL" update has completed')
def memorydb_acl_update_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB ACL update completion in lws")
