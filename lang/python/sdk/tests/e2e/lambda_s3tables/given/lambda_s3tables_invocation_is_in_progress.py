"""Given: an invocation is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an invocation is "IN_PROGRESS"')
def lambda_s3tables_invocation_is_in_progress():
    pytest.skip("Cannot trigger Lambda invocation in lws")
