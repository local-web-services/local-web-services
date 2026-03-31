"""When: a "s3 tables" "table"'s schema is evolved"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "s3 tables" "table"\'s schema is evolved')
def evolve_schema(world: dict):
    pytest.skip("Schema evolution is not available in integration context")
