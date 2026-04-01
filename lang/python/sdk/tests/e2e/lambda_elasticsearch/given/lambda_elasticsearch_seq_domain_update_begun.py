"""Given: a "elasticsearch" "domain" configuration update begins"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "elasticsearch" "domain" configuration update begins')
def lambda_elasticsearch_seq_domain_update_begun():
    pytest.skip("Cannot trigger internal Elasticsearch domain configuration update in lws")
