"""Given: the resource is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the resource is not "ACTIVE"')
def resource_is_not_active_given():
    pytest.skip("Cannot set resource to non-ACTIVE state in this abstract context")
