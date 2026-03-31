"""Given: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given(
    'a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds'
)
def running_execution_called_domain_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution OpenSearch task state for sequence setup")
