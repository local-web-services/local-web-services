"""Given: the "memorydb" "cluster" was "UPDATING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "memorydb" "cluster" was "UPDATING"')
def cluster_is_updating_given(lws_session, world):
    pytest.skip("Cannot put a MemoryDB cluster into UPDATING state in lws")
