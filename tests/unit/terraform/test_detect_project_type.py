"""Tests for lws.terraform.detect -- project type detection."""

from __future__ import annotations

from pathlib import Path

from lws.terraform.detect import detect_project_type


class TestDetectProjectType:
    """Tests for the detect_project_type function."""

    def test_cdk_project(self, tmp_path: Path) -> None:
        """Detect CDK project when cdk.out directory exists."""
        cdk_out_dir = tmp_path / "cdk.out"
        cdk_out_dir.mkdir()

        result = detect_project_type(tmp_path)

        assert result == "cdk"

    def test_terraform_project(self, tmp_path: Path) -> None:
        """Detect Terraform project when .tf files exist."""
        tf_file = tmp_path / "main.tf"
        tf_file.write_text("# Terraform configuration")

        result = detect_project_type(tmp_path)

        assert result == "terraform"

    def test_ambiguous_project(self, tmp_path: Path) -> None:
        """Detect ambiguous project when both cdk.out and .tf files exist."""
        cdk_out_dir = tmp_path / "cdk.out"
        cdk_out_dir.mkdir()
        tf_file = tmp_path / "main.tf"
        tf_file.write_text("# Terraform configuration")

        result = detect_project_type(tmp_path)

        assert result == "ambiguous"

    def test_no_project(self, tmp_path: Path) -> None:
        """Detect no project when directory is empty."""
        result = detect_project_type(tmp_path)

        assert result == "none"
