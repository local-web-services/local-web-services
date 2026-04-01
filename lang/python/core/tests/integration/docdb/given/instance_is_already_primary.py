"""Given: the "documentdb" "instance" was already the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was already the primary')
def instance_is_already_primary(world):
    pytest.skip("Primary instance state requires cluster setup not supported here.")
