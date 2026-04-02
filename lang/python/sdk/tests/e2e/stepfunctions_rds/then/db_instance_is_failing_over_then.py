"""Then: the "rds" "DB instance" will be "FAILING_OVER" and queries will be rejected"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "rds" "DB instance" will be "FAILING_OVER" and queries will be rejected')
def db_instance_is_failing_over_then(lws_session):
    pytest.skip("Cannot observe RDS DB instance FAILING_OVER state in lws")
