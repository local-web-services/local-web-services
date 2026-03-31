"""When: a "s3 tables" "table" finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "s3 tables" "table" finishes being deleted')
def finish_deleting_table(world: dict):
    pytest.skip("Internal lifecycle transition is not triggerable in integration context")
