"""When: the lifecycle policy expires an object"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the lifecycle policy expires an object")
def lifecycle_expire_object_old(world):
    pytest.skip("Cannot trigger lifecycle expiry in this abstract context")
