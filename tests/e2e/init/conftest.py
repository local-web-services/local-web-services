"""Shared fixtures for init E2E tests."""

from __future__ import annotations

import pytest
from pytest_bdd import given, parsers, then, when
from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


@pytest.fixture()
def project_dir(tmp_path):
    """Provide a temporary project directory for each scenario."""
    return tmp_path / "project"


# ── Given steps ──────────────────────────────────────────────────


@given(
    "an empty project directory was created",
    target_fixture="project_dir",
)
def an_empty_project_directory(tmp_path):
    d = tmp_path / "project"
    d.mkdir()
    return d


@given(
    parsers.parse('CLAUDE.md with content "{content}" was created in the project directory'),
)
def claude_md_with_content(content, project_dir):
    (project_dir / "CLAUDE.md").write_text(content)


@given(
    "lws init was already run in the project directory",
)
def lws_init_already_run(project_dir):
    result = runner.invoke(app, ["init", "--project-dir", str(project_dir)])
    if result.exit_code != 0:
        raise RuntimeError(f"Arrange failed (lws init): {result.output}")


# ── When steps ───────────────────────────────────────────────────


@when(
    "I run lws init in the project directory",
    target_fixture="command_result",
)
def i_run_lws_init(project_dir):
    return runner.invoke(app, ["init", "--project-dir", str(project_dir)])


# ── Then steps ───────────────────────────────────────────────────


@then("CLAUDE.md will exist in the project directory")
def claude_md_will_exist(project_dir):
    assert (project_dir / "CLAUDE.md").exists()


@then(
    parsers.parse('CLAUDE.md will contain "{text}"'),
)
def claude_md_will_contain(text, project_dir):
    actual_content = (project_dir / "CLAUDE.md").read_text()
    assert text in actual_content, f"Expected '{text}' in CLAUDE.md: {actual_content}"


@then(
    parsers.parse('"{path}" will exist in the project directory'),
)
def file_will_exist(path, project_dir):
    assert (project_dir / path).exists(), f"Expected {path} to exist in {project_dir}"


@then(
    parsers.parse('CLAUDE.md will contain exactly {count:d} occurrence of "{text}"'),
)
def claude_md_will_contain_count(count, text, project_dir):
    actual_content = (project_dir / "CLAUDE.md").read_text()
    expected_count = count
    actual_count = actual_content.count(text)
    assert (
        actual_count == expected_count
    ), f"Expected {expected_count} occurrences of '{text}', found {actual_count}"
