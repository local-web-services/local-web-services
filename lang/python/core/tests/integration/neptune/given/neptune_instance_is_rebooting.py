"""Given: the instance is "REBOOTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is "REBOOTING"')
def neptune_instance_is_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
