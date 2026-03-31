"""Given: the "api gateway" "resource" slot is already allocated"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "resource" slot is already allocated')
def resource_slot_allocated():
    pytest.skip("Cannot force a resource slot collision in this abstract context")
