"""Then: "dynamodb" writes will be throttled or unthrottled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('"dynamodb" writes will be throttled or unthrottled')
def writes_throttled_or_unthrottled():
    pytest.skip("Cannot observe write throttle state in this abstract context")
