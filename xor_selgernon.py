def xor_encrypt(message, key):
    # Encrypt the message by XORing each character with the repeating key
    encrypted = []
    for i in range(len(message)):
        # XOR the character with the character in the key (repeating key if shorter than message)
        encrypted_char = ord(message[i]) ^ ord(key[i % len(key)])
        encrypted.append(encrypted_char)
    
    # Convert to hexadecimal for readability
    encrypted_hex = ''.join(format(x, '02x') for x in encrypted)
    return encrypted_hex

# Message and key
message = "If I help you with Agartha, are you okay with totally killing Mictlan after? And using assassins maybe in sync."
key = "master alchemist"

# Encrypt the message
encrypted_message = xor_encrypt(message, key)

print("Encrypted message in hex:", encrypted_message)

