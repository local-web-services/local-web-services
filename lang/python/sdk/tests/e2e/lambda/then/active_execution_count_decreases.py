"""Then: the active execution count decreases"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then("the active execution count decreases")
def active_execution_count_decreases(world):
    pytest.skip("Cannot observe Lambda execution count changes in lws")
