"""Given: the "documentdb" "instance" is the primary"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" is the primary')
def instance_is_the_primary(world):
    pytest.skip("Primary instance tracking is not available in stateless integration tests.")
