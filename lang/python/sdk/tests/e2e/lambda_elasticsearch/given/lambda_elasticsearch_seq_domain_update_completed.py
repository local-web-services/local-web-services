"""Given: the "elasticsearch" "domain" configuration update completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "elasticsearch" "domain" configuration update completes')
def lambda_elasticsearch_seq_domain_update_completed():
    pytest.skip(
        "Cannot trigger internal Elasticsearch domain configuration update completion in lws"
    )
