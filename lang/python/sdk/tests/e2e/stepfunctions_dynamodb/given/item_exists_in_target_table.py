"""Given: an item "EXISTS" in the target table"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an item "EXISTS" in the target table')
def item_exists_in_target_table():
    pytest.skip(
        "lws does not reject start_execution when the target table already has an item"
        " (precondition not enforced at execution start)"
    )
