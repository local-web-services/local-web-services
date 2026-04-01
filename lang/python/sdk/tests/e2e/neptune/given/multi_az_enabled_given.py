"""Given: multi-"AZ" was "ENABLED" for the "neptune" "cluster" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('multi-"AZ" was "ENABLED" for the "neptune" "cluster"')
def multi_az_enabled_given():
    pytest.skip("Cannot configure multi-AZ for Neptune cluster in this context")
