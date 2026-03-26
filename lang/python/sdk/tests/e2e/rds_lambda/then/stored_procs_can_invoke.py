"""Then: stored procedures on the "DB" can invoke the Lambda function"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('stored procedures on the "DB" can invoke the Lambda function')
def stored_procs_can_invoke():
    pytest.skip("Cannot configure RDS event trigger for Lambda in lws")
