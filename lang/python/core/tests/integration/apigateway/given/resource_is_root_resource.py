"""Given: the "api gateway" "resource" is the root "api gateway" "resource" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "resource" is the root "api gateway" "resource"')
def resource_is_root_resource(world):
    pytest.skip("Cannot delete a root resource in lws; deletion of root is rejected by design.")
