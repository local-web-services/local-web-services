"""Then: the "s3 tables" "table" will be in "MAINTENANCE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "s3 tables" "table" will be in "MAINTENANCE" state')
def table_enters_maintenance_then():
    pytest.skip("Cannot observe internal table MAINTENANCE state in lws")
