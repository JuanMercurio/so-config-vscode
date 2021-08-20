#include "main.h"


int main(int argc, char* argv[]) {
   
   correr_tests(argc, argv[1]);    //solo corre si "argv[1]" es "test" (si el argumento que le pasas al binario en "test")
   
   while(1){
      helloWorld();
      sleep(2);
   }
   
   return 0;
}
