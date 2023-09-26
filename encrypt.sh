#!/bin/bash

# Prompt the user for the secret encryption password
echo -n "Enter the secret encryption password: "
read -s secret_password
echo  # Move to a new line

# Prompt the user for the plain text password
echo -n "Enter the plain text password: "
read -s plain_text_password
echo  # Move to a new line

# Set environment variables
export JASYPT_SECRET_PASSWORD="$secret_password"
export JASYPT_PLAIN_TEXT_PASSWORD="$plain_text_password"

# Use Jasypt to encrypt the plain text password
encrypted_password=$(java -cp jasypt-1.9.3.jar org.jasypt.intf.cli.JasyptPBEStringEncryptionCLI input="$plain_text_password" password="$secret_password" algorithm="PBEWithMD5AndDES")

# Store the encrypted password in a text file
echo "$encrypted_password" > encrypted_password.txt

# Provide feedback to the user
echo "Password encrypted and saved in encrypted_password.txt"
