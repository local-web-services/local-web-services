"""Given: the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" uploads an "glacier" "archive" to an existing vault and succeeds')
def lambda_function_uploaded_archive_succeeded_seq():
    pytest.skip("Cannot trigger Lambda archive upload in lws")
