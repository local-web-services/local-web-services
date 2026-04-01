"""Given: multi-"AZ" was "ENABLED" for the "memorydb" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('multi-"AZ" was "ENABLED" for the "memorydb" "cluster"')
def multi_az_enabled_given():
    pytest.skip("Cannot configure multi-AZ for MemoryDB cluster in this context")
