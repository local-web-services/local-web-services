## MODIFIED Requirements
### Requirement: Object Storage Operations
The S3 provider SHALL support PutObject, GetObject, DeleteObject, and ListObjects operations using the local filesystem as the backing store. Objects SHALL be stored at `<data_dir>/s3/<bucket>/<key>` with metadata stored in sidecar JSON files at `<data_dir>/s3/.metadata/<bucket>/<key>.json`. The metadata sidecar SHALL contain Content-Type, user metadata, ETag (MD5 hex digest of the body), LastModified timestamp, and Size. Nested key paths (e.g., `docs/2024/file.txt`) SHALL create intermediate directories as needed.

#### Scenario: Put and get object
- **WHEN** a handler calls `s3.put_object(Bucket='MyBucket', Key='docs/file.txt', Body=b'hello')`
- **THEN** the object body SHALL be written to `<data_dir>/s3/MyBucket/docs/file.txt`, a metadata sidecar SHALL be created at `<data_dir>/s3/.metadata/MyBucket/docs/file.txt.json`, and a subsequent `s3.get_object(Bucket='MyBucket', Key='docs/file.txt')` SHALL return the stored content with correct Content-Type

#### Scenario: List objects by prefix
- **WHEN** a handler calls `s3.list_objects_v2(Bucket='MyBucket', Prefix='docs/')`
- **THEN** the response SHALL include all objects with keys starting with `docs/`

#### Scenario: Delete object
- **WHEN** a handler calls `s3.delete_object(Bucket='MyBucket', Key='docs/file.txt')`
- **THEN** both the object file and its metadata sidecar SHALL be removed, and a subsequent `get_object` for that key SHALL return a NoSuchKey error

#### Scenario: Object metadata in sidecar file
- **WHEN** a handler puts an object with a custom Content-Type and user metadata
- **THEN** the sidecar JSON file SHALL contain the Content-Type, user metadata, ETag (MD5 hex digest), LastModified timestamp, and Size
