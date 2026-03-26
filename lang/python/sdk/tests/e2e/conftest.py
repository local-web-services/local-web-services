"""Session-scoped fixtures and shared BDD step definitions."""

from __future__ import annotations

import pytest

from lws_testing.session import LwsSession

# Import step packages — each __init__.py aggregates its step files.
# Wildcard into conftest namespace so pytest-bdd can discover step definitions.
from .given import *  # noqa: F401,F403
from .then import *  # noqa: F401,F403
from .when import *  # noqa: F401,F403


@pytest.fixture(scope="session")
def lws_session():
    """Start all LWS services in-process for the entire test session."""
    with LwsSession() as session:
        yield session


@pytest.fixture(autouse=True)
def reset_lws_between_scenarios(lws_session):
    """Reset all service state before each scenario."""
    lws_session.reset()


@pytest.fixture
def world():
    """Per-scenario mutable state shared across all BDD steps."""
    return {
        "result": None,
        "error": None,
        "receipt_handle": None,
        "topic_arn": None,
        "subscription_arn": None,
        "execution_arn": None,
        "state_machine_arn": None,
        "state_machine_name": None,
        "upload_id": None,
        "version_id": None,
    }
