<#
.SYNOPSIS
  Creates a DRAFT of the PULSE launch email in your own mailbox via Microsoft Graph,
  preserving the full HTML design (dark theme, buttons, images) with no copy/paste.

.DESCRIPTION
  Copy/pasting rich HTML into New Outlook strips backgrounds and button styling.
  This script instead stores the raw HTML directly as a draft message body, so when
  you open it in Outlook it renders exactly as designed. You then preview it, add
  recipients, and click Send yourself. Nothing is sent by this script.

.PARAMETER HtmlPath
  Path to the email HTML. Defaults to the pulse-launch.html next to this script.

.PARAMETER Subject
  Subject line for the draft.

.EXAMPLE
  .\send-draft.ps1
  Signs in, creates the draft, prints a link to open it.

.NOTES
  Requires delegated Mail.ReadWrite (interactive consent). No app registration needed
  if your tenant allows the first-party Microsoft Graph PowerShell app.
#>
[CmdletBinding()]
param(
  [string]$HtmlPath = (Join-Path $PSScriptRoot 'pulse-launch.html'),
  [string]$Subject  = 'PULSE is here - your weekly reporting, on autopilot'
)

$ErrorActionPreference = 'Stop'

# --- 1. Read the HTML ------------------------------------------------------
if (-not (Test-Path $HtmlPath)) {
  throw "HTML file not found: $HtmlPath"
}
$html = Get-Content -Path $HtmlPath -Raw -Encoding UTF8
Write-Host "Loaded email HTML ($([math]::Round($html.Length/1KB,1)) KB) from $HtmlPath" -ForegroundColor Cyan

# --- 2. Ensure Graph auth module -------------------------------------------
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Authentication)) {
  Write-Host "Installing Microsoft.Graph.Authentication (current user)..." -ForegroundColor Yellow
  Install-Module Microsoft.Graph.Authentication -Scope CurrentUser -Force -AllowClobber
}
Import-Module Microsoft.Graph.Authentication

# --- 3. Sign in (delegated) ------------------------------------------------
Write-Host "Signing in to Microsoft Graph (Mail.ReadWrite)..." -ForegroundColor Cyan
Connect-MgGraph -Scopes 'Mail.ReadWrite' -NoWelcome

$ctx = Get-MgContext
Write-Host "Signed in as: $($ctx.Account)" -ForegroundColor Green

# --- 4. Build the draft message --------------------------------------------
$message = @{
  subject = $Subject
  body    = @{
    contentType = 'HTML'
    content     = $html
  }
  # No toRecipients on purpose - you add them in Outlook before sending.
}

$json = $message | ConvertTo-Json -Depth 6

# --- 5. Create the draft ---------------------------------------------------
Write-Host "Creating draft in your mailbox..." -ForegroundColor Cyan
$draft = Invoke-MgGraphRequest -Method POST `
  -Uri 'https://graph.microsoft.com/v1.0/me/messages' `
  -Body $json -ContentType 'application/json'

Write-Host ""
Write-Host "Draft created successfully." -ForegroundColor Green
Write-Host "  Subject : $($draft.subject)"
Write-Host "  Draft id: $($draft.id)"
if ($draft.webLink) {
  Write-Host "  Open it : $($draft.webLink)" -ForegroundColor Yellow
}
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Open Outlook -> Drafts (or click the link above)."
Write-Host "  2. Review the rendered email (send yourself a test if you like)."
Write-Host "  3. Add your recipients / distribution list, then Send."
Write-Host ""
Write-Host "Tip: don't edit the body in the compose editor - just add recipients and Send," -ForegroundColor DarkGray
Write-Host "     so the HTML stays at full fidelity."
