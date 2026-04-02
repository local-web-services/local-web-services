"""Given: no "api gateway" "resource" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "api gateway" "resource" "slot" was "available"')
def no_resource_slot_available(world):
    pytest.skip("Cannot exhaust resource slots in stateless integration tests.")
