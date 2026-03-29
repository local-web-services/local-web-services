"""Given: the instance is not "REBOOTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the instance is not "REBOOTING"')
def instance_is_not_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
