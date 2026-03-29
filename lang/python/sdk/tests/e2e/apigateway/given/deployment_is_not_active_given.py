"""Given: the deployment is not "ACTIVE" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the deployment is not "ACTIVE"')
def deployment_is_not_active_given():
    pytest.skip("Cannot set deployment to non-ACTIVE state in this abstract context")
