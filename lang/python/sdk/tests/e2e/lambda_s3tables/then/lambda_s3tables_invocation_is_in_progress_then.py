"""Then: the invocation is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "IN_PROGRESS"')
def lambda_s3tables_invocation_is_in_progress_then():
    pytest.skip("Cannot trigger Lambda invocation in lws")
