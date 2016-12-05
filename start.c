/*
    C ECHO client example using sockets
*/
#include<stdio.h> //printf
#include<string.h>    //strlen
#include<sys/socket.h>    //socket
#include<arpa/inet.h> //inet_addr

int main(int argc , char *argv[])
{
    int sock;
    struct sockaddr_in server;
    char message[5] , server_reply[2000];

    //Create socket
    sock = socket(AF_INET , SOCK_STREAM , 0);
    if (sock == -1)
    {
        printf("Could not create socket");
    }
    puts("Socket created");

    server.sin_addr.s_addr = inet_addr("192.168.0.110");
    server.sin_family = AF_INET;
    server.sin_port = htons( 8090 );

    //Connect to remote server
    if (connect(sock , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
        perror("connect failed. Error");
        return 1;
    }

    puts("Connected\n");

    //keep communicating with server

      //  if (strcmp(argv[1],"i")==0) {
      //    strcpy(message,'i');
      //    printf("Iniciou %s\n",message );
      //  }else if (strcmp(argv[1],"p")==0) {
      //    strcpy(message,'p');
      //    printf("Parou %s\n",message );

      //  }else{
         printf("%s\n",argv[1] );
      //  }


        //Send some data
        if( send(sock , argv[1] , strlen(argv[1]) , 0) < 0)
        {
            puts("Send failed");
            return 1;
        }

        /*//Receive a reply from the server
        if( recv(sock , server_reply , 2000 , 0) < 0)
        {
            puts("recv failed");
        }

        puts("Server reply :");
        puts(server_reply);

        */
    close(sock);
    return 0;
}
