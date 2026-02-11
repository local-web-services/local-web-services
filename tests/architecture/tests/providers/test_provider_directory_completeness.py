"""Architecture test: every provider directory must have the expected files."""

from __future__ import annotations

from pathlib import Path

PROVIDERS_DIR = Path(__file__).parent.parent.parent.parent.parent / "src" / "lws" / "providers"

# Providers that do not need a provider.py file.
# These are stateless routes-only or non-provider directories.
PROVIDER_PY_EXCEPTIONS = {
    "iam", "sts", "lambda_runtime", "secretsmanager", "ssm",
    "glacier", "s3tables", "elasticache", "memorydb", "docdb",
    "neptune", "elasticsearch", "opensearch", "rds",
}


def _provider_dirs() -> list[Path]:
    """Return all provider subdirectories, excluding __pycache__ and __init__.py."""
    return sorted(p for p in PROVIDERS_DIR.iterdir() if p.is_dir() and not p.name.startswith("_"))


class TestProviderDirectoryCompleteness:
    def test_all_providers_have_routes(self):
        """Every provider directory must contain a routes.py file."""
        violations = []
        for provider_dir in _provider_dirs():
            routes_file = provider_dir / "routes.py"
            if not routes_file.exists():
                violations.append(f"{provider_dir.name}: missing routes.py")

        assert violations == [], "Provider directories missing routes.py:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_stateful_providers_have_provider_module(self):
        """Non-exception provider directories must contain a provider.py file."""
        violations = []
        for provider_dir in _provider_dirs():
            if provider_dir.name in PROVIDER_PY_EXCEPTIONS:
                continue
            provider_file = provider_dir / "provider.py"
            if not provider_file.exists():
                violations.append(f"{provider_dir.name}: missing provider.py")

        assert violations == [], "Provider directories missing provider.py:\n" + "\n".join(
            f"  - {v}" for v in violations
        )

    def test_all_providers_have_init(self):
        """Every provider directory must contain an __init__.py file."""
        violations = []
        for provider_dir in _provider_dirs():
            init_file = provider_dir / "__init__.py"
            if not init_file.exists():
                violations.append(f"{provider_dir.name}: missing __init__.py")

        assert violations == [], "Provider directories missing __init__.py:\n" + "\n".join(
            f"  - {v}" for v in violations
        )
