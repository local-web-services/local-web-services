"""Given: the Lambda function has uploaded an archive to an existing vault and succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the Lambda function has uploaded an archive to an existing vault and succeeded")
def lambda_function_uploaded_archive_succeeded_seq():
    pytest.skip("Cannot trigger Lambda archive upload in lws")
