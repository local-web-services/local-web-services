"""Self-contained HTML dashboard for LDK.

Returns an ``HTMLResponse`` with inline CSS and JavaScript — no external
dependencies, no build step, works offline.
"""

from __future__ import annotations

from fastapi.responses import HTMLResponse

from lws.api._gui_config_routes import _DASHBOARD_CSS, _DASHBOARD_HTML_STRUCTURE
from lws.api._gui_provider_routes import _DASHBOARD_JS_INVOKE, _DASHBOARD_JS_RESOURCES

# ---------------------------------------------------------------------------
# Dashboard HTML assembled from modular parts
# ---------------------------------------------------------------------------

_DASHBOARD_HTML = (
    """\
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>LDK Dashboard</title>
"""
    + _DASHBOARD_CSS
    + _DASHBOARD_HTML_STRUCTURE
    + """\
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

"""
    + _DASHBOARD_JS_RESOURCES
    + _DASHBOARD_JS_INVOKE
    + """\
// ── Detail panel resize ───────────────────────────────────────────────────────
(function() {
  const handle = document.getElementById('detail-resize');
  const panel  = document.getElementById('detail-panel');
  let startY = 0, startH = 0, dragging = false;

  handle.addEventListener('mousedown', function(e) {
    e.preventDefault();
    dragging = true;
    startY = e.clientY;
    startH = panel.offsetHeight;
    handle.classList.add('dragging');
    document.body.style.cursor = 'ns-resize';
    document.body.style.userSelect = 'none';
  });

  document.addEventListener('mousemove', function(e) {
    if (!dragging) return;
    const delta = startY - e.clientY;   // drag up → taller
    const newH = Math.min(Math.max(startH + delta, 150), window.innerHeight * 0.85);
    panel.style.height = newH + 'px';
  });

  document.addEventListener('mouseup', function() {
    if (!dragging) return;
    dragging = false;
    handle.classList.remove('dragging');
    document.body.style.cursor = '';
    document.body.style.userSelect = '';
  });
})();

})();
</script>
</body>
</html>
"""
)


def get_dashboard_html() -> HTMLResponse:
    """Return the LDK dashboard as a self-contained HTML page."""
    return HTMLResponse(content=_DASHBOARD_HTML)
