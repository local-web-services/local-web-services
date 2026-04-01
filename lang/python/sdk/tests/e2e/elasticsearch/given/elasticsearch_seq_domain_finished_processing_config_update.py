"""Given: an "elasticsearch" "domain" finishes processing its configuration update"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an "elasticsearch" "domain" finishes processing its configuration update')
def elasticsearch_seq_domain_finished_processing_config_update():
    pytest.skip("Cannot simulate config update completion in lws")
