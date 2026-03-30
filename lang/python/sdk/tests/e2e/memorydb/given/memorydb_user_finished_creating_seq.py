"""Given: a user has finished creating"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a user has finished creating")
def memorydb_user_finished_creating_seq():
    pytest.skip("Cannot trigger internal MemoryDB user creation completion in lws")
