function Find-AndNavigateDirectory
{
  param(
    [string]$BaseDirectory = "D:\sme"
  )

  $requiredTools = @('fzf', 'fd', 'eza')
  foreach($tool in $requiredTools)
  {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue))
    {
      Write-Error "$tool is not installed. Please install it first (eg,. using 'scoop install $tool')"
      return
    }
  }

  # Use fd to find directories (much faster than Get-ChildItem)
  # -t d flag tells fd to only look for directories
  # --hidden includes hiddent directories
  # --follow follows symlinks
  $directories = fd -t d --hidden --follow --exclude node_modules . $BaseDirectory

  if(-not $directories)
  {
    Write-Error "No directories found in $BaseDirectory"
  }

  # Using fzf with eza preview
  # --icons shows icons for file types
  # --git shows git status
  # -T -L 2 shows tree with depth of 2
  # --color=always forces colored output
  $selected = $directories | fzf --layout=reverse --border `
    --preview 'eza --icons --git -T -L 2 --color=always {}' `
    --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up'

  # Navigate to the selected directory if one was chosen
  if($selected)
  {
    Set-Location $selected
  }
}

function Find-Files
{
  param(
    [string]$BaseDirectory = "D:\sme",
    [switch]$Content,
    [string]$FilePattern = ""
  )

  $requiredTools = @('fzf', 'fd', 'bat')
  foreach($tool in $requiredTools)
  {
    if (-not (Get-Command $tool -ErrorAction SilentlyContinue))
    {
      Write-Error "$tool is not installed. Please install it first (eg,. using 'scoop install $tool')"
      return
    }
  }

  if($Content)
  {
    if (-not (Get-Command rg -ErrorAction SilentlyContinue))
    {
      Write-Error "ripgrep (rg) is not installed. Please install it first (eg,. using 'scoop install ripgrep')"
      return
    }

    rg --color=always --line-number --no-heading --column --smart-case "" $BaseDirectory |
      fzf --layout=reverse --border `
        --delimiter ':' `
        --ansi `
        --preview 'bat --color=always {1}:{2} --highlight-line {3} --style=numbers' `
        --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' `
        --bind 'enter:become(nvim +{3} {1}:{2})'
  } else
  {
    $fdCmd = "fd --hidden --follow"
    if($FilePattern)
    {
      $fdCmd +=   " -e $($FilePattern.TrimStart('*.'))"
    }

    Invoke-Expression "$fdCmd . $BaseDirectory" |
      fzf --layout=reverse --border `
        --preview 'bat {} --style=numbers --color=always' `
        --bind 'ctrl-d:preview-page-down,ctrl-u:preview-page-up' `
        --bind 'enter:become(nvim {})' `
        --header 'Enter: Open in Neovim, Ctrl-D/U: Scroll preview'

  }
}

function Find-FileContent
{
  param(
    [string]$BaseDirectory = "D:\sme"
  )

  Find-Files -Content -BaseDirectory $BaseDirectory
}

function Set-LsAlias
{
  eza --colour=always --icons=always --long --no-filesize --no-time --no-user --no-permissions --git $args
}

# Create alias sd (search directory)
Set-Alias -Name sd -Value Find-AndNavigateDirectory

# Create aliases for sg (search grep) and sf (search file)
Set-Alias -Name sf -Value Find-Files
Set-Alias -Name sg -Value Find-FileContent

# Eza instead of Get-ChildItem
Set-Alias -Name ls -Value Set-LsAlias 

# Starship prompt
Invoke-Expression (&starship init powershell)

# carapace.sh autocompletion
$env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
carapace _carapace | Out-String | Invoke-Expression

