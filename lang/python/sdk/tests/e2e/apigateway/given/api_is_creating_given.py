"""Given: the "API" is "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "API" is "CREATING"')
def api_is_creating_given(lws_session):
    """Enable lifecycle simulation so the next CreateRestApi call returns CREATING."""
    lws_session.lifecycle("apigateway").create_dwell_ms(5000).apply()
