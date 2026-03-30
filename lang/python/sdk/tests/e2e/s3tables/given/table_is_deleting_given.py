"""Given: the table is "DELETING" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the table is "DELETING"')
def table_is_deleting_given():
    pytest.skip("Cannot observe DELETING table state in lws")
