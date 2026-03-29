"""Then: the replication group and its primary cluster are "AVAILABLE" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the replication group and its primary cluster are "AVAILABLE"')
def rg_and_primary_available_then():
    pytest.skip("Cannot observe internal replication group creation completion in lws")
