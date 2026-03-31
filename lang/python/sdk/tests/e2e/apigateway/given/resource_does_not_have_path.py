"""Given: the "api gateway" "resource" does not have a path"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "api gateway" "resource" does not have a path')
def resource_does_not_have_path():
    pytest.skip("Cannot create a resource without a path in this abstract context")
