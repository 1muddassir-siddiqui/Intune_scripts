# Import the required AWS PowerShell module
Import-Module AWSPowerShell
# Import the AWS Secrets Manager module
Import-Module AWSPowerShell.SecretsManager

# Function to retrieve the Intune credentials from AWS Secrets Manager
function GetIntuneCredentials {
    # Retrieve the secret value from AWS Secrets Manager
    $secretName = "Wipe-PC-creds"  # Replace with your secret name
    $secretValue = Get-SecretValue -SecretId $secretName

    # Convert the secret value to a PowerShell object
    $secrets = ConvertFrom-Json -InputObject $secretValue.SecretString

    # Extract and return the Intune credentials
    $username = $secrets.username
    $password = $secrets.password

    return @{
        "username" = $username
        "password" = $password
    }
}

# Function to wipe a PC in Intune
function WipePC {
    param (
        [Parameter(Mandatory = $true)]
        [string]$deviceID
    )

    # Fetch the Intune credentials from AWS Secrets Manager
    $intuneCredentials = GetIntuneCredentials
    $username = $intuneCredentials.username
    $password = $intuneCredentials.password

    # Authenticate to Intune
    # Implement the authentication process using the retrieved credentials

    # Perform the "wipe PC" action in Intune using the device ID
    # Implement the necessary code to trigger the "wipe PC" action

    # Perform any additional actions or error handling as needed
}

# Lambda function handler
function Invoke-WipePCAction {
    param (
        $eventData,
        $context
    )

    # Retrieve the device ID from the event data
    $deviceID = $eventData.deviceID

    # Call the WipePC function to perform the "wipe PC" action in Intune
    WipePC -deviceID $deviceID
}

# Expose the Lambda function handler
Export-ModuleMember -Function Invoke-WipePCAction