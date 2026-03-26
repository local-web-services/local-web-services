"""Given: the Lambda invocation has completed successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda invocation has completed successfully")
def lambda_invocation_completed_successfully_seq():
    pytest.skip("Cannot create a completed Lambda invocation in lws")
