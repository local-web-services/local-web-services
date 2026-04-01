"""Then: the "memorydb" "cluster" will be "AVAILABLE" again"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "memorydb" "cluster" will be "AVAILABLE" again')
def cluster_is_available_again_then(world):
    pytest.skip("Cannot observe MemoryDB cluster update completion in lws")
