"""Given: the "rds" "instance" has multi-"AZ" enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "rds" "instance" has multi-"AZ" enabled')
def instance_has_multi_az_enabled(world):
    pytest.skip("Multi-AZ state is not configurable in stateless integration tests.")
