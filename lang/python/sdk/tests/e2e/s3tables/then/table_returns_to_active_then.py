"""Then: the table returns to "ACTIVE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the table returns to "ACTIVE" state')
def table_returns_to_active_then():
    pytest.skip("Cannot observe internal table state transition in lws")
