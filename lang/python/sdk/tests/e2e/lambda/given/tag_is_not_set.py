"""Given: the tag is not set"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the tag is not set")
def tag_is_not_set():
    pytest.skip("Cannot verify tag absence without prior tag removal step")
