"""Then: the "sns" "delivery" retry count will be incremented"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "sns" "delivery" retry count will be incremented')
def delivery_retry_count_incremented_then(world):
    pytest.skip("Cannot observe delivery retry count increment in this context")
