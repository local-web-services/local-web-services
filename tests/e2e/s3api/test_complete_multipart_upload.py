"""E2E test for S3 complete-multipart-upload CLI command."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCompleteMultipartUpload:
    def test_complete_multipart_upload(self, e2e_port, tmp_path, lws_invoke, parse_output):
        # Arrange
        bucket = "e2e-complete-mp"
        key = "e2e-complete.bin"
        part_content = b"complete-data"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)])
        create_body = lws_invoke(
            [
                "s3api",
                "create-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--port",
                str(e2e_port),
            ]
        )
        upload_id = create_body["InitiateMultipartUploadResult"]["UploadId"]
        part_file = tmp_path / "part.bin"
        part_file.write_bytes(part_content)
        upload_body = lws_invoke(
            [
                "s3api",
                "upload-part",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--part-number",
                "1",
                "--body",
                str(part_file),
                "--port",
                str(e2e_port),
            ]
        )
        etag = upload_body["ETag"]
        parts_json = json.dumps({"Parts": [{"PartNumber": 1, "ETag": etag}]})

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "complete-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--multipart-upload",
                parts_json,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
