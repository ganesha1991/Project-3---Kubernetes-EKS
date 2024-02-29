import base64

password = "YvwjOC527e"
password_bytes = password.encode('utf-8')
base64_password = base64.b64encode(password_bytes).decode('utf-8')

print(base64_password)