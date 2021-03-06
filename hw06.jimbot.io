server {
    listen 80;
    listen [::]:80;

    server_name hw06.jimbot.io;

    location / {
        proxy_pass http://localhost:4710;
    }

    location /socket {
        proxy_pass http://localhost:4710;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
