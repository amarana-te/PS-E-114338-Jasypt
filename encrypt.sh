#!/bin/bash

# Prompt the user for the secret encryption password
echo -n "Enter the secret encryption password: "
read -s secret_password
echo  # Move to a new line

# Set environment variables
export JASYPT_ENCRYPTOR_PASSWORD="$secret_password"

# Prompt the user for the plain text password for Email
echo -n "Enter the plain text password for Email: "
read -s plain_text_password_email
echo  # Move to a new line

# Prompt the user for the plain text password for Zenoss
echo -n "Enter the plain text password for Zenoss: "
read -s plain_text_password_zenoss
echo  # Move to a new line

# Prompt the user for the plain text password for ThousandEyes
echo -n "Enter the plain text password for ThousandEyes: "
read -s plain_text_password_thousandeyes
echo  # Move to a new line

# Use Jasypt to encrypt the plain text password for Email and capture the output
encrypted_password_email=$(java -cp jasypt-1.9.3.jar org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="$plain_text_password_email" password="$secret_password" algorithm="PBEWithMD5AndDES" | awk '/^----OUTPUT/ { flag=1; next } flag { print }')

# Use Jasypt to encrypt the plain text password for Zenoss and capture the output
encrypted_password_zenoss=$(java -cp jasypt-1.9.3.jar org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="$plain_text_password_zenoss" password="$secret_password" algorithm="PBEWithMD5AndDES" | awk '/^----OUTPUT/ { flag=1; next } flag { print }')

# Use Jasypt to encrypt the plain text password for ThousandEyes and capture the output
encrypted_password_thousandeyes=$(java -cp jasypt-1.9.3.jar org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="$plain_text_password_thousandeyes" password="$secret_password" algorithm="PBEWithMD5AndDES" | awk '/^----OUTPUT/ { flag=1; next } flag { print }')

# Store the formatted encrypted passwords in a text file
echo "email: $encrypted_password_email" > encrypted_password.txt
echo "zenoss: $encrypted_password_zenoss" >> encrypted_password.txt
echo "thousandeyes: $encrypted_password_thousandeyes" >> encrypted_password.txt

# Provide feedback to the user
echo "Passwords encrypted and saved in encrypted_password.txt"
