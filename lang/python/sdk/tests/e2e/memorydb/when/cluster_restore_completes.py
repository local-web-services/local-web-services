"""When: a "memorydb" "cluster" restore from "memorydb" "snapshot" completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "memorydb" "cluster" restore from "memorydb" "snapshot" completes')
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal MemoryDB cluster restore completion in lws")
