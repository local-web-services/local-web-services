"""Then: the domain is "PROCESSING" and "API" calls may fail"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the domain is "PROCESSING" and "API" calls may fail')
def domain_is_processing_then(lws_session):
    pytest.skip("Cannot observe Elasticsearch domain PROCESSING state in lws")
