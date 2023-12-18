import requests

def get_access_token(client_id, client_secret, tenant_id):
    token_url = f"https://login.microsoftonline.com/{MY_TENANT_ID}/oauth2/v2.0/token?Content-Type=application/x-www-form-urlencoded"
    
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
    }

    data = {
        "grant_type": "client_credentials",
        "client_id": MY_CLIENT_ID,
        "client_secret": MY_CLIENT_SECRET,
        "scope": "https://graph.microsoft.com/.default",
    }

    response = requests.post(token_url, headers=headers, data=data)
    response_data = response.json()

    if "access_token" in response_data:
        return response_data["access_token"]
    else:
        raise Exception("Failed to obtain access token")

def lambda_handler(event, context):
    client_id = "MY_CLIENT_ID"
    client_secret = "MY_CLIENT_SECRET"
    tenant_id = "MY_TENANT_ID"

    # Get a fresh access token k
    access_token = get_access_token(client_id, client_secret, tenant_id)

    # Now you can use the access_token in your Microsoft Graph API request

    # Microsoft Graph API endpoint for Intune actions
    graph_api_url = 'https://graph.microsoft.com/v1.0/deviceManagement/managedDevices/{DEVICE_ID}/wipe'
    
    # Construct headers with the new access token
    headers = {
        'Authorization': f'Bearer {access_token}',
        'Content-Type': 'application/json',
    }

    # Hardcoded payload for Intune action
    payload = {
        'key': 'value',
    }

    # Make a POST request to the Microsoft Graph API
    response = requests.post(graph_api_url, headers=headers, json=payload)

    # Handle the API response
    if response.status_code == 202:
        print('Intune action successful')
    else:
        print(f'Error: {response.status_code}, {response.text}')

    return {
        'statusCode': response.status_code,
        'body': response.text,
    }
