"""When: a table bucket finishes creating"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a table bucket finishes creating")
def finish_creating_table_bucket(world: dict):
    pytest.skip("Internal lifecycle transition is not triggerable in integration context")
