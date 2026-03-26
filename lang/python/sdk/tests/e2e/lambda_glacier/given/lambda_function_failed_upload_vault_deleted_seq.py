"""Given: the Lambda function has failed to upload because the vault has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has failed to upload because the vault has been deleted")
def lambda_function_failed_upload_vault_deleted_seq():
    pytest.skip("Cannot trigger Lambda invocation failure in lws")
