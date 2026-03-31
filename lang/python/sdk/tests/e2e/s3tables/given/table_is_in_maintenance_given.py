"""Given: the "s3 tables" "table" was in "MAINTENANCE" state"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "s3 tables" "table" was in "MAINTENANCE" state')
def table_is_in_maintenance_given():
    pytest.skip("Cannot trigger internal table MAINTENANCE state in lws")
