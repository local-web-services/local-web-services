"""Given: multi-"AZ" is enabled for the cluster"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('multi-"AZ" is enabled for the cluster')
def multi_az_enabled_given():
    pytest.skip("Cannot configure multi-AZ for Neptune cluster in this context")
