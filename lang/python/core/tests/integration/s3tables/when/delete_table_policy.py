"""When: a "s3 tables" "table"'s policy is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "s3 tables" "table"\'s policy is deleted')
def delete_table_policy(world: dict):
    pytest.skip("Table policy management is not implemented in the integration context")
