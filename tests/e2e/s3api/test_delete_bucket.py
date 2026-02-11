from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestDeleteBucket:
    def test_delete_bucket(self, e2e_port, lws_invoke, assert_invoke):
        # Arrange
        bucket_name = "e2e-del-bkt"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "delete-bucket",
                "--bucket",
                bucket_name,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        verify = assert_invoke(["s3api", "list-buckets", "--port", str(e2e_port)])
        actual_names = [b["Name"] for b in verify.get("Buckets", [])]
        assert bucket_name not in actual_names
