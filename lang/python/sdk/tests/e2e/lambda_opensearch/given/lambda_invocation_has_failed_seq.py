"""Given: the Lambda invocation has failed"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has failed")
def lambda_invocation_has_failed_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
