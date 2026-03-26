"""Given: the tag key exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the tag key exists")
def tag_key_exists():
    pytest.skip("Cannot configure domain tags in this context")
