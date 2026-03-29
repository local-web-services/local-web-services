"""Then: the cluster is "UPDATING" and write operations may fail"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the cluster is "UPDATING" and write operations may fail')
def cluster_is_updating_then(world):
    pytest.skip("Cannot observe MemoryDB cluster updating state in lws")
