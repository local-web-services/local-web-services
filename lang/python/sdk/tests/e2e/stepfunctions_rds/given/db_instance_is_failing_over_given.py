"""Given: the "DB" instance is "FAILING_OVER" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "DB" instance is "FAILING_OVER"')
def db_instance_is_failing_over_given(lws_session, world):
    pytest.skip("Cannot put an RDS DB instance into FAILING_OVER state in lws")
