"""Then: the execution is "FAILED" with a connection error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution ElastiCache task failure in lws")
