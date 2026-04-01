"""Then: the invocation will be "FAILED" with a ResourceNotFoundException"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation will be "FAILED" with a ResourceNotFoundException')
def lambda_s3tables_invocation_failed_resource_not_found():
    pytest.skip("Cannot trigger Lambda->S3Tables invocation failure in lws")
