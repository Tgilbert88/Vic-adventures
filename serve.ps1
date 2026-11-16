# Local preview server for Vic Outdoors.
# Run: powershell -NoProfile -ExecutionPolicy Bypass -File serve.ps1   then open http://localhost:8790/
$root = [IO.Path]::GetFullPath($PSScriptRoot)
$port = 8790
$types = @{ '.html' = 'text/html; charset=utf-8'; '.js' = 'application/javascript; charset=utf-8'; '.css' = 'text/css; charset=utf-8';
            '.json' = 'application/json'; '.png' = 'image/png'; '.svg' = 'image/svg+xml'; '.md' = 'text/plain; charset=utf-8' }
$l = New-Object System.Net.HttpListener
$l.Prefixes.Add("http://localhost:$port/")
$l.Start()
Write-Host "Vic Outdoors on http://localhost:$port/"
while ($true) {
  try {
    $ctx = $l.GetContext(); $res = $ctx.Response
    $rel = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath).TrimStart('/')
    if ($rel -match '^(camp|snorkel)$') { $res.Redirect("/$rel/"); $res.Close(); continue }
    if ($rel -eq '' -or $rel.EndsWith('/')) { $rel += 'index.html' }
    $file = [IO.Path]::GetFullPath((Join-Path $root $rel))
    if ($file.StartsWith($root, [StringComparison]::OrdinalIgnoreCase) -and (Test-Path $file -PathType Leaf) -and $rel -notmatch '\.ps1$') {
      $bytes = [IO.File]::ReadAllBytes($file)
      $ext = [IO.Path]::GetExtension($file).ToLower()
      $res.ContentType = $(if ($types[$ext]) { $types[$ext] } else { 'application/octet-stream' })
      $res.Headers.Add('Cache-Control', 'no-cache')
      $res.OutputStream.Write($bytes, 0, $bytes.Length)
    } else { $res.StatusCode = 404 }
    $res.Close()
  } catch { }
}
