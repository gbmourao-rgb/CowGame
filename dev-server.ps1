$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$port = 4173
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Parse("127.0.0.1"), $port)
$listener.Start()
Write-Host "Serving $root at http://127.0.0.1:$port/"

function Get-ContentType($file) {
  if ($file.EndsWith(".html")) { return "text/html; charset=utf-8" }
  if ($file.EndsWith(".js")) { return "application/javascript; charset=utf-8" }
  if ($file.EndsWith(".css")) { return "text/css; charset=utf-8" }
  return "application/octet-stream"
}

while ($true) {
  $client = $listener.AcceptTcpClient()
  try {
    $stream = $client.GetStream()
    $reader = [System.IO.StreamReader]::new($stream)
    $request = $reader.ReadLine()
    while ($reader.Peek() -ge 0) {
      $line = $reader.ReadLine()
      if ([string]::IsNullOrEmpty($line)) { break }
    }
    $target = "index.html"
    if ($request -match "^GET\s+([^\s]+)") {
      $target = [System.Uri]::UnescapeDataString($matches[1].TrimStart("/"))
      if ([string]::IsNullOrWhiteSpace($target)) { $target = "index.html" }
    }
    $safePath = $target -replace "/", [System.IO.Path]::DirectorySeparatorChar
    $file = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($root, $safePath))
    if (-not $file.StartsWith($root) -or -not [System.IO.File]::Exists($file)) {
      $body = [System.Text.Encoding]::UTF8.GetBytes("Not found")
      $head = "HTTP/1.1 404 Not Found`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
      $bytes = [System.Text.Encoding]::ASCII.GetBytes($head)
      $stream.Write($bytes, 0, $bytes.Length)
      $stream.Write($body, 0, $body.Length)
    } else {
      $body = [System.IO.File]::ReadAllBytes($file)
      $type = Get-ContentType $file
      $head = "HTTP/1.1 200 OK`r`nContent-Type: $type`r`nContent-Length: $($body.Length)`r`nConnection: close`r`n`r`n"
      $bytes = [System.Text.Encoding]::ASCII.GetBytes($head)
      $stream.Write($bytes, 0, $bytes.Length)
      $stream.Write($body, 0, $body.Length)
    }
  } finally {
    $client.Close()
  }
}
