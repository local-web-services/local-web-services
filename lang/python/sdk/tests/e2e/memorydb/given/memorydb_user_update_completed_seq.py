"""Given: a user update has completed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user update has completed")
def memorydb_user_update_completed_seq():
    pytest.skip("Cannot trigger internal MemoryDB user update completion in lws")
