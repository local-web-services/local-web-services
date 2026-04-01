"""Then: the "opensearch" "domain" will be "PROCESSING" and "API" calls may fail"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "opensearch" "domain" will be "PROCESSING" and "API" calls may fail')
def domain_is_processing_then(lws_session):
    pytest.skip("Cannot observe OpenSearch domain PROCESSING state in lws")
