"""Given: a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded')
def running_execution_called_domain_succeeded_given():
    pytest.skip("Cannot pre-set a completed execution OpenSearch task state for sequence setup")
