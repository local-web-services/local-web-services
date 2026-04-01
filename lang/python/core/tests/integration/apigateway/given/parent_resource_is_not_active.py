"""Given: the parent "api gateway" "resource" was not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the parent "api gateway" "resource" was not "ACTIVE"')
def parent_resource_is_not_active(world):
    pytest.skip("Lifecycle-dependent state is not supported in stateless integration tests.")
