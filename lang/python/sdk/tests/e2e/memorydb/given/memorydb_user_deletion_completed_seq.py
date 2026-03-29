"""Given: a user deletion has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user deletion has completed")
def memorydb_user_deletion_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB user deletion completion in lws")
