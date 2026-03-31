"""Given: the delivery existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the delivery existed")
def delivery_exists():
    pytest.skip("Cannot create in-flight delivery programmatically")
