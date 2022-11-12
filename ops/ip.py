import json
from requests import get

ip = get('https://api.ipify.org').content.decode('utf8')

output = {
    "current_ip_addr": f"{ip}"
}

output_json = json.dumps(output,indent=2)
print(output_json)