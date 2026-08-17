resource "null_resource" "cluster" {
  count = (var.environment == "Prod") ? 3 : 1

  provisioner "file" {
    source      = "user-data.sh"
    destination = "/tmp/user-data.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("mum-kvpair.pem")
      host        = element(aws_instance.public-server.*.public_ip, count.index)
    }


  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/user-data.sh",
      "sudo sh /tmp/user-data.sh",
      "sudo apt update",
      "sudo apt install git unzip -y",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("mum-kvpair.pem")
      host        = element(aws_instance.public-server.*.public_ip, count.index)
    }
  }

}
