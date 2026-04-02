"""Given: the "sns" "delivery" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "delivery" existed')
def delivery_exists():
    pytest.skip("Cannot create in-flight delivery programmatically")
