"""Given: the resource is the root resource"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the resource is the root resource")
def resource_is_root_resource(world):
    pytest.skip("Cannot delete a root resource in lws; deletion of root is rejected by design.")
