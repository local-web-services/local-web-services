"""Then: "dynamodb" reads will be throttled or unthrottled"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('"dynamodb" reads will be throttled or unthrottled')
def reads_throttled_or_unthrottled():
    pytest.skip("Cannot observe read throttle state in this abstract context")
