"""Given: the instance has multi-"AZ" enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance has multi-"AZ" enabled')
def instance_has_multi_az():
    pytest.skip("Cannot configure multi-AZ for RDS instance in this context")
