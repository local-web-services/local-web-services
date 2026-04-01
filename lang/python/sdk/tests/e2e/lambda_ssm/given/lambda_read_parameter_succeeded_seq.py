"""Given: the "lambda" "function" reads an existing parameter and completes successfully"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" reads an existing parameter and completes successfully')
def lambda_read_parameter_succeeded_seq():
    pytest.skip("Cannot trigger Lambda SSM read in lws")
