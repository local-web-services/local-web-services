"""Then: the "sns" "delivery" existed"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "delivery" existed')
def delivery_is_retried_then(world):
    pytest.skip("Cannot observe delivery retry in this context")
