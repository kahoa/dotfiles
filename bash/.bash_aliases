copy_from_windows() {
    if [ -z "$1" ]; then
        echo "Usage: copy_from_windows <path>"
        return 1
    fi

    # Use double quotes to handle paths with spaces
    src=$(wslpath "$1")
    cp -- "$src" .
}

mcd() {
	mkdir -p "$1" && cd -- "$1"
}

connect_ec2() {
    if [ -z "$1" ]; then
        echo "Usage: connect_ec2 <ec2-instance-hostname>"
        return 1
    fi

    local host="$1"
    ssh "$host"
    
    if [ $? -ne 0 ]; then
        echo "Failed to connect to $host"
        echo "To insert your public key into the authorized_keys file on the EC2 instance, follow these steps:"
        echo "1. Connect to the EC2 instance using an existing method (e.g., an existing key or AWS EC2 Instance Connect)."
        echo "2. On the EC2 instance, run the following commands:"
        echo "   mkdir -p ~/.ssh"
	echo -n "   echo "
	tr -s '\n' ' ' < ~/.ssh/my_aws_key.pub
	echo " >> ~/.ssh/authorized_keys"
        echo "   chmod 700 ~/.ssh"
        echo "   chmod 600 ~/.ssh/authorized_keys"
        echo "3. Try connecting again:"
        echo "   connect_ec2 $host"
    fi
}

react() {
	npx create-react-app $*
}
