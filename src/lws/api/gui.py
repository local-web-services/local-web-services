"""Self-contained HTML dashboard for LDK.

Returns an ``HTMLResponse`` with inline CSS and JavaScript — no external
dependencies, no build step, works offline.
"""

from __future__ import annotations

from fastapi.responses import HTMLResponse

_DASHBOARD_HTML = """\
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LDK Dashboard</title>
<style>
:root {
  --bg: #0f1117; --bg2: #1a1b26; --bg3: #24253a; --bg4: #2a2b3d;
  --fg: #c0caf5; --fg2: #565f89; --fg3: #414868;
  --accent: #7aa2f7; --green: #9ece6a; --yellow: #e0af68;
  --red: #f7768e; --cyan: #7dcfff; --magenta: #bb9af7; --orange: #ff9e64;
  --border: #292e42; --radius: 5px;
}
* { margin:0; padding:0; box-sizing:border-box; }
body { font-family:'SF Mono',Menlo,Consolas,monospace; background:var(--bg);
  color:var(--fg); font-size:13px; height:100vh; display:flex; flex-direction:column;
  overflow:hidden; }
header { background:var(--bg2); border-bottom:1px solid var(--border);
  padding:8px 16px; display:flex; align-items:center; gap:16px; flex-shrink:0; }
header h1 { font-size:15px; color:var(--accent); font-weight:700; letter-spacing:1px; }
nav { display:flex; gap:4px; }
nav button { background:none; border:1px solid transparent; color:var(--fg2);
  padding:5px 13px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
nav button:hover { color:var(--fg); background:var(--bg3); }
nav button.active { color:var(--accent); border-color:var(--accent); background:var(--bg3); }
.ws-dot { width:7px; height:7px; border-radius:50%; display:inline-block; margin-left:auto; }
.ws-dot.on { background:var(--green); box-shadow:0 0 4px var(--green); }
.ws-dot.off { background:var(--red); }
main { flex:1; overflow:hidden; position:relative; display:flex; flex-direction:column; }
.panel { display:none; flex:1; flex-direction:column; overflow:hidden; }
.panel.active { display:flex; }

/* ── Toolbar ── */
.toolbar { display:flex; gap:6px; align-items:center; padding:8px 16px;
  border-bottom:1px solid var(--border); flex-shrink:0; background:var(--bg); }
.toolbar button, .toolbar select, .toolbar input {
  background:var(--bg3); border:1px solid var(--border); color:var(--fg);
  padding:4px 10px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
.toolbar button:hover { border-color:var(--accent); }
.toolbar input { padding:4px 8px; min-width:140px; }
.toolbar input::placeholder { color:var(--fg3); }
.tb-count { color:var(--fg2); font-size:11px; margin-left:auto; white-space:nowrap; }
.tb-sep { width:1px; height:18px; background:var(--border); }

/* ── Badges ── */
.badge { display:inline-flex; align-items:center; padding:1px 5px;
  border-radius:3px; font-size:10px; font-weight:700; letter-spacing:0.3px;
  white-space:nowrap; line-height:1.6; }
.m-get    { background:rgba(125,207,255,.12); color:var(--cyan);    border:1px solid rgba(125,207,255,.3); }
.m-post   { background:rgba(122,162,247,.12); color:var(--accent);  border:1px solid rgba(122,162,247,.3); }
.m-put    { background:rgba(255,158,100,.12); color:var(--orange);  border:1px solid rgba(255,158,100,.3); }
.m-delete { background:rgba(247,118,142,.12); color:var(--red);     border:1px solid rgba(247,118,142,.3); }
.m-head   { background:rgba(86,95,137,.15);   color:var(--fg2);     border:1px solid var(--border); }
.m-patch  { background:rgba(187,154,247,.12); color:var(--magenta); border:1px solid rgba(187,154,247,.3); }
.s-2xx { background:rgba(158,206,106,.13); color:var(--green);   border:1px solid rgba(158,206,106,.3); }
.s-4xx { background:rgba(224,175,104,.13); color:var(--yellow);  border:1px solid rgba(224,175,104,.3); }
.s-5xx { background:rgba(247,118,142,.13); color:var(--red);     border:1px solid rgba(247,118,142,.3); }
.svc-badge { min-width:72px; text-align:center; font-size:10px; }
.svc-dynamodb    { background:rgba(122,162,247,.1); color:var(--accent);  border:1px solid rgba(122,162,247,.25); }
.svc-sqs         { background:rgba(255,158,100,.1); color:var(--orange);  border:1px solid rgba(255,158,100,.25); }
.svc-s3          { background:rgba(158,206,106,.1); color:var(--green);   border:1px solid rgba(158,206,106,.25); }
.svc-sns         { background:rgba(187,154,247,.1); color:var(--magenta); border:1px solid rgba(187,154,247,.25); }
.svc-events      { background:rgba(125,207,255,.1); color:var(--cyan);    border:1px solid rgba(125,207,255,.25); }
.svc-stepfunctions { background:rgba(187,154,247,.1); color:var(--magenta); border:1px solid rgba(187,154,247,.25); }
.svc-cognitoidp  { background:rgba(224,175,104,.1); color:var(--yellow);  border:1px solid rgba(224,175,104,.25); }
.svc-ssm         { background:rgba(125,207,255,.1); color:var(--cyan);    border:1px solid rgba(125,207,255,.25); }
.svc-secretsmanager { background:rgba(158,206,106,.1); color:var(--green); border:1px solid rgba(158,206,106,.25); }
.svc-lambda      { background:rgba(158,206,106,.1); color:var(--green);   border:1px solid rgba(158,206,106,.25); }
.svc-apigateway  { background:rgba(122,162,247,.1); color:var(--accent);  border:1px solid rgba(122,162,247,.25); }
.svc-other       { background:rgba(86,95,137,.15);  color:var(--fg2);     border:1px solid var(--border); }
.iam-allow { background:rgba(158,206,106,.15); color:var(--green);  border:1px solid rgba(158,206,106,.3); }
.iam-deny  { background:rgba(247,118,142,.15); color:var(--red);    border:1px solid rgba(247,118,142,.3); }
.iam-audit { background:rgba(224,175,104,.15); color:var(--yellow); border:1px solid rgba(224,175,104,.3); }

/* ── Event list ── */
#event-list { flex:1; overflow-y:auto; min-height:0; }
.ev-row { display:flex; align-items:center; gap:6px; padding:5px 16px;
  border-bottom:1px solid rgba(41,46,66,.6); cursor:pointer; transition:background .08s; }
.ev-row:hover { background:var(--bg2); }
.ev-row.sel { background:var(--bg3); border-left:2px solid var(--accent); padding-left:14px; }
.ev-ts { color:var(--fg2); font-size:11px; min-width:62px; }
.ev-op { flex:1; color:var(--fg); overflow:hidden; text-overflow:ellipsis; white-space:nowrap;
  font-size:12px; }
.ev-dur { color:var(--fg2); font-size:11px; min-width:42px; text-align:right; }

/* text log rows (non-request) */
.log-row { padding:4px 16px; border-bottom:1px solid rgba(41,46,66,.4); font-size:12px;
  line-height:1.5; white-space:pre-wrap; word-break:break-all; }
.log-row .ts  { color:var(--fg2); }
.log-row .lvl-DEBUG    { color:var(--fg2); }
.log-row .lvl-INFO     { color:var(--cyan); }
.log-row .lvl-WARNING  { color:var(--yellow); }
.log-row .lvl-ERROR    { color:var(--red); font-weight:600; }
.log-row .lvl-CRITICAL { color:var(--red); font-weight:700;
  background:rgba(247,118,142,.15); padding:0 3px; border-radius:2px; }

/* ── Detail panel ── */
#detail-panel { flex-shrink:0; height:340px; border-top:2px solid var(--border);
  overflow-y:auto; display:none; flex-direction:column; background:var(--bg); }
#detail-panel.open { display:flex; }
.detail-hdr { display:flex; align-items:center; gap:8px; padding:8px 16px;
  background:var(--bg2); border-bottom:1px solid var(--border);
  position:sticky; top:0; z-index:2; flex-shrink:0; }
.detail-hdr-title { flex:1; display:flex; align-items:center; gap:6px; flex-wrap:wrap; }
.detail-close { background:none; border:none; color:var(--fg2); cursor:pointer;
  font-size:14px; padding:2px 6px; border-radius:3px; }
.detail-close:hover { color:var(--fg); background:var(--bg3); }
.detail-body { flex:1; overflow-y:auto; }
.det-section { padding:10px 16px; border-bottom:1px solid var(--border); }
.det-section-title { color:var(--fg2); font-size:10px; letter-spacing:1.2px;
  text-transform:uppercase; margin-bottom:8px; font-weight:600; }
.det-kv { display:flex; flex-wrap:wrap; gap:16px; }
.det-kv-item { display:flex; flex-direction:column; gap:2px; }
.det-kv-key { color:var(--fg2); font-size:10px; }
.det-kv-val { color:var(--fg); font-size:12px; }
.det-pre { margin:0; padding:8px 10px; background:var(--bg3); border-radius:4px;
  font-size:11px; overflow-x:auto; white-space:pre-wrap; word-break:break-all;
  color:var(--fg); line-height:1.5; max-height:180px; overflow-y:auto; }

/* ── Resources panel ── */
#resources-panel { overflow-y:auto; }
.svc-group { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); margin:12px 16px 0; overflow:hidden; }
.svc-head { padding:10px 14px; display:flex; align-items:center; gap:10px;
  cursor:pointer; user-select:none; }
.svc-head:hover { background:var(--bg3); }
.svc-head .svc-name { font-weight:600; color:var(--accent); text-transform:uppercase;
  font-size:12px; }
.svc-head .svc-port { color:var(--fg2); font-size:11px; }
.svc-head .svc-health { margin-left:auto; font-size:11px; }
.svc-head .svc-health.healthy { color:var(--green); }
.svc-head .svc-health.unhealthy { color:var(--red); }
.svc-head .arrow { color:var(--fg2); transition:transform .15s; font-size:10px; }
.svc-head .arrow.open { transform:rotate(90deg); }
.svc-body { border-top:1px solid var(--border); }
.res-row { padding:8px 14px; display:flex; align-items:center; gap:8px;
  border-bottom:1px solid var(--border); }
.res-row:last-child { border-bottom:none; }
.res-row .rn { flex:1; font-size:12px; }
.res-row button { background:var(--bg3); border:1px solid var(--border);
  color:var(--fg); padding:3px 8px; border-radius:var(--radius);
  cursor:pointer; font:inherit; font-size:11px; }
.res-row button:hover { border-color:var(--accent); color:var(--accent); }
.res-tb { display:flex; gap:8px; padding:12px 16px;
  border-bottom:1px solid var(--border); }
.res-tb button { background:var(--bg3); border:1px solid var(--border); color:var(--fg);
  padding:4px 10px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
.res-tb button:hover { border-color:var(--accent); }

/* ── Invoke panel ── */
#invoke-panel { overflow-y:auto; padding:12px 16px; }
.inv-hdr { margin-bottom:12px; display:flex; align-items:center; gap:8px; }
.inv-hdr button { background:var(--bg3); border:1px solid var(--border); color:var(--fg);
  padding:4px 10px; border-radius:var(--radius); cursor:pointer; font:inherit; font-size:12px; }
.inv-form { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); padding:14px; margin-bottom:12px; }
.inv-form label { display:block; color:var(--fg2); font-size:11px;
  margin-bottom:4px; margin-top:10px; }
.inv-form label:first-child { margin-top:0; }
.inv-form input, .inv-form textarea, .inv-form select {
  width:100%; background:var(--bg); border:1px solid var(--border);
  color:var(--fg); padding:6px 8px; border-radius:var(--radius); font:inherit; font-size:12px; }
.inv-form textarea { min-height:80px; resize:vertical; }
.inv-form .btn-row { margin-top:12px; display:flex; gap:8px; }
.inv-form button { padding:5px 14px; border-radius:var(--radius);
  cursor:pointer; font:inherit; font-size:12px; border:1px solid var(--border); }
.inv-exec { background:var(--accent); color:var(--bg); border-color:var(--accent); font-weight:600; }
.inv-exec:hover { opacity:.9; }
#inv-result { background:var(--bg2); border:1px solid var(--border);
  border-radius:var(--radius); padding:12px; white-space:pre-wrap;
  word-break:break-all; max-height:50vh; overflow-y:auto; font-size:12px; }
#inv-result.err { border-color:var(--red); color:var(--red); }
.empty { color:var(--fg2); text-align:center; padding:48px 16px; font-size:12px; }
</style>
</head>
<body>

<header>
  <h1>LDK</h1>
  <nav>
    <button class="tab active" data-tab="logs">Logs</button>
    <button class="tab" data-tab="resources">Resources</button>
    <button class="tab" data-tab="invoke">Invoke</button>
  </nav>
  <span id="ws-dot" class="ws-dot off" title="WebSocket disconnected"></span>
</header>

<main>
  <!-- Logs panel -->
  <div id="logs" class="panel active">
    <div class="toolbar">
      <button id="btn-pause">Pause</button>
      <button id="btn-clear">Clear</button>
      <div class="tb-sep"></div>
      <select id="lv-filter">
        <option value="DEBUG">All levels</option>
        <option value="INFO" selected>INFO+</option>
        <option value="WARNING">WARN+</option>
        <option value="ERROR">ERROR+</option>
      </select>
      <select id="iam-filter">
        <option value="all">All requests</option>
        <option value="iam">IAM events only</option>
        <option value="deny">IAM DENY only</option>
      </select>
      <input id="svc-filter" placeholder="Filter service/op…" autocomplete="off">
      <span class="tb-count" id="ev-count">0 entries</span>
    </div>
    <div id="event-list"></div>
    <div id="detail-panel">
      <div class="detail-hdr">
        <div class="detail-hdr-title" id="detail-title"></div>
        <button class="detail-close" id="btn-detail-close" title="Close">✕</button>
      </div>
      <div class="detail-body" id="detail-body"></div>
    </div>
  </div>

  <!-- Resources panel -->
  <div id="resources" class="panel">
    <div class="res-tb">
      <button id="btn-refresh">Refresh</button>
    </div>
    <div id="resources-panel" class="panel active" style="overflow-y:auto;padding-bottom:16px;">
      <div class="empty">Loading resources…</div>
    </div>
  </div>

  <!-- Invoke panel -->
  <div id="invoke" class="panel">
    <div id="invoke-panel">
      <div class="empty">Select an action from the Resources tab.</div>
    </div>
  </div>
</main>

<script>
(function() {
"use strict";

// ── State ────────────────────────────────────────────────────────────────────
let ws = null;
let paused = false;
let allEntries = [];      // every entry received
let selIdx = -1;          // index into allEntries of selected event row
let resourceData = null;
let statusData = null;
let invokeContexts = [];
const LEVEL_ORDER = {DEBUG:0,INFO:1,WARNING:2,ERROR:3,CRITICAL:4};
const BASE = window.location.origin;

// ── Tabs ─────────────────────────────────────────────────────────────────────
document.querySelectorAll('.tab').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.tab').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('[id][class~="panel"]').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById(btn.dataset.tab).classList.add('active');
    if (btn.dataset.tab === 'resources') loadResources();
  });
});

// ── Helpers ───────────────────────────────────────────────────────────────────
function esc(s) {
  const d = document.createElement('div');
  d.textContent = String(s == null ? '' : s);
  return d.innerHTML;
}

function fmt(s) {
  if (!s) return s;
  try { return JSON.stringify(JSON.parse(s), null, 2); } catch(_) { return s; }
}

function svcClass(svc) {
  if (!svc) return 'svc-other';
  return 'svc-' + svc.toLowerCase().replace(/[^a-z0-9]/g, '');
}

function statusClass(code) {
  const s = String(code || '');
  return s.startsWith('2') ? 's-2xx' : s.startsWith('4') ? 's-4xx' : 's-5xx';
}

function methodClass(m) {
  return 'm-' + (m || 'get').toLowerCase();
}

function isRequest(e) { return e.method && e.path && e.status_code !== undefined; }

// ── Filter logic ──────────────────────────────────────────────────────────────
function passesFilter(entry) {
  const minLv = LEVEL_ORDER[document.getElementById('lv-filter').value] || 0;
  const entryLv = LEVEL_ORDER[entry.level] || 0;
  if (entryLv < minLv) return false;

  const iamF = document.getElementById('iam-filter').value;
  if (iamF === 'iam' && !entry.iam_eval) return false;
  if (iamF === 'deny' && !(entry.iam_eval && entry.iam_eval.decision === 'DENY')) return false;

  const svcF = document.getElementById('svc-filter').value.trim().toLowerCase();
  if (svcF) {
    const haystack = ((entry.service||'') + ' ' + (entry.handler||'') +
                      ' ' + (entry.message||'')).toLowerCase();
    if (!haystack.includes(svcF)) return false;
  }
  return true;
}

// ── IAM badge HTML ────────────────────────────────────────────────────────────
function iamBadgeHtml(iam) {
  if (!iam) return '';
  if (iam.decision === 'ALLOW')
    return ' <span class="badge iam-allow">✓ IAM</span>';
  if (iam.mode === 'enforce')
    return ' <span class="badge iam-deny">✗ IAM</span>';
  return ' <span class="badge iam-audit">⚠ IAM</span>';
}

// ── Render event row ──────────────────────────────────────────────────────────
function makeEventRow(entry, globalIdx) {
  const div = document.createElement('div');
  div.className = 'ev-row';
  div.dataset.gidx = globalIdx;

  const svc = entry.service || '';
  const op  = entry.handler || entry.path || '';
  const dur = entry.duration_ms != null ? Math.round(entry.duration_ms) + 'ms' : '';

  div.innerHTML =
    '<span class="ev-ts">' + esc(entry.timestamp||'') + '</span>' +
    '<span class="badge ' + methodClass(entry.method) + '">' + esc(entry.method||'') + '</span>' +
    '<span class="badge svc-badge ' + svcClass(svc) + '">' + esc(svc.toUpperCase()||'SYS') + '</span>' +
    '<span class="ev-op">' + esc(op) + '</span>' +
    '<span class="badge ' + statusClass(entry.status_code) + '">' +
      esc(String(entry.status_code||'')) + '</span>' +
    iamBadgeHtml(entry.iam_eval) +
    '<span class="ev-dur">' + esc(dur) + '</span>';

  div.addEventListener('click', () => selectRow(globalIdx));
  return div;
}

// ── Render text log row ───────────────────────────────────────────────────────
function makeLogRow(entry) {
  const div = document.createElement('div');
  div.className = 'log-row';
  div.dataset.level = entry.level || 'INFO';
  const lv = entry.level || 'INFO';
  div.innerHTML =
    '<span class="ts">[' + esc(entry.timestamp||'') + ']</span> ' +
    '<span class="lvl-' + esc(lv) + '">' + esc(lv) + '</span> ' +
    esc(entry.message||'');
  return div;
}

// ── Append a single entry to the list ────────────────────────────────────────
function appendEntry(entry) {
  if (!passesFilter(entry)) return;
  const gidx = allEntries.indexOf(entry);
  const el = isRequest(entry) ? makeEventRow(entry, gidx) : makeLogRow(entry);
  el.dataset.gidx = gidx;
  document.getElementById('event-list').appendChild(el);
  updateCount();
  if (!paused) el.scrollIntoView({block:'nearest'});
}

function updateCount() {
  const n = document.getElementById('event-list').children.length;
  document.getElementById('ev-count').textContent = n + (n===1?' entry':' entries');
}

function rerender() {
  const list = document.getElementById('event-list');
  list.innerHTML = '';
  selIdx = -1;
  closeDetail();
  allEntries.forEach(e => appendEntry(e));
}

// ── WebSocket ─────────────────────────────────────────────────────────────────
function connectWs() {
  const proto = location.protocol === 'https:' ? 'wss:' : 'ws:';
  ws = new WebSocket(proto + '//' + location.host + '/_ldk/ws/logs');
  ws.onopen = () => {
    const d = document.getElementById('ws-dot');
    d.className = 'ws-dot on'; d.title = 'WebSocket connected';
  };
  ws.onclose = () => {
    const d = document.getElementById('ws-dot');
    d.className = 'ws-dot off'; d.title = 'WebSocket disconnected';
    setTimeout(connectWs, 2000);
  };
  ws.onerror = () => ws.close();
  ws.onmessage = (e) => {
    try {
      const entry = JSON.parse(e.data);
      allEntries.push(entry);
      if (allEntries.length > 2000) allEntries = allEntries.slice(-1500);
      appendEntry(entry);
    } catch(_) {}
  };
}

// ── Toolbar controls ──────────────────────────────────────────────────────────
document.getElementById('btn-pause').addEventListener('click', function() {
  paused = !paused;
  this.textContent = paused ? 'Resume' : 'Pause';
});
document.getElementById('btn-clear').addEventListener('click', () => {
  allEntries = [];
  document.getElementById('event-list').innerHTML = '';
  selIdx = -1;
  closeDetail();
  updateCount();
});
document.getElementById('lv-filter').addEventListener('change', rerender);
document.getElementById('iam-filter').addEventListener('change', rerender);
let svcFilterTimer;
document.getElementById('svc-filter').addEventListener('input', () => {
  clearTimeout(svcFilterTimer);
  svcFilterTimer = setTimeout(rerender, 200);
});

connectWs();

// ── Detail panel ──────────────────────────────────────────────────────────────
function selectRow(gidx) {
  // Deselect previous
  document.querySelectorAll('.ev-row.sel').forEach(r => r.classList.remove('sel'));
  selIdx = gidx;
  const row = document.querySelector('.ev-row[data-gidx="' + gidx + '"]');
  if (row) { row.classList.add('sel'); }
  renderDetail(allEntries[gidx]);
}

function closeDetail() {
  document.getElementById('detail-panel').classList.remove('open');
  document.querySelectorAll('.ev-row.sel').forEach(r => r.classList.remove('sel'));
  selIdx = -1;
}

document.getElementById('btn-detail-close').addEventListener('click', closeDetail);

function kv(key, val, extraStyle) {
  return '<div class="det-kv-item"><div class="det-kv-key">' + esc(key) +
    '</div><div class="det-kv-val"' + (extraStyle ? ' style="' + extraStyle + '"' : '') +
    '>' + esc(val) + '</div></div>';
}

function renderDetail(entry) {
  if (!entry) return;
  const panel = document.getElementById('detail-panel');
  panel.classList.add('open');

  // ── Header / breadcrumb ──────────────────────────────────────────────
  const title = document.getElementById('detail-title');
  if (isRequest(entry)) {
    const sc = String(entry.status_code || '');
    title.innerHTML =
      (entry.service
        ? '<span class="badge svc-badge ' + svcClass(entry.service) + '">' +
          esc(entry.service.toUpperCase()) + '</span>'
        : '') +
      ' <span class="badge ' + methodClass(entry.method) + '">' + esc(entry.method||'') + '</span>' +
      ' <span style="color:var(--fg2);font-size:12px">' + esc(entry.handler||entry.path||'') + '</span>' +
      ' <span style="color:var(--fg3)">→</span>' +
      ' <span class="badge ' + statusClass(entry.status_code) + '">' + esc(sc) + '</span>' +
      iamBadgeHtml(entry.iam_eval) +
      (entry.duration_ms != null
        ? ' <span style="color:var(--fg2);font-size:11px">' +
          Math.round(entry.duration_ms) + 'ms</span>'
        : '');
  } else {
    title.textContent = entry.message || '';
  }

  // ── Body sections ───────────────────────────────────────────────────
  let html = '';

  // Overview
  html += '<div class="det-section"><div class="det-section-title">Overview</div>';
  html += '<div class="det-kv">';
  if (entry.timestamp) html += kv('Time', entry.timestamp);
  if (entry.service)   html += kv('Service', entry.service);
  if (entry.method)    html += kv('Method', entry.method);
  if (entry.path)      html += kv('Path', entry.path);
  if (entry.status_code != null) html += kv('Status', String(entry.status_code));
  if (entry.duration_ms != null) html += kv('Duration', Math.round(entry.duration_ms) + 'ms');
  html += '</div></div>';

  // IAM Evaluation
  if (entry.iam_eval) {
    const iam = entry.iam_eval;
    const dec = iam.decision || '';
    const mode = iam.mode || '';
    let decStyle = '';
    let decIcon = '';
    if (dec === 'ALLOW') { decStyle = 'color:var(--green)'; decIcon = '✓ '; }
    else if (mode === 'enforce') { decStyle = 'color:var(--red)'; decIcon = '✗ '; }
    else { decStyle = 'color:var(--yellow)'; decIcon = '⚠ '; }

    html += '<div class="det-section"><div class="det-section-title">IAM Evaluation</div>';
    html += '<div class="det-kv">';
    html += kv('Identity', iam.identity || '—');
    html += kv('Decision', decIcon + dec + ' (' + mode + ')', decStyle);
    if (iam.reason) html += kv('Reason', iam.reason);
    if (iam.actions && iam.actions.length)
      html += kv('Actions', iam.actions.join(', '));
    html += '</div></div>';
  }

  // Request
  if (entry.request_body) {
    html += '<div class="det-section"><div class="det-section-title">Request</div>';
    html += '<pre class="det-pre">' + esc(fmt(entry.request_body)) + '</pre></div>';
  }

  // Response
  if (entry.response_body) {
    html += '<div class="det-section"><div class="det-section-title">Response</div>';
    html += '<pre class="det-pre">' + esc(fmt(entry.response_body)) + '</pre></div>';
  }

  // For non-request entries that have no structured body, show the full message
  if (!isRequest(entry) && !entry.request_body && !entry.response_body) {
    html += '<div class="det-section"><div class="det-section-title">Message</div>';
    html += '<pre class="det-pre">' + esc(entry.message||'') + '</pre></div>';
  }

  document.getElementById('detail-body').innerHTML = html;
}

// ── Resources ─────────────────────────────────────────────────────────────────
async function loadResources() {
  const panel = document.getElementById('resources-panel');
  try {
    const [r, s] = await Promise.all([
      fetch(BASE + '/_ldk/resources'), fetch(BASE + '/_ldk/status')
    ]);
    resourceData = await r.json();
    statusData = await s.json();
    renderResources(panel);
  } catch(err) {
    panel.innerHTML = '<div class="empty">Failed to load: ' + esc(err.message) + '</div>';
  }
}

function renderResources(panel) {
  if (!resourceData || !resourceData.services) {
    panel.innerHTML = '<div class="empty">No resources found.</div>';
    return;
  }
  invokeContexts = [];
  const health = {};
  if (statusData && statusData.providers)
    statusData.providers.forEach(p => { health[p.name] = p.healthy; });

  let html = '';
  for (const [svc, info] of Object.entries(resourceData.services)) {
    const h = health[svc];
    const hClass = h === true ? 'healthy' : h === false ? 'unhealthy' : '';
    const hText  = h === true ? '● healthy' : h === false ? '● unhealthy' : '';
    html += '<div class="svc-group">';
    html += '<div class="svc-head" data-toggle="svc">';
    html += '<span class="arrow">&#9654;</span> ';
    html += '<span class="svc-name">' + esc(svc) + '</span>';
    html += '<span class="svc-port">:' + (info.port||'?') + '</span>';
    if (hText) html += '<span class="svc-health ' + hClass + '">' + hText + '</span>';
    html += '</div><div class="svc-body">';
    if (info.resources && info.resources.length) {
      info.resources.forEach(res => {
        const name = res.name || res.path || '(unnamed)';
        html += '<div class="res-row"><span class="rn">' + esc(name) + '</span>';
        getOps(svc, res).forEach(op => {
          const idx = invokeContexts.length;
          invokeContexts.push({service:svc, port:info.port, resource:res, operation:op});
          html += '<button data-invoke="' + idx + '">' + esc(op) + '</button>';
        });
        html += '</div>';
      });
    } else {
      html += '<div class="res-row"><span class="rn" style="color:var(--fg2)">No resources</span></div>';
    }
    html += '</div></div>';
  }
  panel.innerHTML = html || '<div class="empty">No services running.</div>';
}

panel_el_res = document.getElementById('resources-panel');
panel_el_res.addEventListener('click', function(e) {
  const toggle = e.target.closest('[data-toggle="svc"]');
  if (toggle) {
    const arrow = toggle.querySelector('.arrow');
    if (arrow) arrow.classList.toggle('open');
    const body = toggle.nextElementSibling;
    if (body) body.style.display = body.style.display === 'none' ? '' : 'none';
    return;
  }
  const btn = e.target.closest('[data-invoke]');
  if (btn) {
    const ctx = invokeContexts[parseInt(btn.dataset.invoke, 10)];
    if (ctx) openInvoke(ctx);
  }
});

document.getElementById('btn-refresh').addEventListener('click', loadResources);

function getOps(svc, res) {
  switch(svc) {
    case 'dynamodb':     return ['Scan','GetItem','PutItem','DeleteItem'];
    case 'sqs':          return ['SendMessage','ReceiveMessage','PurgeQueue'];
    case 's3':           return ['ListObjects','GetObject','PutObject','DeleteObject'];
    case 'sns':          return ['Publish','ListSubscriptions'];
    case 'events':       return ['PutEvents','ListRules'];
    case 'stepfunctions':return ['StartExecution','ListExecutions'];
    case 'cognito-idp':  return ['ListUsers'];
    case 'apigateway':   return ['TestInvoke'];
    default:             return [];
  }
}

// ── Invoke ────────────────────────────────────────────────────────────────────
function openInvoke(ctx) {
  document.querySelectorAll('.tab').forEach(b => b.classList.remove('active'));
  document.querySelectorAll('[id][class~="panel"]').forEach(p => p.classList.remove('active'));
  document.querySelector('[data-tab="invoke"]').classList.add('active');
  document.getElementById('invoke').classList.add('active');
  renderInvoke(ctx);
}

function renderInvoke(ctx) {
  const ic = document.getElementById('invoke-panel');
  const svc = ctx.service, op = ctx.operation, res = ctx.resource;
  const resName = res.name || res.path || '';
  ic.innerHTML =
    '<div class="inv-hdr"><button id="btn-inv-back">← Back</button>' +
    '<strong>' + esc(svc.toUpperCase()) + '</strong> → ' +
    '<strong>' + esc(op) + '</strong> on <em>' + esc(resName) + '</em></div>' +
    '<div class="inv-form" id="inv-form">' + buildFields(svc, op, res) +
    '<div class="btn-row"><button class="inv-exec" id="btn-inv-exec">Execute</button></div></div>' +
    '<div id="inv-result" style="display:none"></div>';

  document.getElementById('btn-inv-back').addEventListener('click', () => {
    document.querySelector('[data-tab="resources"]').click();
  });
  document.getElementById('btn-inv-exec').addEventListener('click', () => runInvoke(ctx));
}

function buildFields(svc, op, res) {
  let h = '';
  switch(svc) {
    case 'dynamodb':
      if (op === 'Scan') return '';
      h += '<label>Key (JSON)</label><textarea id="f-key"></textarea>';
      if (op === 'PutItem') { h = '<label>Item (JSON)</label><textarea id="f-item"></textarea>'; }
      return h;
    case 'sqs':
      if (op === 'SendMessage')
        return '<label>Message Body</label><textarea id="f-body"></textarea>';
      return '';
    case 's3':
      if (op === 'GetObject' || op === 'DeleteObject')
        return '<label>Object Key</label><input id="f-key" placeholder="path/to/object.txt">';
      if (op === 'PutObject')
        return '<label>Object Key</label><input id="f-key" placeholder="path/to/object.txt">' +
               '<label>Body</label><textarea id="f-body"></textarea>';
      return '';
    case 'sns':
      if (op === 'Publish')
        return '<label>Message</label><textarea id="f-body"></textarea>' +
               '<label>Subject (optional)</label><input id="f-subject">';
      return '';
    case 'events':
      if (op === 'PutEvents')
        return '<label>Event Entry (JSON)</label><textarea id="f-body"></textarea>';
      return '';
    case 'stepfunctions':
      if (op === 'StartExecution')
        return '<label>Input (JSON)</label><textarea id="f-body" placeholder="{}"></textarea>';
      return '';
    case 'apigateway':
      return '<label>Method</label><input id="f-method" value="' + esc(res.method||'GET') + '">' +
             '<label>Path</label><input id="f-path" value="' + esc(res.path||'/') + '">' +
             '<label>Body (optional)</label><textarea id="f-body"></textarea>';
    default: return '';
  }
}

async function runInvoke(ctx) {
  const el = document.getElementById('inv-result');
  el.style.display = 'block'; el.className = ''; el.textContent = 'Executing…';
  try {
    const req = buildReq(ctx);
    const resp = await fetch(BASE + '/_ldk/service-proxy', {
      method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(req)
    });
    const data = await resp.json();
    if (data.status >= 400) el.className = 'err';
    let body = data.body || '';
    try { body = JSON.stringify(JSON.parse(body), null, 2); } catch(_) {}
    el.textContent = 'Status: ' + data.status + '\\n\\n' + body;
  } catch(err) {
    el.className = 'err'; el.textContent = 'Error: ' + err.message;
  }
}

function val(id) { const e = document.getElementById(id); return e ? e.value : ''; }

function buildReq(ctx) {
  const {service:svc, operation:op, resource:res, port} = ctx;
  const base = 'http://localhost:' + port;
  switch(svc) {
    case 'dynamodb': {
      const body = {TableName:res.name};
      if (op === 'GetItem'||op === 'DeleteItem') body.Key = JSON.parse(val('f-key')||'{}');
      if (op === 'PutItem') body.Item = JSON.parse(val('f-item')||'{}');
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'DynamoDB_20120810.'+op,
        'Content-Type':'application/x-amz-json-1.0'}, body:JSON.stringify(body)};
    }
    case 'sqs': {
      const qurl = res.queue_url||(base+'/000000000000/'+res.name);
      let p = 'Action='+op+'&QueueUrl='+encodeURIComponent(qurl);
      if (op === 'SendMessage') p += '&MessageBody='+encodeURIComponent(val('f-body')||'');
      return {method:'POST', url:base+'/', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:p};
    }
    case 's3': {
      const b = res.name;
      if (op === 'ListObjects')  return {method:'GET',    url:base+'/'+b+'?list-type=2', headers:{}, body:''};
      if (op === 'GetObject')    return {method:'GET',    url:base+'/'+b+'/'+val('f-key'), headers:{}, body:''};
      if (op === 'PutObject')    return {method:'PUT',    url:base+'/'+b+'/'+val('f-key'),
        headers:{'Content-Type':'application/octet-stream'}, body:val('f-body')||''};
      if (op === 'DeleteObject') return {method:'DELETE', url:base+'/'+b+'/'+val('f-key'), headers:{}, body:''};
      break;
    }
    case 'sns': {
      const arn = res.arn||'';
      let p = 'Action='+op+'&TopicArn='+encodeURIComponent(arn);
      if (op === 'Publish') {
        p += '&Message='+encodeURIComponent(val('f-body')||'');
        const subj = val('f-subject');
        if (subj) p += '&Subject='+encodeURIComponent(subj);
      }
      return {method:'POST', url:base+'/', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:p};
    }
    case 'events': {
      let body = {};
      if (op === 'PutEvents') {
        let entry = JSON.parse(val('f-body')||'{}');
        if (!entry.EventBusName) entry.EventBusName = res.arn||res.name;
        body = {Entries:[entry]};
      } else if (op === 'ListRules') { body = {EventBusName:res.arn||res.name}; }
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'AWSEvents.'+op,'Content-Type':'application/x-amz-json-1.1'},
        body:JSON.stringify(body)};
    }
    case 'stepfunctions': {
      const arn = res.arn||'';
      const body = op === 'StartExecution'
        ? {stateMachineArn:arn, input:val('f-body')||'{}'}
        : {stateMachineArn:arn};
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'AWSStepFunctions.'+op,'Content-Type':'application/x-amz-json-1.0'},
        body:JSON.stringify(body)};
    }
    case 'cognito-idp':
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'AWSCognitoIdentityProviderService.'+op,
        'Content-Type':'application/x-amz-json-1.1'},
        body:JSON.stringify({UserPoolId:res.user_pool_id||''})};
    case 'apigateway':
      return {method:val('f-method')||'GET', url:base+(val('f-path')||'/'),
        headers:{'Content-Type':'application/json'}, body:val('f-body')||''};
  }
  return {method:'GET', url:base+'/', headers:{}, body:''};
}

})();
</script>
</body>
</html>
"""


def get_dashboard_html() -> HTMLResponse:
    """Return the LDK dashboard as a self-contained HTML page."""
    return HTMLResponse(content=_DASHBOARD_HTML)
