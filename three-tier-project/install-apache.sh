#!/bin/bash
sudo apt update -y
sleep 90
sudo systemctl start apache2.service
sudo systemctl enable apache2.service
user_data = base64encode("#!/bin/bash\necho 'Hello, World!' > /var/www/html/index.html")