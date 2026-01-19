# Hex-encoded ciphertext and the keyword for XOR decryption
hex_string = '2407533d451a450d1c43110a1849041d1909533502135215040244450c1b1654140e06540a1941184c1401110549071b19001f181c524b08000f010b0a493e1d0e151f150b52410718061a5a4d281d104d14001d0b1500001f1009161e001d074d0c120d0717000802431b1c030a5d'
keyword = "master alchemist"

# Convert hex string to bytes
data_bytes = bytes.fromhex(hex_string)

# Generate the repeating XOR key from the keyword
key_bytes = (keyword * ((len(data_bytes) // len(keyword)) + 1)).encode()[:len(data_bytes)]

# Perform XOR decryption
decrypted_bytes = bytes([b ^ k for b, k in zip(data_bytes, key_bytes)])

# Convert the decrypted bytes to a readable string
decrypted_text = decrypted_bytes.decode(errors="ignore")
print(decrypted_text)
