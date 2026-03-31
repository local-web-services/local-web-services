"""Then: the execution will be "FAILED" with a connection error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution will be "FAILED" with a connection error')
def execution_failed_connection_error():
    pytest.skip("Cannot observe internal execution Lambda task failure in lws")
