"""Given: a pending "lambda" "function" resolves its deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a pending "lambda" "function" resolves its deployment')
def lambda_seq_pending_resolved():
    pytest.skip("Cannot trigger Lambda PENDING->ACTIVE transition in lws")
