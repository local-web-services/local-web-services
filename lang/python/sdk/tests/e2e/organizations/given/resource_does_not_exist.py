"""Given: the "organizations" resource did not exist"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "organizations" resource did not exist')
def resource_does_not_exist():
    pytest.skip("Cannot test tagging a non-existent resource in this context")
