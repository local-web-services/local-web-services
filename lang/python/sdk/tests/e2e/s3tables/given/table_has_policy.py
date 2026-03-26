"""Given: the table has a policy"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the table has a policy")
def table_has_policy(lws_session):
    pytest.skip("Cannot configure a table policy as a precondition in this context")
