Function Get-DatabricksWorkspaceConfig {
  <#
      .SYNOPSIS
      This request gets different information based on what you pass to keys parameter.
      .DESCRIPTION
      This request gets different information based on what you pass to keys parameter.
      Official API Documentation: https://docs.databricks.com/dev-tools/api/latest/token-management.html#operation/get-configuration
      .PARAMETER Keys 
      List of keys to retrieve from the workspace config.
      .EXAMPLE
      Get-DatabricksWorkspaceConfig -Keys "enableTokensConfig"
      .EXAMPLE
      Get-DatabricksWorkspaceConfig -Keys "enableIpAccessLists"
  #>
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true)] [ValidateSet("enableTokensConfig", "maxTokenLifetimeDays", "enableIpAccessLists")] [string] $Keys
  )
  begin {
    $requestMethod = "GET"
    $apiEndpoint = "/2.0/workspace-conf"
  }
	
  process {
    Write-Verbose "Building Body/Parameters for final API call ..."

    #Set parameters
    $parameters = @{
      keys = $Keys
    }

    $result = Invoke-DatabricksApiRequest -Method $requestMethod -EndPoint $apiEndpoint -Body $parameters

    return $result
  }
}


Function Set-DatabricksWorkspaceConfig {
  <#
			.SYNOPSIS
			This request sets different workspace settings based on the parameters that you set. For example, enable or disable personal access tokens, or set maximum token lifetime for new tokens. See parameters for details.
			.DESCRIPTION
			This request sets different workspace settings based on the parameters that you set. For example, enable or disable personal access tokens, or set maximum token lifetime for new tokens. See parameters for details.
			Official API Documentation: https://docs.databricks.com/dev-tools/api/latest/token-management.html#operation/set-configuration
			.PARAMETER EnableTokensConfig 
			Enable or disable personal access tokens for this workspace.
      .PARAMETER MaxTokenLifetimeDays 
			Maximum token lifetime of new tokens in days, as an integer. If zero, new tokens are permitted to have no lifetime limit. Negative numbers are unsupported. WARNING: This limit only applies to new tokens, so there may be tokens with lifetimes longer than this value, including unlimited lifetime. Such tokens may have been created before the current maximum token lifetime was set. To review existing tokens, see the get tokens API.
      .PARAMETER EnableIpAccessLists
			The IP access list feature is enabled for the workspace if true and it is disabled if false. Note that these are String values, not booleans.
			.EXAMPLE
			Add-DatabricksGlobalInitScript -Name "MyScript" -Script "echo Hello World" -AsPlainText -Position 1 -Enabled $true
	#>
  [CmdletBinding()]
  param
  (
    [Parameter(Mandatory = $false, Position = 1, ValueFromPipelineByPropertyName = $true)]  [boolean] $EnableTokensConfig,
    [Parameter(Mandatory = $false, Position = 2, ValueFromPipelineByPropertyName = $true)] [string] $MaxTokenLifetimeDays,
    [Parameter(Mandatory = $false, Position = 3, ValueFromPipelineByPropertyName = $false)] [boolean] $EnableIpAccessLists
  )
	
  begin {
    $requestMethod = "PATCH"
    $apiEndpoint = "/2.0/workspace-conf"
  }
	
  process {
    Write-Verbose "Building Body/Parameters for final API call ..."

    #Set parameters
    $parameters = @{
      enableTokensConfig = $EnableTokensConfig
      maxTokenLifetimeDays = $maxTokenLifetimeDays
      enableIpAccessLists = $EnableIpAccessLists
    }

    $result = Invoke-DatabricksApiRequest -Method $requestMethod -EndPoint $apiEndpoint -Body $parameters

    return $result
  }
}