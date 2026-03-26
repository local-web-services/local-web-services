"""When: the Lambda function uploads an archive to an existing vault and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function uploads an archive to an existing vault and succeeds")
def lambda_uploads_archive(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
