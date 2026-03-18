/** Glacier wire-protocol Fastify plugin (REST JSON). */

import type { FastifyInstance, FastifyRequest, FastifyReply } from "fastify";
import { v4 as uuidv4 } from "uuid";
import type { ServerState } from "../../types";
import { applyChaos } from "../../middleware/chaos";
import { applyFake } from "../../middleware/fake";
import { applyIamAuth } from "../../middleware/iam";
import { createRequestContext, recordLog } from "../../middleware/logging";

const REGION = "us-east-1";
const ACCOUNT_ID = "000000000000";

interface Vault {
  VaultARN: string;
  VaultName: string;
  CreationDate: string;
  LastInventoryDate: string | null;
  NumberOfArchives: number;
  SizeInBytes: number;
}

interface Archive {
  archiveId: string;
  vaultName: string;
  description: string;
  size: number;
  checksum: string;
  creationDate: string;
}

interface Job {
  JobId: string;
  VaultARN: string;
  Action: string;
  StatusCode: string;
  StatusMessage: string;
  CreationDate: string;
  Completed: boolean;
  ArchiveId?: string;
  RetrievalByteRange?: string;
}

interface MultipartUpload {
  MultipartUploadId: string;
  VaultARN: string;
  PartSizeInBytes: number;
  CreationDate: string;
}

function jsonReply(reply: FastifyReply, data: unknown, status = 200): void {
  reply.status(status).header("Content-Type", "application/json").send(data);
}

export function registerGlacier(app: FastifyInstance, state: ServerState): void {
  const vaults = new Map<string, Vault>();
  const archives = new Map<string, Archive>();
  const jobs = new Map<string, Job>();
  const multipartUploads = new Map<string, MultipartUpload>();

  state.resetCallbacks.push(() => {
    vaults.clear();
    archives.clear();
    jobs.clear();
    multipartUploads.clear();
  });

  // Create vault: PUT /:accountId/vaults/:vaultName
  app.put("/:accountId/vaults/:vaultName", async (req: FastifyRequest, reply: FastifyReply) => {
    const { vaultName } = req.params as { vaultName: string };
    const ctx = createRequestContext("glacier", "CreateVault");

    if (await applyIamAuth(state, "glacier", "CreateVault", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "glacier", "CreateVault", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyFake(state, "glacier", "CreateVault", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const vault: Vault = {
      VaultARN: `arn:aws:glacier:${REGION}:${ACCOUNT_ID}:vaults/${vaultName}`,
      VaultName: vaultName,
      CreationDate: new Date().toISOString(),
      LastInventoryDate: null,
      NumberOfArchives: 0,
      SizeInBytes: 0,
    };
    vaults.set(vaultName, vault);
    reply.status(201).header("Location", `/${ACCOUNT_ID}/vaults/${vaultName}`).send();
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // Delete vault
  app.delete("/:accountId/vaults/:vaultName", async (req: FastifyRequest, reply: FastifyReply) => {
    const { vaultName } = req.params as { vaultName: string };
    const ctx = createRequestContext("glacier", "DeleteVault");

    if (await applyIamAuth(state, "glacier", "DeleteVault", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }
    if (await applyChaos(state, "glacier", "DeleteVault", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    vaults.delete(vaultName);
    reply.status(204).send();
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // Describe vault
  app.get("/:accountId/vaults/:vaultName", async (req: FastifyRequest, reply: FastifyReply) => {
    const { vaultName } = req.params as { vaultName: string };
    const ctx = createRequestContext("glacier", "DescribeVault");

    if (await applyIamAuth(state, "glacier", "DescribeVault", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    const vault = vaults.get(vaultName);
    if (!vault) {
      jsonReply(
        reply,
        { code: "ResourceNotFoundException", message: `Vault ${vaultName} not found` },
        404,
      );
    } else {
      jsonReply(reply, vault);
    }
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // List vaults
  app.get("/:accountId/vaults", async (req: FastifyRequest, reply: FastifyReply) => {
    const ctx = createRequestContext("glacier", "ListVaults");

    if (await applyIamAuth(state, "glacier", "ListVaults", req, reply)) {
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
      return;
    }

    jsonReply(reply, { VaultList: Array.from(vaults.values()) });
    recordLog(state, ctx, req.method, req.url, reply.statusCode);
  });

  // Upload archive
  app.post(
    "/:accountId/vaults/:vaultName/archives",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { vaultName } = req.params as { vaultName: string };
      const ctx = createRequestContext("glacier", "UploadArchive");

      if (await applyIamAuth(state, "glacier", "UploadArchive", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyChaos(state, "glacier", "UploadArchive", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const archiveId = uuidv4();
      const archive: Archive = {
        archiveId,
        vaultName,
        description: (req.headers["x-amz-archive-description"] as string) ?? "",
        size: parseInt((req.headers["content-length"] as string) ?? "0", 10),
        checksum: (req.headers["x-amz-sha256-tree-hash"] as string) ?? "",
        creationDate: new Date().toISOString(),
      };
      archives.set(archiveId, archive);
      const vault = vaults.get(vaultName);
      if (vault) {
        vault.NumberOfArchives++;
        vault.SizeInBytes += archive.size;
      }
      reply
        .status(201)
        .header("x-amz-archive-id", archiveId)
        .header("x-amz-sha256-tree-hash", archive.checksum)
        .send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // Delete archive
  app.delete(
    "/:accountId/vaults/:vaultName/archives/:archiveId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { vaultName, archiveId } = req.params as { vaultName: string; archiveId: string };
      const ctx = createRequestContext("glacier", "DeleteArchive");

      if (await applyIamAuth(state, "glacier", "DeleteArchive", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const archive = archives.get(archiveId);
      archives.delete(archiveId);
      const vault = vaults.get(vaultName);
      if (vault && archive) {
        vault.NumberOfArchives = Math.max(0, vault.NumberOfArchives - 1);
        vault.SizeInBytes = Math.max(0, vault.SizeInBytes - archive.size);
      }
      reply.status(204).send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // Initiate multipart upload
  app.post(
    "/:accountId/vaults/:vaultName/multipart-uploads",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { vaultName } = req.params as { vaultName: string };
      const ctx = createRequestContext("glacier", "InitiateMultipartUpload");

      if (await applyIamAuth(state, "glacier", "InitiateMultipartUpload", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const uploadId = uuidv4();
      const upload: MultipartUpload = {
        MultipartUploadId: uploadId,
        VaultARN: `arn:aws:glacier:${REGION}:${ACCOUNT_ID}:vaults/${vaultName}`,
        PartSizeInBytes: parseInt((req.headers["x-amz-part-size"] as string) ?? "4194304", 10),
        CreationDate: new Date().toISOString(),
      };
      multipartUploads.set(uploadId, upload);
      reply
        .status(201)
        .header("x-amz-multipart-upload-id", uploadId)
        .header("Location", `/${ACCOUNT_ID}/vaults/${vaultName}/multipart-uploads/${uploadId}`)
        .send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // Initiate job
  app.post(
    "/:accountId/vaults/:vaultName/jobs",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { vaultName } = req.params as { vaultName: string };
      const ctx = createRequestContext("glacier", "InitiateJob");

      if (await applyIamAuth(state, "glacier", "InitiateJob", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }
      if (await applyChaos(state, "glacier", "InitiateJob", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const body = req.body as Record<string, unknown>;
      const jobParams = (body.jobParameters ?? body) as Record<string, unknown>;
      const jobId = uuidv4();
      const job: Job = {
        JobId: jobId,
        VaultARN: `arn:aws:glacier:${REGION}:${ACCOUNT_ID}:vaults/${vaultName}`,
        Action: (jobParams.Type as string) ?? "InventoryRetrieval",
        StatusCode: "Succeeded",
        StatusMessage: "Succeeded",
        CreationDate: new Date().toISOString(),
        Completed: true,
        ArchiveId: jobParams.ArchiveId as string | undefined,
        RetrievalByteRange: jobParams.RetrievalByteRange as string | undefined,
      };
      jobs.set(jobId, job);
      reply
        .status(202)
        .header("x-amz-job-id", jobId)
        .header("Location", `/${ACCOUNT_ID}/vaults/${vaultName}/jobs/${jobId}`)
        .send();
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // List jobs
  app.get(
    "/:accountId/vaults/:vaultName/jobs",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const ctx = createRequestContext("glacier", "ListJobs");

      if (await applyIamAuth(state, "glacier", "ListJobs", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      jsonReply(reply, { JobList: Array.from(jobs.values()) });
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // Describe job
  app.get(
    "/:accountId/vaults/:vaultName/jobs/:jobId",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { jobId } = req.params as { jobId: string };
      const ctx = createRequestContext("glacier", "DescribeJob");

      if (await applyIamAuth(state, "glacier", "DescribeJob", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const job = jobs.get(jobId);
      if (!job) {
        jsonReply(
          reply,
          { code: "ResourceNotFoundException", message: `Job ${jobId} not found` },
          404,
        );
      } else {
        jsonReply(reply, job);
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );

  // Get job output
  app.get(
    "/:accountId/vaults/:vaultName/jobs/:jobId/output",
    async (req: FastifyRequest, reply: FastifyReply) => {
      const { jobId } = req.params as { jobId: string };
      const ctx = createRequestContext("glacier", "GetJobOutput");

      if (await applyIamAuth(state, "glacier", "GetJobOutput", req, reply)) {
        recordLog(state, ctx, req.method, req.url, reply.statusCode);
        return;
      }

      const job = jobs.get(jobId);
      if (!job) {
        jsonReply(
          reply,
          { code: "ResourceNotFoundException", message: `Job ${jobId} not found` },
          404,
        );
      } else {
        jsonReply(reply, {
          VaultARN: job.VaultARN,
          InventoryDate: new Date().toISOString(),
          ArchiveList: [],
        });
      }
      recordLog(state, ctx, req.method, req.url, reply.statusCode);
    },
  );
}
