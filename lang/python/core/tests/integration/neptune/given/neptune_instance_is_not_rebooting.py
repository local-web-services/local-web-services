"""Given: the "neptune" "instance" was not "REBOOTING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "neptune" "instance" was not "REBOOTING"')
def neptune_instance_is_not_rebooting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
