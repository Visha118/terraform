🚀 Launch a Basic EC2 Instance (AWS)
Goal: Deploy a free-tier t2.micro EC2 instance in AWS.
Concepts Covered:
- Provider configuration
- Resource creation
- Outputs (e.g., IP address)

How to connect to ec2 instance?
Replace <EC2_PUBLIC_IP> with your created ec2 instance public ip (from terraform output variable `instance_public_ip` value) and run the below command in terminal
ssh -i terraform-key.pem ec2-user@<EC2_PUBLIC_IP>

Some linux commands to play with:
1. touch myfile.txt - to create an empty file
2. echo "Hello World" > myfile.txt - to create a file with some content
3. cat myfile.txt - To print the file content