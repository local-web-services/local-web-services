"""Given: the domain is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the domain is deleted")
def domain_is_deleted_given():
    pytest.skip("Cannot use a deleted domain as a precondition in lws")
