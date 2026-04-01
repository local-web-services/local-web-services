"""When: a "sns" "delivery" attempt succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "sns" "delivery" attempt succeeds')
def delivery_succeeds(world):
    pytest.skip("Cannot trigger delivery in integration test context")
