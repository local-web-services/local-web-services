"""Then: the "glacier" "job" output will be marked as retrieved"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "glacier" "job" output will be marked as retrieved')
def job_output_marked_retrieved_then():
    pytest.skip("Cannot observe job output retrieval state in lws")
