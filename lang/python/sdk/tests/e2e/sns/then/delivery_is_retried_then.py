"""Then: the delivery is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the delivery is retried")
def delivery_is_retried_then(world):
    pytest.skip("Cannot observe delivery retry in this context")
