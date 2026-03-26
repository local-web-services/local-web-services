"""Given: a running execution has failed because the domain is processing a config update"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a running execution has failed because the domain is processing a config update")
def running_execution_failed_domain_processing_given():
    pytest.skip("Cannot pre-set a failed execution OpenSearch task state for sequence setup")
