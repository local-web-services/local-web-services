"""Given: the "documentdb" "instance" was "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "documentdb" "instance" was "DELETING"')
def instance_is_deleting(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
